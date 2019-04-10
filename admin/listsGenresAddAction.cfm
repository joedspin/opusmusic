<cfparam name="form.name" default="">
<cfquery name="addGenre" datasource="#DSN#">
	insert into genres (name)
	values (<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">)
</cfquery>
<cflocation url="listsGenres.cfm">