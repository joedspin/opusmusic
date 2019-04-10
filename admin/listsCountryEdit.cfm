<cfparam name="url.ID" default="0">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisCountry" datasource="#DSN#">
 select *
 from country
 where ID=#url.ID#
</cfquery>
<cfform name="label" action="listsCountryEditAction.cfm" method="post" enctype="multipart/form-data">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisCountry">
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="50" maxlength="100"></td>
			</tr>
		</cfoutput>
	</table>
	<p><cfinput type="submit" name="submit" value="Save Changes"><cfinput type="hidden" name="ID" value="#ID#"></p>
</cfform>
<cfinclude template="pageFoot.cfm">