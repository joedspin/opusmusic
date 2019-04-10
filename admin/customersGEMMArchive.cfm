<cfset pageName="CUSTOMERS">
<cfinclude template="pageHead.cfm">
<p>Downtown 304 online admin tool</p>

<cfquery name="allCustomers" datasource="#DSN#">
	select DISTINCT [Customer E-Mail] As CustomerEmail, [Shipto Attn] as ShipToAttn, [Status Code] As StatusCode
	from GEMMBatchArchive
</cfquery>
<cfoutput><p>#allCustomers.recordCount# distinct Emails</p></cfoutput>
<table border="1" style="border-collapse:collapse;" cellpadding="2">
<cfoutput query="allCustomers">
	<tr>
		<td><a href="customersGEMMUnsubscribe.cfm?email=#CustomerEmail#">UNSUBSCRIBE</a></td>
		<td>#CustomerEMail#</td>
		<td>#ShipToAttn#</td>
		<td align="right">#StatusCode#</td>
	</tr>
</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">