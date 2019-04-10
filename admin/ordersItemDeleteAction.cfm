<cfparam name="url.ID" default="0">
<cfparam name="url.pageBack" default="orders.cfm">
<cfquery name="killItem" datasource="#DSN#">
	delete
	from orderItems
	where ID=#url.ID#
</cfquery>
<cflocation url="#url.pageBack#">
