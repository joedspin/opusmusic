<cfparam name="url.ID" default="0">
<cfparam name="url.custID" default="0">
<cfquery name="deleteBackorder" datasource="#DSN#">
	delete
    from orderItems
    where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cflocation url="customerBackorders.cfm?custID=#url.custID#">