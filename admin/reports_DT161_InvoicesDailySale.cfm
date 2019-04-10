<cfquery name="tblInvoices" datasource="#DSN#">
	select *
    from tblInvoices
    where Invoice_Date>'2008-09-28' AND Open_YN=0 order by Invoice_Date
</cfquery>
<cfset lastDate="2008-09-29">
<cfset dailyTotal=0>
<cfset dayCount=0>
<table>
<cfoutput query="tblInvoice">
	<cfif Invoice_Date NEQ lastDate>
    <cfset dayCount=dayCount+1>
        <cfif dayCount EQ 1>
			<tr><td>#Invoice_Date#</td><td>#dailyTotal#</td>
			<cfset dayCount=2>
		<cfelseif dayCount EQ 5>
			<td>#Invoice_Date#</td><td>#dailyTotal#</td></tr>
			<cfset dayCount=0>
		<cfelse>
			<td>#Invoice_Date#</td><td>#dailyTotal#</td>
			<cfset dayCount=dayCount+1>
		</cfif>
		<cfset dailyTotal=0>
</cfif>
<cfset dailyTotal=dailyTotal+Total>
<cfset lastDate=Invoice_Date>
</cfoutput>
</table>