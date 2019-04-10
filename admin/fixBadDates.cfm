<cfquery name="fixBadDates" datasource="#DSN#">
	update catItems
	set dtDateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
	where dtDateUpdated><cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
</cfquery>