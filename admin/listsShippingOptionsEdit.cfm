<cfparam name="url.ID" default="0">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisOption" datasource="#DSN#">
	select *
	from shippingRatesQuery
	where ID=#url.ID#
</cfquery>
<cfquery name="countries" datasource="#DSN#">
	select *
	from countries
	where ID<>19
	order by name
</cfquery>
<cfform name="label" action="listsShippingOptionsEditAction.cfm" method="post" enctype="multipart/form-data">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisOption">
			<tr>
			<td>Country:&nbsp;</td>
			<td><cfselect name="countryID" display="name" selected="#countryID#" value="ID" query="countries"></cfselect></td>
		</tr>
		<tr>
			<td>Name:&nbsp;</td>
			<td><cfinput type="text" name="name" value="#name#" size="50" maxlength="100"></td>
		</tr>
		<tr>
			<td>Shipping Time:&nbsp;</td>
			<td><cfinput type="text" name="shippingTime" size="50" maxlength="50" value="#shippingTime#"></td>
		</tr>	
		<tr>
			<td>Cost for 1 Record:&nbsp;</td>
			<td><cfinput type="text" name="cost1Record" size="10" maxlength="30" value="#NumberFormat(cost1Record,"0.00")#"></td>
		</tr>
		<tr>
			<td>Cost for addt'l Record:&nbsp;</td>
			<td><cfinput type="text" name="costplusRecord" size="10" maxlength="30" value="#NumberFormat(costplusrecord,"0.00")#"></td>
		</tr>
		<tr>
			<td>Cost for 1 CD:&nbsp;</td>
			<td><cfinput type="text" name="cost1CD" size="10" maxlength="30" value="#NumberFormat(cost1CD,"0.00")#"></td>
		</tr>
		<tr>
			<td>Cost for addt'l CD:&nbsp;</td>
			<td><cfinput type="text" name="costplusCD" size="10" maxlength="30" value="#NumberFormat(costplusCD,"0.00")#"></td>
		</tr>
		<tr>
			<td>Minimum Items:&nbsp;</td>
			<td><cfinput type="text" name="minimumItems" size="6" maxlength="2" value="#minimumItems#"></td>
		</tr>
		<tr>
			<td>Maximum Items (0=no max):&nbsp;</td>
			<td><cfinput type="text" name="maximumItems" size="6" maxlength="2" value="#maximumItems#"></td>
		</tr>
		<tr>
			<td>Minimum Weight:&nbsp;</td>
			<td><cfinput type="text" name="minimumWeight" size="6" maxlength="2" value="#minimumWeight#"></td>
		</tr>
		<tr>
			<td>Maximum Weight (0=no max):&nbsp;</td>
			<td><cfinput type="text" name="maximumWeight" size="6" maxlength="2" value="#maximumWeight#"></td>
		</tr>
		</cfoutput>
	</table>
	<p><cfinput type="submit" name="submit" value="Save Changes"><cfinput type="hidden" name="ID" value="#ID#"></p>
</cfform>
<cfinclude template="pageFoot.cfm">