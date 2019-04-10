<cfparam name="url.ID" default="0">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisGenre" datasource="#DSN#">
 select *
 from genres
 where ID=#url.ID#
</cfquery>
<cfform name="genre" action="listsGenresEditAction.cfm" method="post">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisGenre">
			<tr>
				<td>ID:&nbsp;</td>
				<td><cfinput type="text" name="nameID" value="#ID#" size="5" passthrough="readonly"></td>
			</tr>
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="50" maxlength="100"></td>
			</tr>
            </cfoutput>
	</table>
	<p><cfinput type="submit" name="submit" value="Save Changes"><cfinput type="hidden" name="ID" value="#ID#"></p>
</cfform>
<cfinclude template="pageFoot.cfm">