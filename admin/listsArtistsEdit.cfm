<cfparam name="pageBack" default="listsArtists.cfm">
<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfparam name="url.editItem" default="0">
<cfparam name="url.override" default="">
<cfparam name="url.find" default="">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisArtist" datasource="#DSN#">
 select *
 from artists
 where ID=#url.ID#
</cfquery>
<cfquery name="activeItems" datasource="#DSN#" maxrows="2">
	select *
	from catItemsQuery
	where artistID=#url.ID#
</cfquery>
<cfquery name="activeLists" datasource="#DSN#" maxrows="2">
	select *
	from artistListsQuery
	where artistID=#url.ID#
</cfquery>
<cfif (activeItems.recordCount GT 1 OR activeLists.recordCount GT 1) AND url.override NEQ "edit">
	<p style="font-size: medium;"><font color="red"><b>THIS ARTIST CANNOT BE EDITED more than 1 item has this artist name...</b></font><br />
    Instead you should <a href="listsArtistsAdd.cfm">Add a New Artist</a> and then choose the new one from the list of artists on the Catalog Edit screen.</p>
<cfelse>
<cfform name="artist" action="listsArtistsEditAction.cfm" method="post">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisArtist">
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="40" maxlength="100"></td>
			</tr>
			<tr>
				<td>Sort:&nbsp;</td>
				<td><cfinput type="text" name="sort" value="#sort#" size="40" maxlength="50"></td>
			</tr>	
			<tr>
				<td>Website:&nbsp;</td>
				<td><cfinput type="text" name="website" value="#website#" size="40" maxlength="100"></td>
			</tr>
			<tr>
				<td>Active&nbsp;</td>
				<td><cfinput type="checkbox" name="active" value="yes" checked="#YesNoFormat(active)#"></td>
			</tr>
		</cfoutput>
	</table>
	<p><cfinput type="submit" name="submit" value="Save Changes"><cfinput type="hidden" name="ID" value="#ID#"></p>
	<cfoutput><input type="hidden" name="letter" value="#url.letter#" /><input type="hidden" name="find" value="#url.find#" /><input type="hidden" name="editItem" value="#url.editItem#" /></cfoutput>
</cfform>
<cfoutput><p><a href="listsArtistsDelete.cfm?ID=#ID#&letter=#url.letter#&find=#url.find#">DELETE</a> | <a href="listsArtistsFixCase.cfm?ID=#ID#&letter=#url.letter#&editItem=#url.editItem#">FIX CASE</a> | <a href="listsArtistsNameSwap.cfm?ID=#ID#&letter=#url.letter#&editItem=#url.editItem#">SWAP</a></p></cfoutput>
</cfif>
<cfif (activeItems.recordCount GT 1 OR activeLists.recordCount GT 1) AND url.override NEQ "edit">
<cfoutput><p align="right"><a href="listsArtistsEdit.cfm?ID=#url.ID#&override=edit&letter=#url.letter#&editItem=#url.editItem#&find=#url.find#">Admin Override</a></p></cfoutput>
</cfif>
<cfinclude template="listsArtistsItems.cfm">
<cfinclude template="pageFoot.cfm">