<cfparam name="url.ID" default="0">
<cfif url.ID NEQ "0">
<cfquery name="markAvail" datasource="#DSN#">
	update orderItems
	set adminAvailID=2
	where orderID=#url.ID#
</cfquery>
<cfquery name="updateOrder" datasource="#DSN#">
	update orders
	set issueRaised=<cfqueryparam value="No" cfsqltype="cf_sql_bit">, statusID=2, dateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
	where ID=#url.ID#
</cfquery>
</cfif>
<cflocation url="orders.cfm">