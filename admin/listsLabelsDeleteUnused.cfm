<cfsetting requesttimeout="900">
<cfquery name="allLabels" datasource="#DSN#">
 select *
 from labels
 order by sort, name
</cfquery>
<cfform name="deleteList" method="post" action="listsLabelsDeleteUnusedAction.cfm">
<cfloop query="allLabels">
	<cfquery name="currentItems" datasource="#DSN#">
		select *
		from catItemsQuery
		where labelID=#allLabels.ID#
	</cfquery>
	<cfif currentItems.recordCount EQ 0>
		<cfoutput><input type="checkbox" name="deleteLabels" value="#ID#" checked/> #allLabels.name# | #allLabels.sort#<br /></cfoutput>
	</cfif>
</cfloop>
<cfinput type="submit" name="submit" value="Delete">
</cfform>