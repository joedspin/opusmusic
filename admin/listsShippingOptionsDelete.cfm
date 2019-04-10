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
<cfform name="label" action="listsShippingOptionsDeleteAction.cfm" method="post">
<p>Are you sure you want to delete this option (action cannot be undone)?</p>
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisOption">
			<tr>
				<td colspan="2"><cfselect name="countryID" display="name" selected="#countryID#" value="ID" query="countries"></cfselect>
			</tr>
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="40" maxlength="100" passthrough="readonly"></td>
			</tr>
			<tr>
				<td>Shipping Time:&nbsp;</td>
				<td><cfinput type="text" name="shippingTime" value="#shippingTime#" size="20" maxlength="30" passthrough="readonly"></td>
			</tr>	
		</cfoutput>
	</table>
	<p><cfinput type="submit" name="delete" value="Yes">&nbsp;<cfinput type="submit" name="delete" value="No"><cfoutput><input type="hidden" name="ID" value="#ID#"> <a href="listsShippingOptionsEdit.cfm?ID=#ID#">EDIT</a></cfoutput></p>
</cfform>
<cfinclude template="pageFoot.cfm">