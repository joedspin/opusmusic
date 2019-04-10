<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="genres" datasource="#DSN#">
	select *
	from genres
	order by name
</cfquery>
<p><a href="listsGenresAdd.cfm">ADD NEW GENRE</a></p>
<p><cfoutput query="genres">
	<a href="listsGenresEdit.cfm?ID=#ID#">EDIT</a> | <a href="listsGenresDelete.cfm?ID=#ID#">DELETE</a> #name# (#ID#)<br />
</cfoutput></p>