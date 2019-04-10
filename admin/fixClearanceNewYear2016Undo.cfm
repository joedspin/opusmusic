<cfquery name="undoNewYearsSale" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=0, blueDate=<cfqueryparam value="2016-01-01" cfsqltype="cf_sql_date">
    where blue99=0 AND blueDate<<cfqueryparam value="2016-01-01" cfsqltype="cf_sql_date">
</cfquery>