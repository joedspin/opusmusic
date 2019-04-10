<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Import Inventory</title>
<style>
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {vertical-align:top;}
</style>
</head>

<body>
<cfparam name="url.sb" default="ONHAND">
<cfquery name="invList" datasource="#DSN#">
	select *
    from catItemsQuery
    where isVendor=1 AND Left(shelfCode,1)<>'D' AND ONHAND>0 and albumStatusID<25
    order by releaseDate DESC
</cfquery>
<cfquery name="openOrders" datasource="#DSN#">
select firstName, lastName, email, qtyOrdered, catItemID, adminAvailID, statusID, dateStarted, dateUpdated, datePurchased, orderID, ignoreSales
    from orderItemsQuery 
    where adminAvailID IN (4,5) AND statusID<>7
</cfquery>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse; border-color: #333333;">
<cfoutput query="invList">
<cfquery name="sellHistory" dbtype="query">
	select sum(qtyOrdered) As numOnOrder
	from openOrders
	where catItemID=#ID#
</cfquery>
<cfif sellHistory.recordCount GT 0><cfset thisOnhand=ONHAND-sellHistory.numOnOrder><cfelse><cfset thisOnhand=ONHAND></cfif>
<cfif thisONHAND GT 0>
<tr>
<td>#DateFormat(releaseDate,"yyyy-mm-dd")#</td>
<td align="center">#thisOnhand#</td>
<td>#label#</td>
<td>#catnum#</td>
<td>#artist#</td>
<td>#title#</td>
<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
<cfif price LT cost><cfset thisPrice=price-1><cfelse><cfset thisPrice=cost-1></cfif>
<cfif thisPrice LT 1><cfset thisPrice=1></cfif>
<td>#DollarFormat(Ceiling(thisPrice)-0.01)#</td>
</tr>
</cfif>
</cfoutput>
</table>
</body>
</html>
