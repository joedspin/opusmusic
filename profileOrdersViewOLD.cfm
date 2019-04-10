<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<style>
	body {background-color:#333333}
</style>
<blockquote>
<h1 style="margin-top: 12px;"><b><font color="#66FF00">My Account</font></b> Order History and Status</h1>
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="shippedItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer"> AND adminAvailID=6
</cfquery>
<cfquery name="notAvailItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where orderID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer"> AND adminAvailID=1
</cfquery>
<cfquery name="backorderedItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where orderID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer"> AND adminAvailID=3
</cfquery>
<cfquery name="pendingItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where orderID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer"> AND adminAvailID=2
</cfquery>
<cfoutput>
	<h1>Order ###url.ID#</h1>
	<h2>#DateFormat(thisOrder.datePurchased,"mmmm d, yyyy")#</h2>
</cfoutput>
<cfif shippedItems.recordCount GT 0><p><b>These items were available and have shipped:</b><br /><cfoutput query="shippedItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#] #DollarFormat(price)#<br />
</cfoutput></p></cfif>
<cfif pendingItems.recordCount GT 0><p><b>These items have been ordered. Confirmation of availability is pending:</b><br /><cfoutput query="pendingItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#] #DollarFormat(price)#<br />
</cfoutput></p></cfif>
<cfloop query="thisOrder">
<cfoutput><p>Order Subtotal: #DollarFormat(orderSub)#</p></cfoutput>
<cfquery name="thisShipping" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#shipAddressID#
</cfquery>
<cfquery name="thisShipOption" datasource="#DSN#">
	select *
	from shippingRates
	where ID=#shipID#
</cfquery>
<cfquery name="thisBilling" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#billingAddressID#
</cfquery>
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#userCardID#
</cfquery>
<p>Shipped on: <cfoutput query="thisOrder">#DateFormat(dateShipped,"mm/dd/yy")#</cfoutput></p>
<p><b>Shipping Method:</b><br />
<cfoutput query="thisShipOption">
	#name# (#shippingTime#) #DollarFormat(thisOrder.orderShipping)#
</cfoutput></p>
<p><b>Ship to:</b><br />
	<cfoutput query="thisShipping">
	#firstName# #LastName#<br />
	#add1#<br />
	<cfif add2 NEQ "">#add2#<br /></cfif>
	<cfif add3 NEQ "">#add3#<br /></cfif>
	#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
	#country# </p><!---[ <a href="profileAddressesEdit.cfm?ID=#ID#&ret=cos">edit</a> ]//--->
</cfoutput>
<p><b>Bill to:</b><br />
	<cfoutput query="thisBilling">
	#firstName# #LastName#<br />
	#add1#<br />
	<cfif add2 NEQ "">#add2#<br /></cfif>
	<cfif add3 NEQ "">#add3#<br /></cfif>
	#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
	#country# </p><!---[ <a href="profileAddressesEdit.cfm?ID=#ID#&ret=cos">edit</a> ]//--->
</cfoutput><br />
<cfif orderTax GT 0><p>NY Sales Tax (8.875%): <cfoutput>#DollarFormat(orderTax)#</cfoutput></p></cfif>
<p><b>Payment: </b><br />
<cfoutput query="thisCard">
	#PayAbbrev# ending in #Right(Decrypt(ccNum,encryKey71xu),4)# <a href="profileCardsEdit.cfm?ID=#ID#">EDIT</a>
</cfoutput>
</p>
<cfoutput>
	<p><b>Order Total: #DollarFormat(thisOrder.orderTotal)#</b></p>
</cfoutput>
<cfquery name="thisStatus" datasource="#DSN#">
		select *
		from orderStatus
		where ID=#thisOrder.statusID#
	</cfquery>
<cfoutput query="thisStatus">
<p><b>Status: </b>#statusName#</p>
<hr />
</cfoutput>
<cfoutput>
<cfif notAvailItems.recordCount GT 0><p><b>The following items are no longer available (you have not been charged for these items):</b><br />
<cfloop query="notAvailItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#]<br />
</cfloop></p></cfif>
<cfif backorderedItems.recordCount GT 0>
  <p><b>The following items are backordered (you have not been charged for these items). We will notify you when they are available again:</b><br />
<cfloop query="backorderedItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#]<br />
</cfloop></p></cfif>
</cfoutput>
</cfloop>
<p><a href="profileOrders.cfm">Back to Orders</a> | <a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">