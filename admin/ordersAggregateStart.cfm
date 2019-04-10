<cfset pageName='ORDERS'>
<cfinclude template="pageHead.cfm">

<cfparam name="url.custID" default="2126">
<cfparam name="url.custID2" default="3887">
<cfquery name="unaggregatedOrders" datasource="#DSN#">
	select *
	from orders
	where (custID=#url.custID# OR custID=#url.custID2#) AND oFlag1=0
	order by ID
</cfquery><title>Pick Orders to Aggregate</title>
<cfform name="oAg" action="ordersAggregate.cfm" method="post">
<cfoutput query="unaggregatedOrders">
<input type="checkbox" name="ordersToAg" value="#ID#" /> #ID# - #DateFormat(dateUpdated,"mm/dd/yyyy")# [#DollarFormat(orderSub)#]<br />
</cfoutput>
<cfquery name="invoice" datasource="#DSN#">
	select Max(ID) as maxID from invoices
    where orderList=''
</cfquery>
<cfif invoice.maxID EQ 0 OR invoice.maxID EQ ''>
	<cfquery name="newInvoice" datasource="#DSN#">
    	insert into invoices (poNum, orderList, itemCount, totalDue, invDate)
        values ('','',0,0.00,#varDateODBC#)
    </cfquery>
    <cfquery name="invoice" datasource="#DSN#">
        select Max(ID) as maxID from invoices
        where orderList=''
    </cfquery>
</cfif>
<cfset invoiceNum=invoice.maxID>
<p>Invoice # <cfoutput><cfinput type="text" name="invno" size="10" maxlength="4" value="#invoiceNum#" readonly ></cfoutput></p>
<p>P.O. # <cfinput type="text" name="pono" size="15" maxlength="20"></p>
<input type="submit" name="submit" value=" Submit " />
</cfform>
<p><a href="ordersAggregateHistory.cfm">Past Invoices</a></p>
<cfinclude template="pageFoot.cfm">