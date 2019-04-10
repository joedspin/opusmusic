<cfparam name="url.ID" default="0">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisCountry" datasource="#DSN#">
 select *
 from country
 where ID=#url.ID#
</cfquery>
<cfquery name="itemCountry" datasource="#DSN#">
	select *
	from catItems
	where countryID=#url.ID#
</cfquery>
<cfform name="country" action="listsCountryDeleteAction.cfm" method="post">
<p>Are you sure you want to delete this country (action cannot be undone)?</p>
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisCountry">
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="40" maxlength="100" passthrough="readonly"></td>
			</tr>
		</cfoutput>
		<tr>
				<td>Convert to:*&nbsp;</td>
		<cfif itemCountry.recordCount EQ 0>
				<td>[NOT NECESSARY]<cfinput type="hidden" name="convertID" value="0"></td>
		<cfelse>
			<cfquery name="allCountries" datasource="#DSN#">
				select *
				from country
				where ID<>#url.ID#
				order by name
			</cfquery>
			<td><cfselect query="allCountries" name="convertID" display="name" value="ID"></cfselect></td>
		</cfif>
		</tr>
	</table>
	<p><cfinput type="submit" name="delete" value="Yes">&nbsp;<cfinput type="submit" name="delete" value="No"><cfoutput><input type="hidden" name="ID" value="#ID#"> <a href="listsCountryEdit.cfm?ID=#ID#">EDIT</a></cfoutput></p>
</cfform>
<p>*You must select a different country to reassign any existing addresses that are currently assigned to the country you are deleting.</p>
<cfinclude template="pageFoot.cfm">