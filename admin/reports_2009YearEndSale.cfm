<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
body, td {font-family:Arial, Helvetica, sans-serif; font-size:xx-small;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<cfquery name="saleItems" datasource="#DSN#">
	select distinct ID, catnum, label, artist, title, media, NRECSINSET, cost, price, ONHAND
    from catItemsQuery
    where ID NOT IN (select catItemID as ID from orderItemsQuery where dateShipped> '2009-08-01' and statusID=6) AND ID NOT IN (select catItemID as ID from orderItemsQuery where orderID=20304) AND left(shelfCode,1)<>'D' AND shelfCode<>'SY' AND shelfCode<>'LO' AND label NOT like '%FXHE%' AND releaseDate<'2009-10-01' AND albumStatusID<25 AND ONHAND>0
    group by ID, catnum, label, artist, title, media, NRECSINSET, cost, price, ONHAND
    order by label, catnum
</cfquery>
<body>
<table>
<cfoutput query="saleItems">
<tr><td align="right">#ONHAND#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
    <td><cfif price LT cost>#DollarFormat(price)#<cfelse>#DollarFormat(cost-1)#</cfif></td>
</tr>
</cfoutput>
</table>
</body>
</html>
<cfquery name="clearSpecialFlag" datasource="#DSN#">
	update catItems
    set specialItem=0
</cfquery>
<cfquery name="fixNewR" datasource="#DSN#">
	update catItems
    set albumStatusID=24
    where albumStatusID<23 AND ONHAND>0 AND shelfID NOT IN (7,11,13) AND releaseDate<'2009-10-01'
</cfquery>
<cfquery name="saleprices2009" datasource="#DSN#">
	update catItems
    set price=cost-1, specialItem=1
    where ID NOT IN (select catItemID as ID from orderItemsQuery where dateShipped>'2009-08-01' and statusID=6) AND ID NOT IN (select catItemID as ID from orderItemsQuery where orderID=20304) AND shelfID NOT IN (7,11,13,14,36) AND labelID<>6243 AND releaseDate<'2009-10-01' AND albumStatusID<25 AND ONHAND>0 and price>cost
</cfquery>
