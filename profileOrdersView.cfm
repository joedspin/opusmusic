<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<style>
	body {background-color:#333333}
</style>
<blockquote>
<h1 style="margin-top: 12px;"><b><font color="#66FF00">My Account</font></b> Order History and Status</h1>
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from ((orders LEFT JOIN orderStatus ON orders.statusID=orderStatus.ID) LEFT JOIN adminIssues ON orders.adminIssueID=adminIssues.ID)
	where orders.ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="allOrderItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
    order by adminAvailID, label, catnum, artist
</cfquery>
<cfoutput>
	<h1>Order ###url.ID#</h1>
	<h2>Placed on: #DateFormat(thisOrder.datePurchased,"mmmm d, yyyy")#</h2>
    <h2>Current Status: #thisOrder.statusName# (#DateFormat(thisOrder.dateUpdated,"mm/dd/yy")#) <cfif thisOrder.adminIssueID GT 0><font color="red">#thisOrder.issueName#</font></cfif>
</cfoutput><p>
<cfoutput query="allOrderItems">
<font color="##FF9933">#itemStatus#</font> #qtyOrdered# x <b>#artist#</b> #title# (#label# [#catnum#]) <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media# #DollarFormat(price)#<br />
</cfoutput></p>

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
<cfif statusID EQ 6><p>Completed on: <cfoutput query="thisOrder">#DateFormat(dateShipped,"mm/dd/yy")#</cfoutput></p></cfif>
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
</cfloop>
<p><a href="profileOrders.cfm">Back to Orders</a> | <a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">