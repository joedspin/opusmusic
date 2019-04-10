<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="allCountry" datasource="#DSN#">
	select *
	from country
	order by name
</cfquery>
<p><a href="listsCountryAdd.cfm">ADD NEW COUNTRY</a></p>
<table border="1" style="border-collapse:collapse;" cellpadding="2">
	<cfoutput query="allCountry">
		<tr>
			<td><a href="listsCountryEdit.cfm?ID=#ID#">EDIT</a></td>
			<td><a href="listsCountryDelete.cfm?ID=#ID#">DELETE</a></td>
			<td>#ID#</td>
			<td>#name#</td>
		</tr>
	</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">