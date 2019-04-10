<cfset pageName='ORDERS'>
<cfinclude template="pageHead.cfm">
<cfquery name="invoices" datasource="#DSN#">
	select * from invoices
    order by ID DESC
</cfquery>
<p><cfoutput query="invoices">
<a href="ordersAggregate.cfm?invoiceID=#ID#">#ID#</a> - #DateFormat(invDate,"yyyy-mm-dd")# #DollarFormat(totalDue)#<br>
</cfoutput></p>
<cfinclude template="pageFoot.cfm">

