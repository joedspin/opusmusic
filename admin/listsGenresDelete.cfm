<cfparam name="url.ID" default="0">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisGenre" datasource="#DSN#">
 select *
 from genres
 where ID=#url.ID#
</cfquery>
<cfform name="genre" action="listsGenresDeleteAction.cfm" method="post">
<p>Are you sure you want to delete this genre (action cannot be undone)?</p>
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisGenre">
			<tr>
				<td>ID:&nbsp;</td>
				<td><cfinput type="text" name="nameID" value="#ID#" size="5" passthrough="readonly"></td>
			</tr>
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="40" maxlength="100" passthrough="readonly"></td>
			</tr>
		</cfoutput>
	</table>
	<p><cfinput type="submit" name="delete" value="Yes">&nbsp;<cfinput type="submit" name="delete" value="No"><cfoutput><input type="hidden" name="ID" value="#ID#"> <a href="listsGenresEdit.cfm?ID=#ID#">EDIT</a></cfoutput></p>
</cfform>
<cfinclude template="pageFoot.cfm">