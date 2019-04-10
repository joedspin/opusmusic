<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="allCountries" datasource="#DSN#">
	select *
	from countries
	order by name
</cfquery>
<p><a href="listsCountriesAdd.cfm">ADD NEW COUNTRY</a></p>
<table border="1" style="border-collapse:collapse;" cellpadding="2">
	<cfoutput query="allCountries">
		<tr>
			<td><a href="listsCountriesEdit.cfm?ID=#ID#">EDIT</a></td>
			<td><a href="listsCountriesDelete.cfm?ID=#ID#">DELETE</a></td>
			<td>#abbrev#</td>
			<td>#name#</td>
		</tr>
	</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">