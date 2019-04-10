<cfparam name="form.ID" default="0">
<cfif form.delete EQ "Yes">
	<cfquery name="deleteGenre" datasource="#DSN#">
		delete
		from genres
		where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
	</cfquery>
</cfif>
<cflocation url="listsGenres.cfm">