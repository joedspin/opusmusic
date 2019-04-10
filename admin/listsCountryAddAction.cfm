<cfparam name="form.name" default="">
<cfparam name="form.abbrev" default="">
<cfquery name="addCountry" datasource="#DSN#">
	insert into country (name)
	values (<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">)
</cfquery>
<cflocation url="listsCountry.cfm">