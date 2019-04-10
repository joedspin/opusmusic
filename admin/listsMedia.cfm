<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="media" datasource="#DSN#">
	select *
	from media
	order by name
</cfquery>
<!---<p><a href="listsGenresAdd.cfm">ADD NEW GENRE</a></p>//--->
<p><cfoutput query="media">
	<!---<a href="listsGenresEdit.cfm?ID=#ID#">EDIT</a> | <a href="listsGenresDelete.cfm?ID=#ID#">DELETE</a>//--->#ID# : #name#<br />
</cfoutput></p>