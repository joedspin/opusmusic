<cfquery name="updateCountry" datasource="#DSN#">
	update catItems
	set releaseDate=<cfqueryparam value="04/09/2007" cfsqltype="cf_sql_date">
	where price><cfqueryparam value="7.00" cfsqltype="cf_sql_money"> AND labelID=719
</cfquery>