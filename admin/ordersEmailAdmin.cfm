<cfparam name="url.ID" default="0">
<cfparam name="url.pageBack" default="orders.cfm">
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
</cfquery>
<cfquery name="shippedItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#url.ID# AND (adminAvailID=4 OR adminAvailID=5 OR adminAvailID=2)
</cfquery>
<cfquery name="notAvailItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where orderID=#url.ID# AND adminAvailID=1
</cfquery>
<cfquery name="backorderedItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where orderID=#url.ID# AND adminAvailID=3
</cfquery>
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
		<cfset thisOrderSub=thisOrderSub+(qtyOrdered*price)>
	</cfloop>
	<cfloop query="thisShipOption">
		<cfset shipCost=0>
		<cfif (vinylCount+cdCount GTE minimumItems) AND ((vinylCount+cdCount LTE maximumItems) OR (maximumItems EQ 0)) AND (shipmentWeight GTE minimumWeight) AND ((shipmentWeight LTE maximumWeight) OR (maximumWeight EQ 0))>
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
		</cfif>
	</cfloop>
	<!---<cfif thisShipping.countryID EQ 1 AND thisShipping.stateID EQ 39><!--- If shipping to NY State, add sales tax //--->
		<cfset thisOrderTax=(.08875*(shipCost+thisOrderSub))>
	<cfelse>
		<cfset thisOrderTax=0>
	</cfif>//--->
    <cfset thisOrderTax=0>
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

<cfquery name="thisUpdatedOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>

<cfmail to="order@downtown304.com" bcc="order@downtown304.com" from="order@downtown304.com" subject="Downtown 304 order UPDATED #NumberFormat(url.ID,"00000")#" type="html">
<h1>Order Summary</h1>
<p>Customer email: #thisCust.email#</p>
<p><b>These items are available:</b><br /><cfloop query="shippedItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#] #DollarFormat(price)#<br />
</cfloop></p>
<p><b>Order Sub-Total: #DollarFormat(thisUpdatedOrder.orderSub)#</b></p>
	<p><b>Shipping Method:</b><br />
	<cfloop query="thisShipOption">
		#name# (#shippingTime#) #DollarFormat(thisUpdatedOrder.orderShipping)#
	</cfloop></p>
<cfif notAvailItems.recordCount GT 0><p><b>The following items are no longer available (you have not been charged for these items):</b><br />
<cfloop query="notAvailItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#]<br />
</cfloop></p></cfif>
<cfif backorderedItems.recordCount GT 0><p><b>The following items are backordered (you have not been charged for these items). We will notify you when they are available again:</b><br />
<cfloop query="backorderedItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#]<br />
</cfloop></p></cfif>
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
	</cfloop><br />
	<p><b>Payment: </b><br />
		<cfif thisCard.RecordCount GT 0>
			<cfloop query="thisCard">
				#PayAbbrev# ending in #Right(ccNum,4)#
			</cfloop>
		<cfelseif thisUpdatedOrder.paymentTypeID EQ 6>
			Money Order<br />
		</cfif>
	</p>
	<cfif thisUpdatedOrder.orderTax GT 0><p><b>NY Sales Tax (8.875%):</b> #DollarFormat(thisUpdatedOrder.orderTax)#</p></cfif>
	<p><b>Order Total: </b>#DollarFormat(thisUpdatedOrder.orderTotal)#</p>
</cfmail>
</cfloop>
<cflocation url="#url.pageBack#">