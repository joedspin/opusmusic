<cfquery name="fixReleaseDate" datasource="#DSN#">
	update catItemsQuery
	set releaseDate=<cfqueryparam value="" cfsqltype="cf_sql_char">,releaseYear='2006'
	where releaseDate=<cfqueryparam value="6/28/1905" cfsqltype="cf_sql_date">
</cfquery>
<cfoutput query="fixReleaseDate">
	#artist# | #title#<br />
</cfoutput>