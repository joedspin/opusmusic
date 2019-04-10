<cfparam name="url.ID" default="0">
<cfquery name="thisItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where orderID=#url.ID#
</cfquery>
<cfloop query="thisItems">
<cfif price LT cost><cfset newPrice=price-0.50><cfelse><cfset newPrice=cost+0.50></cfif>
<cfquery name="updateItem" datasource="#DSN#">
    update orderItems
    set price=<cfqueryparam value="#Replace(newPrice,'$','','all')#" cfsqltype="cf_sql_money">
    where ID=#orderItemID#
</cfquery>
</cfloop>
<cflocation url="ordersEdit.cfm?ID=#url.ID#">
