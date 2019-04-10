<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Invoice Report</title><br />
<style>
td {font-family:Arial, Helvetica, sans-serif; vertical-align:top;}
table {border-color: black;}
</style>
</head>

<body>
<cfquery name="getInvoice" datasource="#DSN#">
	select *
    from orderItemsQuery
    where dateUpdated>'2011-07-21' AND dateUpdated<'2011-07-23' AND adminAvailID>3 AND dtID>0 AND issueResolved=1 AND vendorID>0
    order by catnum
</cfquery>
<cfset qtyCount=0>
<cfset gtCount=0>
<table border="1" style="border-collapse:collapse;">
<cfoutput query="getInvoice">
	<tr>
    <td>#qtyOrdered#</td>
    <td>#UCase(catnum)#</td>
    <td>#UCase(label)#</td>
    <td>#UCase(artist)#</td>
    <td>#UCase(title)#</td>
    <td>#vendorID#</td>
    </tr>
    <cfset qtyCount=qtyCount+qtyOrdered>
	<cfif vendorID EQ 5439><cfset gtCount=gtCount+qtyOrdered></cfif>
</cfoutput>
<tr>
<cfoutput><td>#qtyCount#</td></cfoutput>
<td colspan="5">TOTAL</td>
</tr>
<tr>
<cfoutput><td>#gtCount#</td></cfoutput>
<td colspan="5">GEORGE T TOTAL</td>
</tr>
</table>
</body>
</html>
