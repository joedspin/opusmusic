<cfparam name="url.orderID" default="0">
<cfparam name="url.VMdone" default="false">
<cfquery name="checkInvoiced" datasource="#DSN#">
	select *
    from orders
    where ID=#url.orderID# AND issueResolved=1
</cfquery>
<cfif checkInvoiced.recordCount GT 0 AND NOT url.VMdone>
	<p>Please wait patiently.</p>
	<cflocation url="ordersVMconvert.cfm?ID=#url.orderID#">
</cfif>
<cfquery name="makeOrderVM" datasource="#DSN#">
	update orders
    set isVinylmania=1
    where ID=#url.orderID#
</cfquery>
<cfquery name="checkOrder" datasource="#DSN#">
	select *
    from orderItemsQuery
    where orderID=#url.orderID# AND left(shelfCode,1)='D'
</cfquery>
<cfloop query="checkOrder">
	<cfquery name="adjustVMprices" datasource="#DSN#">
    	update orderItems
        set price=<cfqueryparam value="#buy*1.4#" cfsqltype="cf_sql_money">
        where ID=#orderItemID#
    </cfquery>
</cfloop>
<cflocation url="ordersShop.cfm?orderID=#url.orderID#">
