<cfparam name="form.ID" default="0">
<cfparam name="form.name" default="">
<cfquery name="updateCountry" datasource="#DSN#">
	update country
	set
		name=<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
	where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cflocation url="listsCountry.cfm">