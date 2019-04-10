<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="allOptions" datasource="#DSN#">
	select *
	from shippingRatesQuery
	order by country, cost1Record DESC
</cfquery>
<p><a href="listsShippingOptionsAdd.cfm">ADD NEW OPTION</a></p>
<table border="1" style="border-collapse:collapse;" cellpadding="2">
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>Country</td>
		<td>Name</td>
		<td>Shipping Time</td>
		<td>1 Record</td>
		<td>Addt'l Record</td>
		<td>1 CD</td>
		<td>Addt'l CD</td>
	</tr>
	<cfoutput query="allOptions">
		<tr>
			<td><a href="listsShippingOptionsEdit.cfm?ID=#ID#">EDIT</a></td>
			<td><a href="listsShippingOptionsDelete.cfm?ID=#ID#">DELETE</a></td>
			<td>#country#</td>
			<td>#name#</td>
			<td>#shippingTime#</td>
			<td align="right">#DollarFormat(cost1Record)#</td>
			<td align="right">#DollarFormat(costplusRecord)#</td>
			<td align="right">#DollarFormat(cost1CD)#</td>
			<td align="right">#DollarFormat(costplusCD)#</td>
		</tr>
	</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">