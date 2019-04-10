<cfparam name="url.ID" default="0">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisCountry" datasource="#DSN#">
 select *
 from countries
 where ID=#url.ID#
</cfquery>
<cfform name="label" action="listsCountriesEditAction.cfm" method="post" enctype="multipart/form-data">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisCountry">
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="50" maxlength="100"></td>
			</tr>
			<tr>
				<td>PayPal Abbreviation:&nbsp;</td>
				<td><cfinput type="text" name="abbrev" value="#abbrev#" size="2" maxlength="2"></td>
			</tr>
		</cfoutput>
	</table>
	<p><cfinput type="submit" name="submit" value="Save Changes"><cfinput type="hidden" name="ID" value="#ID#"></p>
</cfform>
<cfinclude template="pageFoot.cfm">