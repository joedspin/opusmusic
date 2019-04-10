<cfquery name="thisCust" datasource="#DSN#">
	select *
    from custAccounts
    where ID=#thisOrder.custID#
</cfquery>
<cfmail to="#thisCust.email#" from="order@downtown304.com" cc="order@downtown304.com" type="html" subject="Shelf List">
	<html>
<head>
</head>
<body>

<cfloop query="thisOrder">
<cfset thisOrderSub=orderSub>
<cfset thisOrderShipping=orderShipping>
<cfset thisOrderTax=orderTax>
<cfset thisOrderTotal=orderTotal>
<cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#thisOrder.ID# AND (adminAvailID>3) order by label, catnum
</cfquery>
<cfif thisItems.recordCount GT 0>

<cfoutput>
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {padding: 2px;}
//-->
</style>
<h2><cfif thisOrder.dateShipped NEQ "">#DateFormat(thisOrder.dateShipped,"mmmm d, yyyy")#<cfelse>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfif> (<cfif thisCust.billingName NEQ "">#thisCust.billingName#<cfelse>#thisCust.firstName# #thisCust.lastName#</cfif>)</h2>
<table border="1" style="border-collapse:collapse;" width="100%">
<tr bgcolor="##CCCCCC">
	<td align="center">QTY</td>
	<td>CATNUM</td>
	<td>LABEL</td>
	<td>ARTIST</td>
	<td>TITLE</td>
	<td>MEDIA</td>
	<td align="center">PRICE</td>
	<td align="center">TOTAL</td>
</tr>
<cfset thisSubTotal=0>
<cfset thisCount=0>
<cfloop query="thisItems">
<tr>
		<td align="center">#qtyOrdered#</td>
		<td valign="top">#catnum#</td>
		<td valign="top">#label#</td>
		<td valign="top">#artist#</td>
		<td valign="top">#title#</td>
		<td valign="top"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	    <td valign="top" align="right">#DollarFormat(price)#</td>
		<td valign="top" align="right">#DollarFormat(qtyOrdered*price)#</td>
	</tr>
    <cfset thisSubTotal=thisSubTotal+(qtyOrdered*price)>
    <cfif catnum NEQ "000000" AND catnum NEQ "GST000X"><cfset thisCount=thisCount+qtyOrdered></cfif>
</cfloop>
</table>
<p style="font-size: medium;">Count: #thisCount#</p>
<p><b>Order Sub-Total:</b> #DollarFormat(thisSubTotal)#</p>
</cfoutput>
</cfif>
</cfloop>
	</body></html></cfmail>

