<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="allLists" datasource="#DSN#">
	select *
	from artistListsQuery
	order by artistSort ASC, listDate DESC
</cfquery>
<p><a href="listsPlayListsAdd.cfm">Add New List</a></p>
<table border=1 cellpadding=3 cellspacing=0 style="border-collapse:collapse;">
	<tr>
		<td><b>action</b></td>
		<td><b>artist</b></td>
		<td><b>list name</b></td>
		<td><b>list date</b></td>
	</tr>
<cfoutput query="allLists">
	<tr>
		<td><a href="listsPlayListsEdit.cfm?ID=#ID#">edit</a> <a href="listsPlayListsDelete.cfm?ID=#ID#">delete</a></td>
		<td>#artist#</td>
		<td>#listName#</td>
		<td>#DateFormat(listDate,"yyyy-mm-dd")#</td>
	</tr>
</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">