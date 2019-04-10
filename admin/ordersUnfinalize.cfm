<cfparam name="url.ID" default="0">
<cfquery name="thisOrder" datasource="#DSN#">
	update orders
    set statusID=2, oFlag1=0, datePurchased=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
    where ID=#url.ID#
</cfquery>
<cflocation url="orders.cfm">