<cfparam name="url.ID" default="0">
<cfparam name="url.undo" default="false">
<cfparam name="url.express" default="">
<cfif url.undo><cfset IRvalue=0><cfelse><cfset IRvalue=1></cfif>
<cfquery name="invoiced" datasource="#DSN#">
	update orders
	set issueResolved=#IRvalue#
	where ID=#url.ID#
</cfquery>
<cfif url.express NEQ "">
	<cflocation url="ordersPaid.cfm?ID=#url.ID#&express=#url.express#">
<cfelse>
	<cflocation url="orders.cfm?editedID=#url.ID#">
</cfif>