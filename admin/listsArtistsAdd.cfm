<cfset pageName="LISTS">
<cfparam name="url.letter" default="a">
<cfinclude template="pageHead.cfm">

<cfform name="label" action="listsArtistsAddAction.cfm" method="post">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<tr>
			<td>Name:&nbsp;</td>
			<td><cfinput type="text" name="name" size="40" maxlength="100"></td>
		</tr>
		<tr>
			<td>Sort:&nbsp;</td>
			<td><cfinput type="text" name="sort" size="40" maxlength="50"></td>
		</tr>	
		<tr>
			<td>Website:&nbsp;</td>
			<td><cfinput type="text" name="website" size="40" maxlength="100"></td>
		</tr>
		<tr>
			<td>Active&nbsp;</td>
			<td><cfinput type="checkbox" name="active" value="yes" checked></td>
		</tr>
	</table>
	<p><cfinput type="submit" name="submit" value="Save"></p>
	<cfoutput><input type="hidden" name="letter" value="#url.letter#" /></cfoutput>
</cfform>
<cfinclude template="pageFoot.cfm">