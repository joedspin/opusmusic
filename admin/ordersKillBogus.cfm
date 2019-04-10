<cfparam name="url.pstatus" default="0">
<cfquery name="killBogusOrders" datasource="#DSN#">
	delete *
	from GEMMBatchProcessing
	where Processed=#url.pstatus#
</cfquery>
<cflocation url="orders.cfm">