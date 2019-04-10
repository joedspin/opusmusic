<cfparam name="form.name" default="">
<cfparam name="form.abbrev" default="">
<cfquery name="addCountry" datasource="#DSN#">
	insert into countries (name, abbrev)
	values (<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.abbrev#" cfsqltype="cf_sql_char">)
</cfquery>
<cflocation url="listsCountries.cfm">