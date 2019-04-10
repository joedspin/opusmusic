<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="statuses" datasource="#DSN#">
	select *
	from orderItemStatus
	order by ID
</cfquery>
<!---<p><a href="listsGenresAdd.cfm">ADD NEW GENRE</a></p>//--->
<p><cfoutput query="statuses">
	<!---<a href="listsGenresEdit.cfm?ID=#ID#">EDIT</a> | <a href="listsGenresDelete.cfm?ID=#ID#">DELETE</a>//--->#ID#  : #name#<br />
</cfoutput></p>