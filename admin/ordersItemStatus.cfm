<cfparam name="url.ID" default="0">
<cfparam name="url.statID" default="0">
<cfquery name="updateItemStatus" datasource="#DSN#">
	update orderItems
	set adminAvailID=#url.statID#
	where ID=#url.ID#
</cfquery>
<cflocation url="orders.cfm">