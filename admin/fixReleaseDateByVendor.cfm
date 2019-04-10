<cfquery name="fixGR" datasource="#DSN#">
	update catItems
    set releaseDate=<cfqueryparam value="11/11/2009" cfsqltype="cf_sql_date">,
    	DTdateUpdated=<cfqueryparam value="11/11/2009" cfsqltype="cf_sql_date">
        where releaseDate=<cfqueryparam value="11/11/09" cfsqltype="cf_sql_date">
        AND shelfID IN (15,31,32,33,34)
</cfquery>