<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
	set price=8.99, albumStatusID=23, dtDateUpdated=<cfqueryparam value="9/9/10" cfsqltype="cf_sql_date">
	where labelID IN (4673,6241) AND NRECSINSET=1 AND mediaID=1
</cfquery>