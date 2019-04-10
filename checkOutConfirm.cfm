<cfparam name="url.thisPromo" default="">
<cfparam name="url.orderID" default="0">
<cfset thisorderid=NumberFormat(url.orderID,"0000000")>
<!---<cfparam name="url.loggedID" default="0">
<cfif url.loggedID NEQ 0>
	<cfquery name="getLoggedID" datasource="#DSN#">
    	select *
        from sessionLogger
        where ID=<cfqueryparam value="#url.loggedID#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif getLoggedID.recordCount NEQ 0>
    	<cflock scope="session" timeout="20" type="exclusive">
			<cfset Session.userID=getLoggedID.userID>
	    </cflock>
    </cfif>
</cfif>//--->
<cfinclude template="checkOutPageHead.cfm">
<cfquery name="logSession" datasource="#DSN#">
	insert into sessionLogger (userID)
    values (#Session.userID#)
</cfquery>
<cfquery name="getLoggedID" datasource="#DSN#">
	select Max(ID) as MaxID 
    from sessionLogger
    where userID=#Session.userID#
</cfquery>
<cfset loggedID=getLoggedID.MaxID>
<cfset thisorderid=Session.orderID>
<p>&nbsp;</p>
	<h4>Confirm Your Order</h4>
	<h1 style="font-size: large; color: red; font-weight:bold;">Your order is NOT placed until you click "CONFIRM" below.</h1>
	<!---<cfif Session.userID NEQ "0">//--->
		<cfquery name="thisOrder" datasource="#DSN#">
			select *
			from orders
			where ID=#thisorderid#
		</cfquery>
        <!---
		<cfif thisOrder.paymentTypeID EQ 5 AND thisOrder.shipID EQ 64>
        <cfset cashPickup=true>
		<cfquery name="setCashPickupPrices" datasource="#DSN#">
			UPDATE orderItems
			SET orderItems.price=CEILING(catItems.buy+2)
            FROM ((orderItems LEFT JOIN catItems ON orderItems.catItemID = catItems.ID) LEFT JOIN orders ON orderItems.orderID=orders.ID) 
			WHERE catItems.shelfID=11 AND orders.ID=#thisorderid#
		</cfquery>
        <cfelse><cfset cashPickup=false></cfif>//--->
<cfif DateFormat(varDateODBC,"yyyy-mm-dd") EQ "2016-11-25">
        <cfquery name="deleteDiscount" datasource="#DSN#">
        	delete 
            from orderItems
            where catItemID=77340 AND orderID=<cfqueryparam value="#url.orderID#" cfsqltype="cf_sql_integer">
        </cfquery>
        
</cfif>
		<cfquery name="cartContents" datasource="#DSN#">
			SELECT *
			FROM orderItemsQuery
			where orderID=<cfqueryparam value="#url.orderID#" cfsqltype="cf_sql_integer">
		</cfquery>
	<!---</cfif>//--->
<cfloop query="thisOrder">

        
<cfset thisSub=0>
<cfset orderWeight=.5>
<cfset OOSmsg=false>
<cfif cartContents.recordCount NEQ 0>
<table border="1" bordercolor="#999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" width="100%">
<tr>
	<td style="color:white" align="center">QTY</td>
	<td style="color:white">ARTIST</td>
	<td style="color:white">TITLE</td>
	<td style="color:white">LABEL</td>
	<td style="color:white">MEDIA</td>
	<td style="color:white">STATUS</td>
	<td style="color:white">PRICE</td>
</tr>
<cfset insertDiscount=0>
<cfoutput query="cartContents">
	<cfif priceOverride NEQ 0><cfset thisPrice=priceOverride><cfelse><cfset thisPrice=price></cfif>
	<tr>
		<td align="center">#qtyOrdered#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td>#label# (#catnum#)</td>
		<td><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
		
		<td><cfif ((albumStatusID LT 25 AND ONHAND GT 0) OR ONSIDE GT 0) OR labelID EQ 4158><font color="green" size="1">IN STOCK</font><cfelseif albumStatusID LT 44><font color="yellow" size="1">OUT OF STOCK*</font><cfset OOSmsg=true><cfelseif albumStatusID EQ 44><font color="red" size="1">OUT OF PRINT*</font><cfset OOSmsg=true></cfif></td>
		<td align="right"><cfif thisPrice EQ 0><font color="red"><b>FREE</b></font><cfelse>#DollarFormat(thisPrice)#</cfif></td>
	</tr>
	<cfset thisSub=thisSub+(qtyOrdered*thisPrice)>
</cfoutput>
<cfif DateFormat(varDateODBC,"yyyy-mm-dd") EQ "2016-11-25">
	<cfif thisSub GT 299.99><cfset insertDiscount=-75>
    <cfelseif thisSub GT 199.99><cfset insertDiscount=-50>
    <cfelseif thisSub GT 99.99><cfset insertDiscount=-25>
    </cfif>
    <cfif insertDiscount LT 0>
    	<cfquery name="insertBlackFriday" datasource="#DSN#">
			insert into orderItems (orderID,catItemID,qtyOrdered,price,priceOverride,adminAvailID)
            values (
                <cfqueryparam value="#url.orderID#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="77340" cfsqltype="cf_sql_char">,
                1,
                <cfqueryparam value="#insertDiscount#" cfsqltype="cf_sql_money">,
                <cfqueryparam value="#insertDiscount#" cfsqltype="cf_sql_money">,
                2
            )
        </cfquery>
        <tr>
            <td align="center">1</td>
            <td><font color="red"><b>Downtown 304</b></font></td>
            <td><font color="red"><b>Black Friday Sale</b></font></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right"><cfoutput><font color="red"><b>#DollarFormat(insertDiscount)#</b></font></cfoutput></td>
        </tr>
        <cfset thisSub=thisSub+insertDiscount>
        <cfset orderTotal=thisSub+thisOrder.orderShipping+thisOrder.orderTax>
        <cfquery name="fixOrder" datasource="#DSN#">
            update orders
            set orderSub=#thisSub#, orderTotal=#orderTotal#
            where ID=<cfqueryparam value="#url.orderID#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfquery name="thisOrder" datasource="#DSN#">
        	select *
            from orders
            where ID=<cfqueryparam value="#url.orderID#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cfif>
</cfif>
<!---<cfif url.thisPromo NEQ "" AND url.thisPromo NEQ "Promo code expired." AND url.thisPromo NEQ "judyjudy">
	<tr>
	<td align="center">1</td>
	<td>Downtown 304 WMC07 Promo Series</td>
	<td><cfoutput>#url.thisPromo#</cfoutput></td>
	<td>Downtown 304</td>
	<td>CD</td>
	<td><font color="#FFCC00" size="1">IN STOCK</font></td>
	<td align="right">FREE</td>
</tr>
	</cfif>//--->
<cfoutput>
<cfif url.thisPromo NEQ "not valid" and url.thisPromo NEQ "">
<tr>
	<td colspan="6">#url.thisPromo# applied</td>
	<td>&nbsp;</td>
</tr>
</cfif>
<tr>
	<td colspan="6" align="right"><b>Order Subtotal:</b></td>
	<td align="right"><b>#DollarFormat(thisSub)#</b></td>
</tr>
</cfoutput>
</table>
</cfif>
	<cfquery name="thisShipping" datasource="#DSN#">
		select *
		from custAddressesQuery
		where ID=<cfqueryparam value="#shipAddressID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfquery name="thisShipOption" datasource="#DSN#">
		select *
		from shippingRates
		where ID=<cfqueryparam value="#shipID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfquery name="thisBilling" datasource="#DSN#">
		select *
		from custAddressesQuery
		where ID=<cfqueryparam value="#billingAddressID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfquery name="thisCard" datasource="#DSN#">
		select *
		from userCardsQuery
		where ID=<cfqueryparam value="#userCardID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<table border="0" cellpadding="20" cellspacing="0">
	<tr><td valign="top"><h4><b>Shipping:</b></h4>
	<cfoutput query="thisShipOption">
	<p>#name# - #shippingTime# <cfif thisOrder.orderShipping NEQ 0>#DollarFormat(thisOrder.orderShipping)#</cfif></cfoutput><br />&nbsp;</p></td>
	<td rowspan="2" width="20">&nbsp;</td>
	<td valign="top"><h4><b>Payment: </b></h4>
	<p><cfif thisCard.RecordCount GT 0>
		<cfoutput query="thisCard">
			#PayAbbrev# ending in #Right(Decrypt(ccNum,encryKey71xu),4)#</cfoutput>
	<cfelseif thisOrder.PaymentTypeID EQ 5>
		Cash
	<cfelseif thisOrder.PaymentTypeID EQ 6>
		Money Order (pending)<br />
		SEND TO:<br />
		&nbsp;&nbsp;Downtown 304<br />
		&nbsp;&nbsp;302 Morgan Ave Ste B3<br />
		&nbsp;&nbsp;Brooklyn, NY 11211<br />
		&nbsp;<br />
		Please send payment promptly. If we have not received your payment after 14 days your order will be cancelled.
		<cfelseif thisOrder.PaymentTypeID EQ 7>
		PayPal
	</cfif>
	<br />&nbsp;</p></td>
	</tr>
	<tr><td valign="top">
	  <p><cfoutput query="thisShipping">
		<cfif thisOrder.shipID NEQ 64><b>Ship to:</b><br />
		#firstName# #LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p><!---[ <a href="profileAddressesEdit.cfm?ID=#ID#&ret=cos">edit</a> ]//--->
	<cfelse>&nbsp;</cfif></cfoutput></p></td>
	<td valign="top">
	<p><cfif thisOrder.PaymentTypeID LT 5><cfoutput query="thisBilling">
	  <b>Billing Address:</b><br />
	  #firstName# #LastName#<br />
	  #add1#<br />
	  <cfif add2 NEQ "">
	    #add2#<br />
	    </cfif>
	  <cfif add3 NEQ "">
	    #add3#<br />
	    </cfif>
	  #city# 
	  <cfif state NEQ "">
	    #state# 
	    </cfif>
	  <cfif stateprov NEQ "">
	    #stateprov# 
	    </cfif> 
	  #postcode#<br />
	  #country#</p></cfoutput></cfif>
	<cfif orderTax GT 0><p align="right">NY Sales Tax (8.875%): <cfoutput>#DollarFormat(orderTax)#</cfoutput></p></cfif></td></tr>
	</table>
	
	<cfoutput>
		<h4 align="right"><b>Order Total: #DollarFormat(thisOrder.orderTotal)#</b></h4>
		<cfif thisOrder.PaymentTypeID EQ 7>
		<!--- Paypal Response and Pay button //--->
		 <CFFORM ACTION="checkOutConfirmPayPal.cfm" method="post">
         <cfinput type="hidden" name="loggedID" value="#loggedID#">
<cfinput type="hidden" name="orderID" value="#url.orderID#">
<cfinput type="hidden" name="thisPromo" value="#url.thisPromo#">
<CFTRY>

	<cfset StructClear(Session)>
	
	<CFOBJECT COMPONENT="CallerService" name="caller">
<!---
	<CFHTTP URL="#serverURL#" METHOD="POST" THROWONERROR="YES">
	  <CFHTTPPARAM NAME="METHOD" VALUE="GetExpressCheckoutDetails" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="USER" VALUE="#APIUserName#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="PWD" VALUE="#APIPassword#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="SIGNATURE" VALUE="#APISignature#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="VERSION" VALUE="#version#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="PAYERID" VALUE="#URL.payerId#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="TOKEN" VALUE="#URL.token#" TYPE="FormField" ENCODED="YES">

	</CFHTTP>
--->
	<CFSET requestData = StructNew()>
	<CFSET requestData.METHOD = "GetExpressCheckoutDetails">
	<CFSET requestData.USER = "#APIUserName#">
	<CFSET requestData.PWD = "#APIPassword#">
	<CFSET requestData.SIGNATURE = "#APISignature#">
	<CFSET requestData.VERSION = "#version#">
	<CFSET requestData.TOKEN = "#URL.token#">

<!--- 
	Calling doHttppost for API call 
--->

<cfinvoke component="CallerService" method="doHttppost" returnvariable="response">

	<cfinvokeargument name="requestData" value=#requestData#>
	<cfinvokeargument name="serverURL" value=#serverURL#>
	<cfinvokeargument name="proxyName" value=#proxyName#>
	<cfinvokeargument name="proxyPort" value=#proxyPort#>
	<cfinvokeargument name="useProxy" value=#useProxy#>

</cfinvoke>

	<cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
	<cfset Session.resStruct = #responseStruct#>
<cfif not StructKeyExists(responseStruct, "SHIPTOSTREET2")>
	<cfset responseStruct.SHIPTOSTREET2 = "">
</cfif>
  <cfif responseStruct.Ack is "Success">
	<p align="right">Comments or Special Requests:<br /><textarea name="comments" rows="3" cols="50"></textarea></p>
	<table border="0" cellpadding="10" align="right">
          <tr>
            <td bgcolor="##FFFFFF"><input type="submit" value="CONFIRM" /></td>
          </tr>
        </table>
</cfif>

<cfif responseStruct.Ack is "Failure">
	<CFLOCATION URL="APIError.cfm?error=fromServer"> 
</cfif>

    <CFINPUT TYPE="hidden"  NAME="payerId" VALUE="#URL.payerId#">
    <CFINPUT TYPE="hidden" NAME="token" VALUE="#URL.token#">
    <CFINPUT TYPE="hidden"  NAME="amount" VALUE="#URL.AMT#">
    <CFINPUT TYPE="hidden" NAME="currencycode" VALUE="#URL.currencycode#">
    <CFINPUT TYPE="hidden" NAME="paymentaction" VALUE="#URL.paymentaction#">

    <!--
		Following variable passed as hidden values in the doexpresschekout 
		page to perform expresscheckout transaction
	-->
<CFCATCH>

	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	<CFLOCATION URL="APIError.cfm?error=fromClient">
	
</CFCATCH>
</CFTRY>
  </CFFORM>
		
		<!--- END Paypal Response and Pay button //--->
		<cfelse>
        <CFFORM ACTION="checkOutConfirmAction.cfm" method="post">
         <cfinput type="hidden" name="loggedID" value="#loggedID#">
<cfinput type="hidden" name="orderID" value="#url.orderID#">
<cfinput type="hidden" name="thisPromo" value="#url.thisPromo#">
        <p align="right">Comments or Special Requests:<br /><textarea name="comments" rows="3" cols="50"></textarea></p>
        <table border="0" cellpadding="10" align="right">
          <tr>
            <td bgcolor="##FFFFFF"><input type="submit" value="CONFIRM" /></td>
          </tr>
        </table>
		<!---<table border="0" cellpadding="10" align="right">
          <tr>
            <td bgcolor="##FFFFFF"><a href="checkoutConfirmAction.cfm?orderID=#url.orderID#&thisPromo=#URLEncodedFormat(url.thisPromo)#" style="font-size: large; font-family: Arial, Helvetica, sans-serif; font-weight: bold">CONFIRM</a></td>
          </tr>
        </table>//--->
        </CFFORM>
		</cfif>
	</cfoutput>
	</cfloop>
<!---</cfif>//--->
<p><a href="http://downtown304.com/index.cfm" target="_top">Continue Shopping</a></p>

<cfinclude template="checkOutPageFoot.cfm">