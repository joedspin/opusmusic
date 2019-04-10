<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfform name="genre" action="listsGenresAddAction.cfm" method="post">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<tr>
			<td>Name:&nbsp;</td>
			<td><cfinput type="text" name="name" size="50" maxlength="100"></td>
		</tr>
	</table>
	<p><cfinput type="submit" name="submit" value="Save"></p>
</cfform>
<cfinclude template="pageFoot.cfm">