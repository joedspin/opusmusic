<cfparam name="url.ID" default="0">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfloop query="thisOrder">
	<cfset thisShipID=shipID>
	<cfset thisShippingAddress=shipAddressID>
</cfloop>
<cfif url.ID NEQ "0">
	<cfquery name="cartContents" datasource="#DSN#">
		SELECT orderItems.*, catItemsQuery.*
		FROM orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID
		where orderID=#url.ID#
	</cfquery>
	<cfset orderSub=0>
	<cfset vinylCount=0>
	<cfset cdCount=0>
	<cfset shipmentWeight=0.5>
	<cfloop query="cartContents">
		<cfif weightException GT 0>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weightException)>
		<cfelse>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weight)>
		</cfif>
		<cfif mediaID EQ 1 OR mediaID EQ 5 OR mediaID EQ 9>
			<cfset vinylCount=vinylCount+NRECSINSET>
		<cfelse>
			<cfset cdCount=cdCount+NRECSINSET>
		</cfif>
		<cfset orderSub=orderSub+qtyOrdered*price>
	</cfloop>
	<cfquery name="shipOptions" datasource="#DSN#">
		select *
		from shippingRates
		where ID=#thisShipID#
	</cfquery>
	<cfloop query="shipOptions">
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
	<cfquery name="thisShipAddress" datasource="#DSN#">
		select *
		from custAddresses
		where ID=#thisShippingAddress#
	</cfquery>
	<cfif thisShipAddress.countryID EQ 1 AND thisShipAddress.stateID EQ 39><!--- If shipping to NY State, add sales tax //--->
		<cfset orderTax=(.08875*(shipCost+orderSub))>
	<cfelse>
		<cfset orderTax=0>
	</cfif>
	<cfset orderTotal=orderSub+shipCost+orderTax>
	<cfquery name="updateOrder" datasource="#DSN#">
		update orders
		set
			orderSub=<cfqueryparam value="#orderSub#" cfsqltype="cf_sql_money">,
			orderShipping=<cfqueryparam value="#shipCost#" cfsqltype="cf_sql_money">,
			orderTax=<cfqueryparam value="#orderTax#" cfsqltype="cf_sql_money">,
			orderTotal=<cfqueryparam value="#orderTotal#" cfsqltype="cf_sql_money">
		where ID=#url.ID#
	</cfquery>
</cfif>
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
<cfloop query="thisCard">
	<cfset procDetails="#thisCard.PayAbbrev# ending in #Right(thisCard.ccNum,4)#">
	<cfset paymType=thisCard.ccTypeID>
</cfloop>
<cfquery name="thisItems" datasource="#DSN#">
	SELECT orderItems.*, catItemsQuery.*
	FROM orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID
	where orderID=#url.ID#
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
	select *
	from custAddressesQuery
	where ID=#shipAddressID#
</cfquery>
<cfquery name="thisBilling" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#billingAddressID#
</cfquery>

<cfmail to="order@downtown304.com" cc="marianne@downtown304.com" from="order@downtown304.com" subject="Downtown 304 order #NumberFormat(url.ID,"00000")#" type="html">

<h1>Order Summary</h1>

<p><cfloop query="thisItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#] #DollarFormat(price)#<br />
</cfloop></p>
<p><b>Order Sub-Total: #DollarFormat(orderSub)#</b></p>
<p><b>Customer Email: #thisCust.email#</b></p>
	<p><b>Shipping Method:</b><br />
	<cfloop query="thisShipOption">
		#name# (#shippingTime#) #DollarFormat(thisOrder.orderShipping)# 
	</cfloop></p>
	<p><b>Ship to:</b><br />
		<cfloop query="thisShipping">
		#firstName# #LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop>
	<p><b>Bill to:</b><br />
		<cfloop query="thisBilling">
		#firstName# #LastName#<br />
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
		<cfelseif thisOrder.paymentTypeID EQ 6>
			Money Order<br />
			SEND TO:<br />
		&nbsp;&nbsp;Downtown 304<br />
		&nbsp;&nbsp;129 Powell St<br />
		&nbsp;&nbsp;Brooklyn, NY 11212<br />
			&nbsp;<br />
			Your order will be held for 14 days. Please send payment promptly.
		</cfif>
	</p>
	<cfif thisOrder.orderTax GT 0><p><b>NY Sales Tax (8.875%):</b> #DollarFormat(thisOrder.orderTax)#</p></cfif>
	<p><b>Order Total: </b>#DollarFormat(thisOrder.orderTotal)#</p>
</cfmail>





<cflocation url="orders.cfm">
</cfloop>