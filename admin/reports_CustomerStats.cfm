<cfquery name="activeCustomers" datasource="#DSN#">
	select distinct custID
	from orders where dateShipped>'#DateFormat(DateAdd('d',-75,varDateODBC),"yyyy-mm-dd")#' AND statusID=6
</cfquery>
<cfquery name="allCustomers" datasource="#DSN#">
	select *
	from custAccounts
</cfquery>
<cfoutput><p>#activeCustomers.recordCount# active Customers [purchased in last 18 months]</p>
<p>#allCustomers.recordCount# Customer accounts</p></cfoutput>
