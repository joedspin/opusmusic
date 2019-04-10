<!---<cfparam name="url.ID" default="0">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfloop query="thisOrder">
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#userCardID#
</cfquery>
<cfset procDetails="#thisCard.PayAbbrev# ending in #Right(thisCard.ccNum,4)#">
<cfset paymType=thisCard.ccTypeID>
<cfquery name="thisItems" datasource="#DSN#">
	SELECT orderItems.*, catItemsQuery.*
	FROM orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID
	where orderID=#url.ID#
</cfquery>
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#custID#
</cfquery>
<cfquery name="thisShipOption" datasource="#DSN#">
	select *
	from shippingRates
	where ID=#shipID#
</cfquery>
<cfquery name="thisShipping" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#shipAddressID#
</cfquery>
<cfquery name="thisBilling" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#billingAddressID#
</cfquery>//--->


<cfparam name="url.ID" default="0">
<cfparam name="url.custID" default="0">
<cfparam name="url.reauth" default="">
<cfparam name="url.printonly" default="false">

<!---<cfloop query="thisOrder">
<cfquery name="thisCust" datasource="#DSN#">
	select *
    from custAccounts
    where ID=#custID#
</cfquery>
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
	where orderID=#url.ID# AND (adminAvailID>3) order by orderItemID
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
		<cfif priceOverride EQ 0>
			<cfset thisOrderSub=thisOrderSub+(qtyOrdered*price)>
		<cfelse>
        	<cfset thisOrderSub=thisOrderSub+(qtyOrdered*priceOverride)>
        </cfif>    
	</cfloop>
	<cfloop query="thisShipOption">
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
    <cfif shipCost GT 0 and thisOrderSub GTE 50 AND DateFormat(datePurchased,'yyyy-mm-dd') GTE '2009-01-27' AND DateFormat(datePurchased,'yyyy-mm-dd') LTE '2013-12-31'>
    	<cfif shipID EQ 1>
        	<cfset shipCost=0>
        </cfif>
     </cfif>

        <cfif thisCust.isStore AND shipID EQ 63><cfset shipCost=shipCost*.3></cfif>
     <!---<cfif Replace(promoCode," ","","all") EQ "SHIP50">
		<cfset shipCost=Replace(DollarFormat(shipCost/2),"$","","all")>
      <cfelseif Replace(promoCode," ","","all") EQ "FREESHIPPING">
      	<cfif shipID EQ 1>
                <cfset shipCost=0>
            <cfelseif orderShipping GT 5.00>
                <cfset shipCost=shipCost-5>
            </cfif>
	</cfif>//--->
	<cfif thisShipping.countryID EQ 1 AND thisShipping.stateID EQ 39 AND NOT thisCust.isStore><!--- If shipping to NY State, add sales tax //--->
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
//--->

<html>
<head>
</head>
<body onLoad="javascript: window.print()">
<cfif url.custID NEQ 0>
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where custID=#url.custID#
    order by ID DESC
</cfquery>
<cfset thisCustID=url.custID>
<cfelse>
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfset thisCustID=thisOrder.custID>
</cfif>
<cfquery name="thisCust" datasource="#DSN#">
	select *
    from custAccounts
    where ID=#thisCustID#
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
<cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#thisOrder.ID# AND (adminAvailID>3) order by label, catnum
</cfquery>
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#thisCustID#
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
<cfif thisItems.recordCount GT 0>

<cfoutput>
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {padding: 2px;}
//-->
</style>
<p><b>Downtown 304</b><br>
129 Powell St<br>
Brooklyn, NY 11212<br />
(718) 501-4320</p>
<h1><cfif thisCust.isStore><b><cfif orderTotal LT 0>Credit Note<cfelse>Invoice</cfif><cfelse><b>Order</cfif> ###thisOrder.ID#</b></h1>
<h2><cfif thisOrder.dateShipped NEQ "">#DateFormat(thisOrder.dateShipped,"mmmm d, yyyy")#<cfelse>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfif> (<cfif thisCust.billingName NEQ "">#thisCust.billingName#<cfelse>#thisCust.firstName# #thisCust.lastName#</cfif>)</h2>
<table border="1" style="border-collapse:collapse;" width="100%">
<tr bgcolor="##CCCCCC">
	<td align="center">QTY</td>
	<td>CATNUM</td>
	<td>LABEL</td>
	<td>ARTIST</td>
	<td>TITLE</td>
	<td>MEDIA</td>
	<td align="center">PRICE</td>
	<td align="center">TOTAL</td>
</tr>
<cfset thisSubTotal=0>
<cfset thisCount=0>
<cfloop query="thisItems">
<tr>
		<td align="center">#qtyOrdered#</td>
		<td valign="top">#catnum#</td>
		<td valign="top">#label#</td>
		<td valign="top">#artist#</td>
		<td valign="top">#title#</td>
		<td valign="top"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	    <td valign="top" align="right">#DollarFormat(price)#</td>
		<td valign="top" align="right">#DollarFormat(qtyOrdered*price)#</td>
	</tr>
    <cfset thisSubTotal=thisSubTotal+(qtyOrdered*price)>
    <cfif catnum NEQ "000000" AND catnum NEQ "GST000X"><cfset thisCount=thisCount+qtyOrdered></cfif>
</cfloop>
<cfif thisOrder.orderTax NEQ 0>
	<cfset thisOrderTax=thisSubTotal*.08875>
 <cfelse>
 	<cfset thisOrderTax=0>
</cfif>
<cfset thisOrderTotal=thisSubTotal+thisOrderTax>
<cfif DollarFormat(thisSubTotal) NEQ DollarFormat(orderSub)>
	<cfquery name="updateSub" datasource="#DSN#">
    	update orders
        set orderSub=<cfqueryparam value="#thisSubTotal#" cfsqltype="cf_sql_money">,
        	orderTax=<cfqueryparam value="#thisOrderTax#" cfsqltype="cf_sql_money">,
            orderTotal=<cfqueryparam value="#thisOrderTotal#" cfsqltype="cf_sql_money">
        where ID=#thisOrder.ID#
    </cfquery>
</cfif>
</table>
<p style="font-size: medium;">Count: #thisCount#</p>
<p><b>Order Sub-Total:</b> #DollarFormat(thisSubTotal)#</p>
<cfif thisOrder.orderTax GT 0><p><b>NY Sales Tax (8.875%):</b> #DollarFormat(thisOrderTax)#</p></cfif>
	
<!---	<cfif shipID NEQ 64>//--->
	<p><b>Shipping Method:</b><br />
	<cfloop query="thisShipOption">
		#name# (#shippingTime#) #DollarFormat(thisOrder.orderShipping)#
        <cfset thisOrderTotal=thisOrderTotal+thisOrder.orderShipping>
	</cfloop></p>
    
    <p><b>Order Total: #DollarFormat(thisOrderTotal)#</b></p>
	<p><b>Ship to:</b><br />
		<cfloop query="thisShipping">
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
	</cfloop>
<!---	<cfelse>
		<p><cfloop query="thisShipping">
		<b>#thisShipping.firstName# #thisShipping.LastName#</b><br /></cfloop>
        <cfloop query="thisShipOption">#name# #shippingTime#</cfloop></p>
	</cfif>//--->
	<p><b>Payment: </b><br />
		<cfif thisCard.RecordCount GT 0>
			<cfloop query="thisCard">
				#PayAbbrev# ending in #Right(ccNum,4)#
			</cfloop>
		 <cfelseif thisOrder.paymentTypeID EQ 6><cfif thisCust.isStore>Wire / Bank Transfer / PayPal<cfelse>Money Order</cfif>
		 <cfelseif thisOrder.paymentTypeID EQ 7>PayPal
         <cfelse>Cash
		</cfif>
	</p>
    <cfif specialInstructions NEQ ""><p><b>Special Instructions</b><br>
    		#Replace(specialInstructions,linefeed,'<br>','all')#</p></cfif>
    <cfif thisCust.custNotes NEQ ""><p><b>Customer Notes</b><br>
   <font style="font-size: 10pt">#Replace(thisCust.custNotes,linefeed,'<br>','all')#</font></p></cfif>
</cfoutput>
</cfif>
</cfloop>
</body></html>

