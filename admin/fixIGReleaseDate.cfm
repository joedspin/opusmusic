<cfquery name="fixIGreleaseDate" datasource="#DSN#">
	update catItems
    set releaseDate=<cfqueryparam value="2009-11-19" cfsqltype="cf_sql_date">, dtDateUpdated=<cfqueryparam value="2009-11-19" cfsqltype="cf_sql_date">
    where releaseDate=<cfqueryparam value="2009-11-18" cfsqltype="cf_sql_date"> AND shelfID=25
</cfquery>
<cfquery name="fixIGreleaseDate" datasource="#DSN#">
	update catItems
    set dtDateUpdated=<cfqueryparam value="2009-11-19" cfsqltype="cf_sql_date">
    where dtDateUpdated=<cfqueryparam value="2009-11-18" cfsqltype="cf_sql_date"> AND shelfID=25
</cfquery>