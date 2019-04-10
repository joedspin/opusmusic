<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="countries" datasource="#DSN#">
	select *
	from countries
	where ID<>19
	order by name
</cfquery>
<cfform name="label" action="listsShippingOptionsAddAction.cfm" method="post">
	<table border="1" cellpadding="2" style="border-collapse:collapse;"><br />
		<tr>
			<td>Country:&nbsp;</td>
			<td><cfselect name="countryID" display="name" selected="1" value="ID" query="countries"></cfselect></td>
		</tr>
		<tr>
			<td>Name:&nbsp;</td>
			<td><cfinput type="text" name="name" size="50" maxlength="100"></td>
		</tr>
		<tr>
			<td>Shipping Time:&nbsp;</td>
			<td><cfinput type="text" name="shippingTime" size="50" maxlength="50"></td>
		</tr>	
		<tr>
			<td>Cost for 1 Record:&nbsp;</td>
			<td><cfinput type="text" name="cost1Record" size="10" maxlength="30" value="0.00"></td>
		</tr>
		<tr>
			<td>Cost for addt'l Record:&nbsp;</td>
			<td><cfinput type="text" name="costplusRecord" size="10" maxlength="30" value="0.00"></td>
		</tr>
		<tr>
			<td>Cost for 1 CD:&nbsp;</td>
			<td><cfinput type="text" name="cost1CD" size="10" maxlength="30" value="0.00"></td>
		</tr>
		<tr>
			<td>Cost for addt'l CD:&nbsp;</td>
			<td><cfinput type="text" name="costplusCD" size="10" maxlength="30" value="0.00"></td>
		</tr>
		<tr>
			<td>Minimum Items:&nbsp;</td>
			<td><cfinput type="text" name="minimumItems" size="6" maxlength="2" value="1"></td>
		</tr>
		<tr>
			<td>Maximum Items (0=no max):&nbsp;</td>
			<td><cfinput type="text" name="maximumItems" size="6" maxlength="2" value="0"></td>
		</tr>
		<tr>
			<td>Minimum Weight:&nbsp;</td>
			<td><cfinput type="text" name="minimumWeight" size="6" maxlength="2" value="1"></td>
		</tr>
		<tr>
			<td>Maximum Weight (0=no max):&nbsp;</td>
			<td><cfinput type="text" name="maximumWeight" size="6" maxlength="2" value="0"></td>
		</tr>
	</table>
	<p><cfinput type="submit" name="submit" value="Save"></p>
</cfform>
<cfinclude template="pageFoot.cfm">