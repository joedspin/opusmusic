<cfparam name="url.ID" default="0">
<cfquery name="origOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfquery name="origOrderItems" datasource="#DSN#">
	select *
	from orderItems
	where orderID=#url.ID#
</cfquery>
<cfloop query="origOrder">
	<cfset oCustID=custID>
	<cfset oBADID=billingAddressID>
	<cfset oPAYID=paymentTypeID>
	<cfset oUCID=userCardID>
	<cfset oSHIPID=shipID>
	<cfset oSHIPAID=shipAddressID>
	<cfquery name="addCustOrder" datasource="#DSN#">
		insert into orders (custID, dateStarted, dateUpdated, datePurchased, statusID, billingAddressID, paymentTypeID, userCardID, shipID, shipAddressID,comments)
		values (#oCustID#,#varDateODBC#,#varDateODBC#,#varDateODBC#,2,#oBADID#,#oPAYID#,#oUCID#,#oSHIPID#,#oSHIPAID#,'RESHIPPED')
	</cfquery>
</cfloop>
<cfquery name="getNewOrderID" datasource="#DSN#">
    select Max(ID) As MaxID
    from orders
    where custID=#oCustID# AND statusID=2
</cfquery>
<cfif getNewOrderID.recordCount GT 0>
<cfloop query="origOrderItems">
	<cfset oCatItemID=catItemID>
	<cfset oQtyOrdered=qtyOrdered>
	<cfquery name="addToCart" datasource="#DSN#">
		insert into orderItems (orderID,catItemID,qtyOrdered,price,adminAvailID)
		values (#getNewOrderID.MaxID#,
			<cfqueryparam value="#oCatItemID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#oQtyOrdered#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="0.00" cfsqltype="cf_sql_money">,2)
	</cfquery>
</cfloop>
<cflocation url="orders.cfm">
<cfelse>
Order not duplicated
</cfif>
