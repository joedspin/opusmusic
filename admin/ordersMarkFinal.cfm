<cfparam name="url.ID" default="0">
<cfquery name="thisOrder" datasource="#DSN#">
	update orders
    set statusID=6
    where ID=#url.ID#
</cfquery>
<cflocation url="orders.cfm">