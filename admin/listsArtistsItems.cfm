<cfquery name="currentItems" datasource="#DSN#">
	select *
	from catItemsQuery
	where artistID=#url.ID#
</cfquery>
<cfquery name="currentLists" datasource="#DSN#">
	select *
	from artistListsQuery
	where artistID=#url.ID#
</cfquery>
<p><b>Current Items by this Artist:</b><br />
<cfoutput query="currentItems">
#catnum# - #artist# / #title# <a href="catalogEdit.cfm?ID=#currentItems.ID#">item</a><br />
</cfoutput>&nbsp;</p>
<p><b>Current Lists by this Artist:</b><br />
<cfoutput query="currentLists">
#DateFormat(listDate,"mm/dd/yy")# - #artist# / #listName# <br />
</cfoutput>&nbsp;</p>