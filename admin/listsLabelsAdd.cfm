<cfset pageName="LISTS">
<cfparam name="url.letter" default="a">
<cfinclude template="pageHead.cfm">

<cfform name="label" action="listsLabelsAddAction.cfm" method="post">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<tr>
			<td>Name:&nbsp;</td>
			<td><cfinput type="text" name="name" size="50" maxlength="100"></td>
		</tr>
		<tr>
			<td>Sort:&nbsp;</td>
			<td><cfinput type="text" name="sort" size="50" maxlength="30"></td>
		</tr>	
		<tr>
			<td>Logo File:&nbsp;</td>
			<td><cfinput type="text" name="logofile" size="20" maxlength="100"></td>
		</tr>
		<tr>
			<td colspan="2"><cfinput type="checkbox" name="active" value="yes" checked="yes"> Active&nbsp;</td>
		</tr>
		<!---<tr>
			<td colspan="2"><cfinput type="checkbox" name="groomed" value="yes" checked="yes"> Groomed&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><cfinput type="checkbox" name="special" value="yes" checked="no"> Special&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><cfinput type="checkbox" name="highlight" value="yes" checked="no"> Highlight&nbsp;</td>
		</tr>	//--->
	</table>
	<p><cfinput type="submit" name="submit" value="Save"></p>
	<cfoutput><input type="hidden" name="letter" value="#url.letter#" /></cfoutput>
</cfform>
<cfinclude template="pageFoot.cfm">