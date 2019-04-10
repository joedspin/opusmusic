<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfparam name="url.find" default="">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisLabel" datasource="#DSN#">
 select *
 from labels
 where ID=#url.ID#
</cfquery>
<cfquery name="currentItems" datasource="#DSN#">
	select *
	from catItemsQuery
	where labelID=#url.ID#
</cfquery>
<cfform name="label" action="listsLabelsDeleteAction.cfm" method="post">
<p>Are you sure you want to delete this label (action cannot be undone)?</p>
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisLabel">
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="40" maxlength="100" passthrough="readonly"></td>
			</tr>
			<tr>
				<td>Sort:&nbsp;</td>
				<td><cfinput type="text" name="sort" value="#sort#" size="20" maxlength="30" passthrough="readonly"></td>
			</tr>	
		</cfoutput>
		<tr>
				<td>Convert to:*&nbsp;</td>
		<cfif currentItems.recordCount EQ 0>
				<td>[NOT NECESSARY]<cfinput type="hidden" name="convertID" value="0"></td>
		<cfelse>
			<cfquery name="allLabels" datasource="#DSN#">
				select *
				from labels
				where ID<>#url.ID#
				order by sort
			</cfquery>
			<td><cfselect query="allLabels" name="convertID" display="name" value="ID"></cfselect></td>
		</cfif>
		</tr>
	</table>
	<p><cfinput type="submit" name="delete" value="Yes">&nbsp;<cfinput type="submit" name="delete" value="No"><cfoutput><input type="hidden" name="ID" value="#ID#"><input type="hidden" name="find" value="#url.find#" /> <a href="listsLabelsEdit.cfm?ID=#ID#&letter=#url.letter#">EDIT</a></cfoutput></p>
	<cfoutput><input type="hidden" name="letter" value="#url.letter#" /></cfoutput>
</cfform>
<p>*You must select a different label to reassign any existing items that are currently assigned to the label you are deleting.</p>
<p><b>Current Items on this Label:</b><br />
<cfoutput query="currentItems">
#catnum# - #artist# / #title# <br />
</cfoutput>&nbsp;</p>
<cfinclude template="pageFoot.cfm">