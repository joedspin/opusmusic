<cfset cardLastName="">
<cfset shipLastName="">
<cfparam name="url.retOrderID" default="0">
<cfparam name="url.ID" default="#url.retOrderID#">
<cfparam name="url.reauth" default="">
<cfparam name="url.printonly" default="false">
<cfparam name="url.addCard" default="false">
<cfparam name="url.shipID" default="0">
<cfparam name="url.billID" default="0">
<style>
body, td {font-family:Arial, Helvetica, sans-serif;
	font-size: xx-small;
	line-height: 110%;
	}
h1 {font-size: small;}
</style>
<cfquery name="checkPending" datasource="#DSN#">
	select *
    from orderItemsQuery
    where orderID=#ID# and adminAvailID=2
</cfquery>
<cfif checkPending.recordCount GT 0>
	<p><font color="red">ALERT!!!</font><br />
    This order still has items at PENDING status. <cfoutput><a href="ordersEdit.cfm?ID=#ID#">Click here to EDIT the order.</a></cfoutput></p><cfabort>
</cfif>
<cfquery name="cardTypes" datasource="#DSN#">
	select *
	from paymentTypes
	where PayName <> '' and isCC=1 AND PaymtID<4
	order by PayName ASC
</cfquery>
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfloop query="thisOrder">
<cfquery name="thisShipOption" datasource="#DSN#">
	select *
	from shippingRates
	where ID=#shipID#
</cfquery>
<cfquery name="thisShipping" datasource="#DSN#">
	select countryID, stateID
	from custAddressesQuery
	where ID=#shipAddressID#
</cfquery>
<cfquery name="shippedItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#url.ID# AND (adminAvailID>3)
</cfquery>
	<cfset shipCost=0>
	<cfset thisOrderSub=0>
	<cfset vinylCount=0>
	<cfset cdCount=0>
	<cfset shipmentWeight=0.5>
	<cfloop query="shippedItems">
		<cfif weightException GT 0>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weightException*qtyOrdered)>
		<cfelse>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weight*qtyOrdered)>
		</cfif>
		<cfif mediaID EQ 1 OR mediaID EQ 5 OR mediaID EQ 9>
			<cfset vinylCount=vinylCount+(NRECSINSET*qtyOrdered)>
		<cfelse>
			<cfset cdCount=cdCount+(NRECSINSET*qtyOrdered)>
		</cfif>
		<cfif priceOverride EQ 0 OR priceOverride GT price>
			<cfset thisOrderSub=thisOrderSub+(qtyOrdered*price)>
		<cfelse>
        	<cfset thisOrderSub=thisOrderSub+(qtyOrdered*priceOverride)>
        </cfif>    
	</cfloop>
	<cfloop query="thisShipOption">
    	<cfif Find('UPS',thisShipOption.name) GT 0><cfset isUPS=true><cfelse><cfset isUPS=false></cfif>
		<cfset shipCost=0>
		<cfif (vinylCount+cdCount GTE minimumItems) AND ((vinylCount+cdCount LTE maximumItems) OR (maximumItems EQ 0)) AND (shipmentWeight GTE minimumWeight) AND ((shipmentWeight LTE maximumWeight) OR (maximumWeight EQ 0)) OR (vinylCount+cdCount LT 0)>
			<cfif vinylCount GT 0>
				<cfset shipCost=shipCost+cost1Record+(costplusrecord*(vinylCount-1))>
				<cfif cdCount GT 0>
					<cfset shipCost=shipCost+(costpluscd*(cdCount-1))>
				</cfif>
			<cfelse>
				<cfif cdCount GT 0>
					<cfset shipCost=shipCost+cost1CD+(costpluscd*(cdCount-1))>
				</cfif>
			</cfif>
         <cfelse>
         	<p>There is something wrong. The min/max number of items or weight has not been met for this shipping option.</p><cfabort>
		</cfif>
	</cfloop>
    <cfif shipCost GT 0 and thisOrderSub GTE 50>
    	<cfif shipID EQ 1>
        	<cfset shipCost=0>
        <!---<cfelseif shipCost GTE 5>
        	<cfset shipCost=shipCost-5>//--->
                    </cfif>
     </cfif>

     <cfif Replace(promoCode," ","","all") EQ "SHIP50">
		<cfset shipCost=Replace(DollarFormat(shipCost/2),"$","","all")>
      <cfelseif Replace(promoCode," ","","all") EQ "FREESHIPPING">
      	<cfif shipID EQ 1>
                <cfset shipCost=0>
            <cfelseif orderShipping GT 5.00>
                <cfset shipCost=shipCost-5>
            </cfif>
	</cfif>
	<cfif thisShipping.countryID EQ 1 AND thisShipping.stateID EQ 39 AND thisOrder.otherSiteID EQ 0><!--- If shipping to NY State, add sales tax //--->
		<cfset thisOrderTax=(.08875*(shipCost+thisOrderSub))>
	<cfelse>
		<cfset thisOrderTax=0>
	</cfif>
	<cfset thisOrderTotal=thisOrderSub+shipCost+thisOrderTax>
	<cfquery name="updateOrder" datasource="#DSN#">
		update orders
		set
			orderSub=<cfqueryparam value="#thisOrderSub#" cfsqltype="cf_sql_money">,
			orderShipping=<cfqueryparam value="#shipCost#" cfsqltype="cf_sql_money">,
			orderTax=<cfqueryparam value="#thisOrderTax#" cfsqltype="cf_sql_money">,
			orderTotal=<cfqueryparam value="#thisOrderTotal#" cfsqltype="cf_sql_money">
		where ID=#url.ID#
	</cfquery>
</cfloop>



<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfloop query="thisOrder">
<cfset thisOrderSub=orderSub>
<cfset thisOrderShipping=orderShipping>
<cfset thisOrderTax=orderTax>
<cfset thisOrderTotal=orderTotal>
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#userCardID#
</cfquery>
<cfset procDetails="#thisCard.PayAbbrev# ending in #Right(thisCard.ccNum,4)#">
<cfset paymType=thisCard.ccTypeID>
<!---<cfquery name="thisItems" datasource="#DSN#">
	SELECT orderItems.*, catItemsQuery.*
	FROM orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID
	where orderID=#url.ID# AND (adminAvailID=4 OR adminAvailID=5)
</cfquery>//--->
<cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#url.ID# AND (adminAvailID>3)
</cfquery>
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#thisOrder.custID#
</cfquery>
<cfquery name="thisShipOption" datasource="#DSN#">
	select *
	from shippingRates
	where ID=#shipID#
</cfquery>
<cfquery name="thisShipping" datasource="#DSN#">
	select *, abbrev
	from custAddressesQuery LEFT JOIN countries ON countries.ID=custAddressesQuery.countryID
	where custAddressesQuery.ID=#shipAddressID#
</cfquery>
<cfquery name="thisBilling" datasource="#DSN#">
	select *, abbrev
	from custAddressesQuery LEFT JOIN countries ON countries.ID=custAddressesQuery.countryID
	where custAddressesQuery.ID=#billingAddressID#
</cfquery>

<cfform name="orderReview" action="ordersPayAction.cfm" method="post"><!--- target="_blank">//--->
<cfoutput>
<table border="0" width="100%">
<tr><td colspan="2"><h1>Downtown 304 Order Summary ###NumberFormat(url.ID,'00000')#</h1></td></tr>
<tr><td valign="top">
<cfif url.reauth EQ "success"><h2><font color="red">Reauthorized</font></h2></cfif>
<p><cfloop query="thisItems">
	<cfif priceOverride EQ 0 OR priceOverride GT price>
			<cfset thisItemPrice=price>
		<cfelse>
        	<cfset thisItemPrice=priceOverride>
        </cfif>    
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#] #DollarFormat(thisItemPrice)#<br />
</cfloop></p>
<p><b>Order Sub-Total: <input name="orderSub" type="text" size="10" maxlength="7" value="#NumberFormat(thisOrderSub,"0.00")#"></b></p>
	<p><b>Shipping Method:</b><br />
	<cfloop query="thisShipOption">
		#name# (#shippingTime#) <input name="orderShipping" type="text" size="10" maxlength="7" value="#NumberFormat(thisOrderShipping,"0.00")#"></cfloop></p></td><td>
	<p><b>Ship to:</b><br />
		<cfloop query="thisShipping">
        <cfset shipLastName=thisShipping.LastName>
		#thisShipping.firstName# #thisShipping.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop>
	<p><b>Bill to:</b><br />
		<cfloop query="thisBilling">
		#thisBilling.firstName# #thisBilling.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop></p>
	<p><b>Payment: </b><br />
		<cfif thisCard.RecordCount GT 0>
			<cfloop query="thisCard">
            	<cfset cardLastName=ccName>
            	Name on Card: #ccFirstName# #ccName#<br />
				#PayAbbrev# ending in #Right(Decrypt(ccNum,encryKey71xu),4)#
                <cfif ccName EQ ""><p align="center" style="font-size:large; color:red; font-weight:bold">WARNING: No last name given on credit card details!</p></cfif>
			</cfloop>
		</cfif>
        <cfif thisOrder.paymentTypeID EQ 7>PayPal</cfif>
	</p></td></tr>
    <tr><td colspan="2" valign="top">
    <cfif UCase(cardLastName) NEQ UCase(shipLastName) AND cardLastName NEQ ""><p align="center" style="font-size:large; color:red; font-weight:bold">WARNING: Last Name on shipping address does not exactly match Last Name on credit card</p></cfif>
	<cfif thisOrder.orderTax GT 0><p><b>NY Sales Tax (8.875%):</b> <input name="orderTax" type="text" size="10" maxlength="7" value="#NumberFormat(thisOrderTax,"0.00")#"></p></cfif>
	<p><b>Order Total: </b><input name="orderTotal" type="text" size="10" maxlength="7" value="#NumberFormat(thisOrderTotal,"0.00")#"></p>
<cfif NOT url.printOnly><input type="hidden" name="ID" value="#url.ID#" />
<p><cfif thisOrder.paymentTypeID EQ 6><font color="red"><b>Payment type is Money Order</b></font><a href="ordersUpdateStatus.cfm?ID=#url.ID#&notice=moneyorder">Send Notice</a><cfelseif thisOrder.paymentTypeID EQ 5><font color="red"><b>Payment type is Cash</b></font><!---<a href="orders.cfm?editedID=#url.ID#">Continue</a>//---><cfelse>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfif statusID EQ 3 OR thisOrder.paymentTypeID EQ 7><input type="submit" name="submit" value="     Capture     " /><!---<input type="submit" name="submit" value="     Reauthorize for New Amount     " />//---><cfelse><input type="submit" name="submit" value="          Charge          " tabindex="1" onrelease="javascript:this.disabled=true;"/><p align="right"><!---<input type="submit" name="submit" value="Try without Address" tabindex="2" />&nbsp;&nbsp;<input type="submit" name="submit" value="Authorize without Address" tabindex="2" />&nbsp;&nbsp;<input type="submit" name="submit" value="Authorization Only" tabindex="2" />//---></p></cfif></cfif><p align="right"><input type="submit" name="submit" value="Save Without Processing" tabindex="3" onrelease="javascript:this.disabled=true;" /></p></cfif></cfoutput>
<!---<cfif NOT url.printOnly><p><font color="red">ONLY USE THIS BUTTON TO PROCESS A NEW CHARGE FOR THE CARD ON FILE<br />
YOU WILL HAVE TO MANUALLY VOID THE ORIGINAL CAPTURE<br />
<input type="submit" name="submit" value="          Charge          " tabindex="1" /><input type="text" maxlength="10" size="10" name="cancelID" /><input type="submit" name="submit" value="Cancel" tabindex="1" /></p></cfif>//--->
</td></tr></table>
<!---<p>&nbsp;</p>
<h4>Choose Billing Address</h4>
<p><font color="#FFCC33">Please be sure the Billing Address selected below matches the address where 
  the credit card<br /> 
  statement is mailed. If that address is not shown below, click &quot;Add New Address&quot;.</font></p>
<cfoutput>
	<p><a href="customerAddressesAdd.cfm?ret=Pay&retOrderID=#url.ID#">Add New Address</a></p>
</cfoutput>
<cfquery name="myAddresses" datasource="#DSN#">
	select *
	from custAddressesQuery
	where custID=#thisOrder.custID#
</cfquery>
<cfif myAddresses.recordCount GT 0>
	<table cellpadding="15">
	<tr>
    <cfset billIDSet=false>
	<cfoutput query="myAddresses">
		<td valign="top">
		<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<tr>
		<td valign="top">
		<input type="radio" name="billID" value="#ID#" <cfif ID EQ thisOrder.billID OR myAddresses.RecordCount EQ 1>checked</cfif>></td>
		<td><b>#addName#</b><br />
		#firstName# #LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# [ <a href="customerAddressesEdit.cfm?retOrderID=#url.ID#&ret=Pay">edit</a> ]
		</tr>
		</table>
	</td>
	</cfoutput>
	</tr>
	</table>
	</cfif>
<h4>Choose a Payment Method</h4><br />
<h5>NOTE: If adding a new credit card, be sure the billing address is added and selected first</h5>
<table border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF" style="border-collapse: collapse;">
		<!---<cfif Cookie.userID EQ Session.userID><cfset thisUserID=Session.userID></cfif>//--->
		<cfquery name="myCards" datasource="#DSN#">
			select *
			from userCardsQuery
			where accountID=#thisOrder.custID#
		</cfquery>
		<cfif myCards.recordCount NEQ 0>
		<cfset noCheck=true>
			<cfoutput query="myCards">
				<tr>
					<cfif noCheck><cfset optionCheck="yes"><cfelse><cfset optionCheck="no"></cfif>
                    <cfset theMonth=Decrypt(ccExpMo,encryKey71xu)>
                    <cfset theYear=Decrypt(ccExpYr,encryKey71xu)>
                    <cfset theCard=Decrypt(ccNum,encryKey71xu)>
                    <cfset cardExpDate=NumberFormat(theYear+2000,"0000")&"-"&NumberFormat(theMonth,"00")&"-00">
                    <!---#cardExpDate# / #DateFormat(varDateODBC,"yyyy-mm-dd")# / #cardExpDate LT DateFormat(varDateODBC,"yyyy-mm-dd")#//--->
					<cfif cardExpDate LT DateFormat(varDateODBC,"yyyy-mm-dd")><td colspan="2" align="center"><font color="red"><b>X</b></font></td>
                    
				  <td colspan="2"><font color="##CCCCCC">Stored #PayName# ending in #Right(theCard,"4")#</font><font color="red"> EXPIRED DO NOT USE</font></td>
                    <cfelse>
                    <cfif ID EQ userCardID><cfset optionCheck="yes"></cfif>
				  <td colspan="2"><cfinput type="radio" name="cardChoice" value="#ID#" required="yes" message="Please select a Payment Method." checked="#optionCheck#"></td><td colspan="2"><font color="##CCCCCC">Stored #PayName# ending in #Right(theCard,"4")#</font></td>
                  </cfif>
				</tr>
				<cfset noCheck=false>
			</cfoutput>
		</cfif>
            <tr>
                <td colspan="2" nowrap><cfinput type="radio" name="cardChoice" value="C" required="yes" message="Please select a Payment Method."></td>
              <td colspan="2" nowrap><font color="#CCCCCC">Cash</font></td>
            </tr>
        <tr>
			<td colspan="2" nowrap><cfinput type="radio" name="cardChoice" value="M" required="yes" message="Please select a Payment Method."></td>
		  <td colspan="2" nowrap><font color="#CCCCCC">Money Order</font></td>
		</tr>
		</cfif>
		<tr>
			<td colspan="2" nowrap><cfinput type="radio" name="cardChoice" value="P" required="yes" message="Please select a Payment Method.">&nbsp;</td>
		  <td colspan="2" nowrap><img src="https://www.paypal.com/en_US/i/logo/PayPal_mark_37x23.gif" align="left" style="margin-right:7px;"><span style="font-size:11px; font-family: Arial, Verdana;">The safer, easier way to pay.<!---The PayPal payment option is temporarily unavaialble.//---></span></td>
		</tr>
		<tr>
			<td colspan="2"><cfinput type="radio" name="cardChoice" value="0" required="yes" message="Please select a Payment Method."></td>
		  <td colspan="2"><font color="#CCCCCC">New Credit Card:</font></td>
		</tr>
		<tr>
			<td rowspan="7" colspan="2">&nbsp;</td>
			<td valign="middle">Type of Card:</td>
			<td colspan="2"><cfselect query="cardTypes" name="CCType" display="PayName" value="PaymtID" ></cfselect></td>
		</tr>
		<tr>
			<td valign="middle" >First Name on Card:</td>
		  <td ><cfinput type="Text" name="CCFirstName" size="30" maxlength="50"></td>
		</tr>
		<tr>
			<td valign="middle" >Last Name on Card:</td>
		  <td ><cfinput type="Text" name="CCName" size="30" maxlength="50"></td>
		</tr>
		<tr>
			<td valign="middle" >Card Number:</td>
		  <td ><cfinput type="Text" name="CCNum" message="Card Number not valid, please verify." validate="creditcard" size="30" maxlength="20"></td>
		</tr>
		<tr>
			<td valign="middle" >Card Expiration:</td>
			<td>
				<cfselect name="expmo">
					<option value="01">Jan</option>
					<option value="02">Feb</option>
					<option value="03">Mar</option>
					<option value="04">Apr</option>
					<option value="05">May</option>
					<option value="06">Jun</option>
					<option value="07">Jul</option>
					<option value="08">Aug</option>
					<option value="09">Sep</option>
					<option value="10">Oct</option>
					<option value="11">Nov</option>
					<option value="12">Dec</option>
				</cfselect>
				<cfselect name="expyr">
					<cfset thisYear=DatePart("yyyy",varDateODBC)>
					<cfoutput>
						<cfloop from="#thisYear#" to="#thisYear+10#" index="y">
							<option value="#Right(y,"2")#">#y#</option>
						</cfloop>
					</cfoutput></cfselect>
			</td>
		</tr>
		<tr>
			<td valign="middle" nowrap>Card CCV:<br />MC or Visa = 3 digits<br />Amex = 4 digits</td>
		  <td ><cfinput type="Text" name="CCV" message="CCV is required (3 digits for MC/Visa, 4 digits for Amex" required="no" size="6" maxlength="4"></td>
		</tr>
		<tr>
			<td valign="middle" nowrap>Store for Future Use:</td>
		  <td ><cfinput type="checkbox" name="saveCard" value="Yes" checked="yes"></td>
		</tr>
	</table>//--->

</cfform>
</cfloop>
<cfif url.printonly EQ "true"><p align="right"><cfoutput><a href="orders.cfm?editedID=#url.ID#">Continue &gt;</a></cfoutput></p></cfif>