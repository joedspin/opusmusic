<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfparam name="url.editItem" default="0">
<cfparam name="url.find" default="">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisArtist" datasource="#DSN#">
 select *
 from artists
 where ID=#url.ID#
</cfquery>
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
<cfform name="artist" action="listsArtistsDeleteAction.cfm" method="post">
<p>Are you sure you want to delete this artist (action cannot be undone)?</p>
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisArtist">
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="40" maxlength="100" passthrough="readonly"></td>
			</tr>
			<tr>
				<td>Sort:&nbsp;</td>
				<td><cfinput type="text" name="sort" value="#sort#" size="40" maxlength="30" passthrough="readonly"></td>
			</tr>	
		</cfoutput>
		<tr>
				<td>Convert to:*&nbsp;</td>
		<cfif currentItems.recordCount EQ 0 AND currentLists.recordCount EQ 0>
				<td>[NOT NECESSARY]<cfinput type="hidden" name="convertID" value="0"></td>
		<cfelse>
			<cfquery name="allArtists" datasource="#DSN#">
				select *
				from artists
				where ID<>#url.ID#
				order by sort
			</cfquery>
			<td><cfselect query="allArtists" name="convertID" display="name" value="ID"></cfselect></td>
		</cfif>
		</tr>
	</table>
	<p><cfinput type="submit" name="delete" value="Yes">&nbsp;<cfinput type="submit" name="delete" value="No"><cfoutput><input type="hidden" name="ID" value="#ID#"> <a href="listsArtistsEdit.cfm?ID=#ID#&letter=#url.letter#&find=#url.find#">EDIT</a></cfoutput></p>
	<cfoutput><input type="hidden" name="letter" value="#url.letter#" /><input type="hidden" name="editItem" value="#url.editItem#" /><input type="hidden" name="find" value="#url.find#" /></cfoutput>
</cfform>
<p>*You must select a different artist to reassign any existing items or lists that are currently assigned to the artist you are deleting.</p>
<cfinclude template="listsArtistsItems.cfm">
<cfinclude template="pageFoot.cfm">