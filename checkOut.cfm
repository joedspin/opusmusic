<cfparam name="url.cart" default="checkout">
<cfset binsOnly="false">
<cfinclude template="checkOutPageHead.cfm">
<!---<p style="font-family: Arial, Helvetica, sans-serif; font-size: medium; color: #669933">This page has changed<br />
  <span style="font-size: small; color: #FFFFFF">Now you get real-time information about the In-Stock status of the items you are ordering.<br />
  Plus you can <span style="color: #669933">save for later</span> items you are not ready to buy now. They will be added to your <span style="color: #629131">Wish List</span>, where you can view them and add them to your cart for a future purchase. Find your <span style="color: #629131">Wish List</span> in the <span style="color: #629131">My Account</span> section.</span></p>//--->
<cfquery name="strippromo" datasource="#DSN#">
    	delete from orderItems
        where catItemID=74648
			AND orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
    </cfquery>

  <cfinclude template="cartGetContents.cfm">
  <!---<cfif Session.userID EQ 2342>
    <cfloop query="cartContents">
      <cfset itemID=ID>
      <cfquery name="checkPrice" datasource="#DSN#">
        select *
        from catItems
        where ID=
        <cfqueryparam value="#catItemID#" cfsqltype="cf_sql_integer">
      </cfquery>
      <cfquery name="fixPrice" datasource="#DSN#">
        update orderItems
        set price=
        <cfqueryparam value="#checkPrice.cost+0.50#" cfsqltype="cf_sql_money">
        where ID=
        <cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
      </cfquery>
    </cfloop>
    <cfquery name="cartContents" datasource="#DSN#">
      SELECT * from orderItemsQuery
      where orderID=
      <cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
      AND adminAvailID=2 AND statusID=1
    </cfquery>
  </cfif>//--->
  <cfparam name="Cookie.username" default="">
  
</p>
<p>&nbsp;</p>
<h4>Cart Contents</h4>
<cfset thisSub=0>
<cfset orderWeight=.5><br />
<cfset OOSmsg=false>
<cfset SOmsg=false>
<cfif cartContents.recordCount NEQ 0>
<p>The shopping cart now has links back to the items in it in case you want to give another listen before you decide. Just click on the title below.</p>
<form name="checkout" action="checkOutAction.cfm" method="post"><br />
<cfoutput><input type="hidden" name="cart" value="#url.cart#"></cfoutput>
<!---<h5>You can edit quantities here before starting checkout.</h5>//--->
<table border="1" bordercolor="#999999" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" width="100%"><br />
<tr>
	<td style="color:white" align="center">QTY</td>
	<td style="color:white">ARTIST</td>
	<td style="color:white">TITLE</td>
	<td style="color:white">LABEL</td>
	<td style="color:white">MEDIA</td>
	<td style="color:white">STATUS</td>
	<td style="color:white">REMOVE</td>
	<td style="color:white">WISH LIST&dagger;</td>
	<td style="color:white">PRICE</td>
</tr>
<cfset multCount=0>
<cfset alreadyBoughtCount=0>
<cfset itemCount=0>
<cfoutput query="cartContents">

	<cfif qtyOrdered GT 1><cfset multCount=multCount+1></cfif>
	<cfif priceOverride NEQ 0><cfset thisPrice=priceOverride><cfelse><cfset thisPrice=price></cfif>
    <cfquery name="alreadyBought" datasource="#DSN#">
        select *
    from orderItemsQuery
    where orderID<><cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer"> AND
    custID=<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer"> AND adminAvailID=6 AND catItemID=#catItemID#
  </cfquery>
  <cfif alreadyBought.recordCount GT 0><cfset alreadyBoughtCount=alreadyBoughtCount+1><tr bgcolor="purple"><cfelse><tr></cfif>
		<td align="center"><input type="text" name="qty#orderItemID#" value="#qtyOrdered#" size="2" style="text-align: center;"/></td>
		<td><a href="http://www.downtown304.com/index.cfm?sID=#catItemID#" title="View this item in the store">#artist#</a></td>
		<td><a href="http://www.downtown304.com/index.cfm?sID=#catItemID#" title="View this item in the store">#title#</a></td>
		<td>#label# (#catnum#)</td>
		<td><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
		
		<td><cfif ((albumStatusID LT 25 AND ONHAND GT 0) OR ONSIDE GT 0) OR labelID EQ 4158><font color="green" size="1">IN STOCK</font><cfelseif albumStatusID EQ 30><font color="yellow" size="1">SPECIAL ORDER</font><cfset SOmsg=true><cfelseif albumStatusID LT 44><font color="yellow" size="1">OUT OF STOCK*</font><cfset OOSmsg=true><cfelseif albumStatusID EQ 44><font color="red" size="1">OUT OF PRINT*</font><cfset OOSmsg=true></cfif></td>
		<td align="center"><a href="cartAction.cfm?cRemove=#orderItemID#&ret=co&cart=#url.cart#"><font color="red">X</font></a></td>
		<td><a href="cartAction.cfm?cWish=#orderItemID#&ret=co&cart=#url.cart#">save for later</a></td>
		<td align="right"><cfif thisPrice EQ 0><font color="red"><b>FREE</b></font><cfelse>#DollarFormat(thisPrice)#</cfif></td>
	</tr>
	<cfset thisSub=thisSub+(qtyOrdered*thisPrice)>
    <cfset itemCount=itemCount+qtyOrdered>
</cfoutput>
	<cfif multCount GT 0>
		<tr>
			<td colspan="9" bgcolor="#FFFF00" align="center" style="font-size: small; color:black;"><b style="color: red; font-size: medium;">NOTE:</b><br />Your order contains more than 1 copy of <cfif multCount EQ 1>an item<cfelse>some items</cfif>. If that is what you intended, click "Check Out".<br />Otherwise, you can adjust <cfif multCount EQ 1>the quantity<cfelse>quantities</cfif> here before you start checkout.</b></td>
		</tr>
	</cfif>
<cfoutput>
<tr>
	<td align="center"><input type="submit" name="submit" id="submit" value="Update Quantities" /></td>
	<td colspan="7" align="right"><b>Order Subtotal:</b></td>
	<td align="right"><b>#DollarFormat(thisSub)#</b></td>
</tr>
<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2015-07-24">
<cfif bigsaleperc LT 1>
	<cfset percentsaved=(1-bigsaleperc)*100>
    <tr>
        <td align="center">&nbsp;</td>
        <td colspan="7" align="right" style="background-color:rgb(44,71,186); padding-top:20px; padding-bottom: 20px; padding-right: 20px;"><b><font style="color:white; font-size:20px;">You Saved #percentSaved#% in our Midsummer Sale!</font></b></td>
        <td align="right"><b>&nbsp;</b></td>
    </tr>
    </cfif>
<cfelse>
	<cfset percentSaved=0>
</cfif>
<tr>
  <td align="center">&nbsp;</td>
  <td colspan="7" align="right">&nbsp;</td>
  <td align="right"><cfif Session.userID NEQ 0 AND Session.userID NEQ "" AND url.cart EQ "view"><cfoutput><p><a href="http://downtown304.com/checkOut.cfm?dsu=#URLEncodedFormat(Encrypt(Session.userID,'y6DD3cxo86zHGO'))#" target="_top">Check Out</a></p></cfoutput><cfelse><input type="submit" name="submit" id="submit" value="Check Out" /></cfif></td>
</tr>
</cfoutput>
</table>
<h5 align="right">&nbsp;</h5>
</form>
<cfif alreadyBoughtCount GT 0><p align="center"><font size="4" color="red">**ALERT!!! You have previously purchased the item<cfif alreadyBoughtCount GT 1>s</cfif> highlighted in purple above</font></p></cfif>
<cfif OOSmsg><p><font size="3">*NOTE: Some items may have gone out of stock since you first placed them in your cart. They might still be available if the status is OUT OF STOCK. If you keep them in your order, we will ship them if available or automatically backorder them for you and notify you when they become available. You will only be charged for items that are available and do ship. Items that are marked OUT OF PRINT are probably no longer available.</font></p></cfif>
<cfif SOmsg><p><font size="3">*NOTE: You have 1 or more SPECIAL ORDER item(s) in your cart. These items will be requested from our supplier when you order them and will ship as soon as we receive them. The waiting period is from 1 to 4 weeks for most items. You will not be charged for items that do not ship.</font></p></cfif>
<p><font size="3">&dagger;WISH LIST: The "save for later" feature moves an item from your cart to your <a href="http://www.downtown304.com/index.cfm?list=wish" target="_top">Wish List</a> if you don't want to purchase it today. View your <a href="http://www.downtown304.com/index.cfm?list=wish" target="_top">Wish List</a> under "My Account" on the home page.</font></p>
<cfelse><h1>Your Cart is Empty</h1>
</cfif>
<cfif Session.userID EQ 0>
	<cfif Cookie.username NEQ "">
	<p><font color="red">Please login (top right) before checking out</font><br />
	<a href="http://downtown304.com/profileNew.cfm" target="opusviewmain">Click here</a> if you need to create a new account</p>
	<cfelse>
	<h5><a href="profileNew.cfm?co=true">Check Out</a></h5>
	</cfif>
<cfelse>

</cfif>
<p><a href="http://downtown304.com/index.cfm" target="_top">Return to the Store</a></p>
<cflock scope="session" timeout="20" type="exclusive">
	<cfset Session.orderID=cartContents.orderID>
</cflock>
<cfinclude template="checkOutPageFoot.cfm">