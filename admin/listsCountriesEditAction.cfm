<cfparam name="form.ID" default="0">
<cfparam name="form.name" default="">
<cfparam name="form.abbrev" default="">
<cfquery name="updateCountry" datasource="#DSN#">
	update countries
	set
		name=<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
		abbrev=<cfqueryparam value="#form.abbrev#" cfsqltype="cf_sql_char">
	where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cflocation url="listsCountries.cfm">