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
<cfoutput>
<h1>Downtown 304 Order : #NumberFormat(url.ID,"00000")#</h1>
<h2>#thisCust.firstName# #thisCust.lastName#</h2>
<h3><cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput></h3>
<p>Customer email: #thisCust.email#</p>



</cfoutput>






<cfquery name="thisItems" datasource="#DSN#">
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE
	FROM orderItemsQuery
	where adminAvailID=2 AND statusID<6AND statusID>1 AND Left(shelfCode,1)='D' AND orderID=#url.ID#
	group by catnum, label, artist, title, ONSIDE
	order by label, Sum(qtyOrdered) DESC
</cfquery>
<style>
body {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
td {font-size: xx-small; vertical-align: top;"}
</style>
<h1>Warehouse</h1>
<h3><cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput></h3>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse; border-color:#000000;" width="100%">
<cfset total=0>
<cfset toggle=0>
<cfoutput query="thisItems">
<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>
	<td width="10" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
	<td width="100">#Left(UCase(label),20)#</td>
	<td width="50">#Left(UCase(catnum),20)#</td>
	<td>#Left(UCase(artist),30)#</td>
	<td>#Left(UCase(title),30)#</td>
</tr>
</cfoutput>
</table>
<p>Warehouse Total: <cfoutput>#total#</cfoutput></p>
<cfquery name="opusItems" datasource="#DSN#">
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE, shelfCode
	FROM orderItemsQuery
	where adminAvailID=2 AND statusID<6AND statusID>1 AND Left(shelfCode,1)<>'D' AND orderID=#url.ID#
	group by catnum, label, artist, title, ONSIDE, shelfCode
	order by label, Sum(qtyOrdered) DESC
</cfquery>
<style>
body {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
td {font-size: xx-small; vertical-align: top;"}
</style>
<h1>On the Side</h1>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse; border-color:#000000;" width="100%">
<cfset total=0>
<cfset toggle=0>
<cfoutput query="opusItems">
<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>
	<td width="10" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
	<td width="10" align="center">[#shelfCode#]</td>
	<td width="100">#Left(UCase(label),20)#</td>
	<td width="50">#Left(UCase(catnum),20)#</td>
	<td>#Left(UCase(artist),30)#</td>
	<td>#Left(UCase(title),30)#</td>
</tr>
</cfoutput>
</table>
<p>On the Side Total: <cfoutput>#total#</cfoutput></p>




<cfoutput>

<table border="0" cellpadding="10" cellspacing="0" width="100%">
	<tr>
		<td valign="top" width="50%">
	<p><b>Ship to:</b><br />
		<cfloop query="thisShipping">
		#thisShipping.firstName# #thisShipping.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop>
	</td>
	<td valign="top" width="50%">
	<p><b>Bill to:</b><br />
		<cfloop query="thisBilling">
		#thisBilling.firstName# #thisBilling.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop></td></tr>
	<tr>
	<td valign="top"><p><b>Shipping Method:</b><br />
	<cfloop query="thisShipOption">
		#name# (#shippingTime#) #DollarFormat(thisUpdatedOrder.orderShipping)#
	</cfloop></p></td>
	<td valign="top"><p>Order Sub-Total: <b>#DollarFormat(thisUpdatedOrder.orderSub)#</b><br>
	
	<cfif thisUpdatedOrder.orderTax GT 0>NY Sales Tax (8.875%): <b>#DollarFormat(thisUpdatedOrder.orderTax)#</b><br /></cfif>
	Order Total: <b>#DollarFormat(thisUpdatedOrder.orderTotal)#</b></p>
	<cfloop query="thisCard">
<p>#thisCard.PayAbbrev#<br />
#ccNum#<br />
#ccFirstName# #ccName# [userCard ID: #thisCard.ID#]</p>
</cfloop>
	</cfoutput></td></tr></table>
	
</cfloop>