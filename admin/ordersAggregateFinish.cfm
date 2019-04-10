<cfset pageName='ORDERS'>
<cfparam name="form.orderList" default="">
<cfparam name="form.invno" default="0">
<cfparam name="form.pono" default="">
<cfparam name="form.itemCt" default="0">
<cfparam name="form.totalDue" default="0.00">



<!--- this block of code is for emailing the invoice to bookkeeping //--->
<cfset pageName='ORDERS'>
<cfparam name="url.custID" default="2126">
<cfparam name="url.invoiceID" default="0">
<cfparam name="form.ordersToAg" default="">
<cfquery name="thisCust" datasource="#DSN#">
    select *
    from custAccounts
    where ID=#url.custID#
</cfquery>
<cfset orderList="">
<cfset orderSubTotal=0>
<cfset orderCount=0>
<cfif url.invoiceID NEQ 0>
        <cfquery name="thisInvoice" datasource="#DSN#">
            select *
            from invoices
            where ID=#url.invoiceID#
        </cfquery>
        <cfset thisOrdersToAg=thisInvoice.orderList>
        <cfset thisDate=thisInvoice.invDate>
        <cfset thisPO=thisInvoice.poNum>
        <cfset thisInvNo=url.invoiceID>
        <cfquery name="thisOrder" datasource="#DSN#">
            select *
            from orders
            where ID IN (#thisOrdersToAg#) 
            order by ID
        </cfquery>
        <cfquery name="thisShipping" datasource="#DSN#">
            select *
            from custAddressesQuery
            where ID=#thisOrder.shipAddressID#
        </cfquery>
        <cfquery name="thisItems" datasource="#DSN#">
            SELECT orderItems.*, catItemsQuery.*
            FROM orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID
            where orderID IN (#thisOrdersToAg#) 
            order by catnum DESC
        </cfquery>
	<cfelse>
    	<cfset thisOrdersToAg=form.ordersToAg>
        <cfset thisDate=varDateODBC>
        <cfset thisPO=form.pono>
        <cfset thisInvNo=form.invno>
        <cfquery name="thisOrder" datasource="#DSN#">
            select *
            from orders
            where ID IN (#thisOrdersToAg#) AND oFlag1=0
            order by ID
        </cfquery>
        <cfquery name="thisShipping" datasource="#DSN#">
            select *
            from custAddressesQuery
            where ID=#thisOrder.shipAddressID#
        </cfquery>
        <cfquery name="thisItems" datasource="#DSN#">
            SELECT *
            FROM orderItemsQuery
            where orderID IN (#thisOrdersToAg#) AND adminAvailID=6
            order by orderItemID
        </cfquery>
</cfif>
<cfset orderTempTotal=0>
<cfloop query="thisItems">
	<cfset orderTempTotal=orderTempTotal+(qtyOrdered*price)>
</cfloop>
<!---<cfloop query="thisOrder">
<cfif orderList NEQ ""><cfset orderList=orderList & ","></cfif>
<cfset orderList=orderList & "#ID#">
</cfloop>//--->
<cfif orderTempTotal GT 0><cfset mLabel="INVOICE"><cfelse><cfset mLabel="CREDIT MEMO"></cfif> 
<cfmail to="order@downtown304.com" from="order@downtown304.com" subject="#mLabel# ###form.invno#" type="html">
<html>
<head>


<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {padding: 2px;}
//-->
</style>
</head>
<body>

<h1>Downtown 304 #mLabel# ###thisInvNo#<!---#DateFormat(varDateODBC,"mmddyyyy")#//---></h1>
<h2>#DateFormat(thisDate,"mmmm d, yyyy")# &nbsp&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;P.O. ###thisPO#</h2>
<p>129 Powell St, Brooklyn, NY 11212 .:. order@downtown304.com</p>
<p><b>Customer Email:</b>&nbsp;&nbsp;&nbsp;#thisCust.email#</p>
<table border="1" style="border-collapse:collapse;" width="100%">
<tr bgcolor="##CCCCCC">
	<td align="center">ORDER</td>
	<td align="center">QTY</td>
	<td>CATNUM</td>
	<td>LABEL</td>
	<td>ARTIST</td>
	<td>TITLE</td>
	<td>MEDIA</td>
	<td align="center">PRICE</td>
	<td align="center">SHELF</td>
</tr>
<cfloop query="thisItems">
<tr>
		<td align="center">#orderID#</td>
		<td align="center">#qtyOrdered#</td>
		<td valign="top">#catnum#</td>
		<td valign="top">#label#</td>
		<td valign="top">#artist#</td>
		<td valign="top">#title#</td>
		<td valign="top"><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
		<td valign="top" align="right">#DollarFormat(price)#</td>
		<td valign="top" align="center">#shelfCode#</td>
	</tr>
<cfset orderSubTotal=orderSubTotal+(qtyOrdered*price)>
<!--- removed this code, not sure why it was there to begin with <cfif price NEQ 0><cfset orderCount=orderCount+qtyOrdered></cfif>//--->
<cfset orderCount=orderCount+qtyOrdered>
</cfloop>
<tr>
	<td colspan="2" align="right"><b>#orderCount#</b></td>
	<td colspan="5" align="right"><b>Total:</b></td>
	<td align="right"><b>#DollarFormat(orderSubTotal)#</b></td>
	<td>&nbsp;</td></tr>
</table>
	<p><b>SOLD TO:</b><br />
		<cfloop query="thisShipping">
		#thisShipping.firstName# #thisShipping.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop>
	<p><b>TERMS: </b> Net 30 Days</p>
	<p>Includes order numbers: #Replace(thisOrdersToAg,",",", ","all")#</p>
</body>
</html>
</cfmail>





<cfquery name="saveInvoice" datasource="#DSN#">
	update invoices
    set
    	poNum='#form.pono#',
        orderList='#form.orderList#',
        itemCount=#form.itemCt#,
        totalDue=<cfqueryparam value="#totalDue#" cfsqltype="cf_sql_money">,
        invDate=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
     where ID=#form.invno#
</cfquery>
<cfif form.submit NEQ "Save">
    <cfquery name="finishAggregate" datasource="#DSN#">
        update orders
        set oFlag1=<cfqueryparam value="yes" cfsqltype="cf_sql_bit">
        where ID IN (#form.orderList#)
    </cfquery>
</cfif>
<cfinclude template="pageHead.cfm">
<p>These orders have been finalized for aggregating: <cfoutput>#form.orderList#</cfoutput>.</p>
<p><a href="ordersAggregateStart.cfm">Continue</a></p>
<cfinclude template="pageFoot.cfm">