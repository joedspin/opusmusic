<cfset pageName='ORDERS'>
<cfparam name="url.custID" default="2126">
<cfparam name="url.invoiceID" default="0">
<cfparam name="form.invno" default="">
<cfparam name="form.pono" default="">
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

<!---<cfloop query="thisOrder">
<cfif orderList NEQ ""><cfset orderList=orderList & ","></cfif>
<cfset orderList=orderList & "#ID#">
</cfloop>//--->

<cfoutput>
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
<cfset orderTempTotal=0>
<cfloop query="thisItems">
	<cfset orderTempTotal=orderTempTotal+(qtyOrdered*price)>
</cfloop>
<h1>Downtown 304 <cfif orderTempTotal GT 0>INVOICE<cfelse>CREDIT MEMO</cfif> ###thisInvNo#<!---#DateFormat(varDateODBC,"mmddyyyy")#//---></h1>
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
<form name="finishAggregate" method="post" action="ordersAggregateFinish.cfm">
	<cfoutput>
        <input type="hidden" name="orderList" value="#thisOrdersToAg#" />
        <input type="hidden" name="invno" value="#thisInvNo#" />
        <input type="hidden" name="pono" value="#thisPO#" />
        <input type="hidden" name="totalDue" value="#orderSubTotal#" />
        <input type="hidden" name="itemCt" value="#orderCount#" />
        <input type="hidden" name="ordersToAg" value="#form.ordersToAg#">
        <cfif url.invoiceID EQ 0><input type="submit" name="submit" value=" Finalize " /><cfelse><input type="submit" name="submit" value="Save" /></cfif>
    </cfoutput>
</form>

</body>
</html>
</cfoutput>