<cfparam name="url.ID" default="0">
<cfquery name="killItem" datasource="#DSN#">
	delete *
	from GEMMBatchProcessing
	where ID=#url.ID#
</cfquery>
<cflocation url="orders.cfm">
