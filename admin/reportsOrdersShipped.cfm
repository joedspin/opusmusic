<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304: Orders Recently Shipped</title>
</head>
<style>
td {font-family:Arial, Helvetica, sans-serif; font-size:xx-small;}
</style>
<body>
<cfparam name="url.filter" default="0">
<cfif url.filter NEQ "0">
	<cfset addFilter="AND otherSiteID="&url.filter>
</cfif>
<cfquery name="recOrders" datasource="#DSN#" maxrows="50">
	select * 
    from orders LEFT JOIN custAccounts ON custAccounts.ID=orders.custID
    where statusID=6 #addFilter#
    order by dateShipped DESC
</cfquery>
<cfquery name="ordersShipped" dbtype="query">
	select *
    from recOrders
    order by username
</cfquery>
<table>
<cfoutput query="ordersShipped">
<tr>
	<td>#ID#</td>
    <td>#username#</td>
    <td>#firstName# #lastName#</td>
    <td>#specialInstructions#</td>
    <td>#DateFormat(dateShipped,"yyyy/mm/dd")#
</tr>
</cfoutput>
</body>
</html>
