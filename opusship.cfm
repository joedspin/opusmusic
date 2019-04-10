<cfinclude template="pageHead.cfm">
<cfinclude template="topNav.cfm">
<cfquery name="allOptions" datasource="#DSN#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	select *
	from shippingRatesQuery
	where ID<>71 AND cost1Record>0
	order by countryID, cost1Record
</cfquery>
<blockquote>
<h4>Shipping Options and Costs</h4>
<p>This chart gives an estimate of shipping costs to different destinations. On large orders (more than 12 records) we can sometimes get better rates to certain destinations. When this is the case, we'll contact you before finalizing your charges to let you know the options. Shipping rates are less for CDs. Costs to countries not listed are usually closest to the options for Japan.</p>
<table border="1" style="border-collapse:collapse;" cellpadding="5" align="center">
	<tr>
		<td bgcolor="#006699"><span style="color: #FFFFFF; font-size: 12; font-weight: bold">Country</span></td>
		<td bgcolor="#006699"><span style="color: #FFFFFF; font-size: 12; font-weight: bold">Method</span></td>
		<td bgcolor="#006699"><span style="color: #FFFFFF; font-size: 12; font-weight: bold">Shipping Time</span></td>
		<td bgcolor="#006699"><span style="color: #FFFFFF; font-size: 12; font-weight: bold">1 Record</span></td>
		<td bgcolor="#006699"><span style="color: #FFFFFF; font-size: 12; font-weight: bold">Addt'l Record</span></td>
	</tr>
	<cfset lastCountry="">
	<cfoutput query="allOptions">
		<cfif country NEQ lastCountry and country NEQ "United States">
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
		</cfif>
		<tr>
			<td>#country#</td>
			<td>#name#</td>
			<td>#shippingTime#</td>
			<td align="right">#DollarFormat(cost1Record)#</td>
			<td align="right">#DollarFormat(costplusRecord)#</td>
		</tr>
		<cfset lastCountry=country>
	</cfoutput>
</table>
</blockquote>
<cfinclude template="pageFoot.cfm">