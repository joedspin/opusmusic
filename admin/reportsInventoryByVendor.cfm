<cfparam name="form.vendorID" default="0">
<cfparam name="url.vendorID" default="#form.vendorID#">
<cfparam name="url.nozeroes" default="false">
<cfparam name="url.full" default="false">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 . Catalog Received</title>
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size:small;}
//-->
</style>
</head>

<body>
<!---<cfif form.vendorID EQ 0><cfset thisID=url.vendorID><cfelse><cfset thisID=form.vendorID></cfif>//--->
<cfset thisID=url.vendorID>
<cfif thisID EQ 1059 OR thisID EQ 2127 OR thisID EQ 2131 OR thisID EQ 2136>
	<cfset thisVendorString=" IN (1059,2127,2131,2136)">
<cfelse>
	<cfset thisVendorString="=#thisID#">
</cfif>
<!---<cfif thisID EQ 15><cfset searchstring="shelfID IN (15,31,32,33,34)"><cfelse><cfset searchstring="(shelfID=#thisID# OR ID IN (select DISTINCT catItemID from catRcvd where rcvdShelfID=#thisID#))"></cfif>//--->
<cfif url.full><cfset thismax="-1"><cfelse><cfset thismax="999"></cfif>
<cfif url.nozeroes EQ true>
<cfquery name="inven" datasource="#DSN#" maxrows="#thismax#">
	select *
    from catItemsQuery
    where (shelfID#thisVendorString# OR ID IN (select DISTINCT catItemID from catRcvd where rcvdShelfID#thisVendorString#)) AND ONHAND>0
   	order by releaseDate DESC, ONHAND DESC
</cfquery><!---order by label, catnum//--->
<cfoutput><a href="reportsInventoryByVendor.cfm?vendorID=#url.vendorID#&nozeroes=false">Include Zeroes</a></cfoutput>
<cfelse>
<cfquery name="inven" datasource="#DSN#" maxrows="#thismax#">
	select *
    from catItemsQuery
    where (shelfID#thisVendorString# OR ID IN (select DISTINCT catItemID from catRcvd where rcvdShelfID#thisVendorString#)) AND albumStatusID<>148
   	order by releaseDate DESC, ONHAND DESC
</cfquery>
<cfoutput><a href="reportsInventoryByVendor.cfm?vendorID=#form.vendorID#&nozeroes=true&full=#url.full#">No Zeroes</a> <a href="reportsInventoryByVendor.cfm?vendorID=#form.vendorID#&full=true&nozeroes=#url.nozeroes#">Full Inventory</a></cfoutput>
</cfif>
<table border='1' cellpadding='3' cellspacing='0' style="border-collapse:collapse;">
<tr>
    	<td>VND</td>
        <td>DISCOGS</td>
    	<td>CATNUM</td>
        <td>LABEL</td>
        <td>ARTIST</td>
        <td>TITLE</td>
        <td>MEDIA</td>
        <td>COST</td>
        <td>WHOLESALE</td>
        <td>REL DATE</td>
        <td>ONHAND</td>
        <td align="center">SOLD</td>
        <td align="center">OPEN</td>
        <td align="center">CARTS</td>
        <td align="center">BACKORDER</td>
        <td align="center">ON ORDER</td>
     </tr>
<cfquery name="thisOrderBrief" datasource="#DSN#">
	select *
    from orderItemsBrief
    where (shelfID#thisVendorString# OR catItemID IN (select DISTINCT catItemID from catRcvd where rcvdShelfID#thisVendorString#))
</cfquery>
<cfoutput query="inven">
<cfif thisID EQ "2127">
	<cfquery name="sellhist" dbtype="query">
		select Sum(qtyOrdered) As SOLD, catItemID
		from thisOrderBrief
		where adminAvailID=6 AND statusID=6 AND catItemID=#ID# AND dateShipped>='2016-11-01'
		group by catItemID
	</cfquery>
<cfelse>
	<cfquery name="sellhist" dbtype="query">
		select Sum(qtyOrdered) As SOLD, catItemID
		from thisOrderBrief
		where adminAvailID=6 AND statusID=6 AND catItemID=#ID#
		group by catItemID
	</cfquery>
</cfif>
<cfquery name="open" dbtype="query">
    select Sum(qtyOrdered) As SOLD, catItemID
    from thisOrderBrief
    where adminAvailID IN (2,4,5) AND statusID NOT IN (1,7) AND catItemID=#ID#
    group by catItemID
</cfquery>
<cfquery name="demand" dbtype="query">
    select Sum(qtyOrdered) As INCART, catItemID
    from thisOrderBrief
    where adminAvailID IN (0,1,2) AND statusID=1 AND dateUpdated>'#DateFormat(DateAdd('d',-60,varDateODBC),"yyyy-mm-dd")#'  AND catItemID=#ID#
    group by catItemID
</cfquery>

<cfquery name="backorder" dbtype="query">
    select Sum(qtyOrdered) As BACKORDER, catItemID
    from thisOrderBrief
    where adminAvailID=3 AND dateUpdated>'#DateFormat(DateAdd('d',-60,varDateODBC),"yyyy-mm-dd")#' AND catItemID=#ID#
    group by catItemID
</cfquery>
<cfquery name="onorder" datasource="#DSN#">
    select Sum(qtyRequested-qtyReceived) As ONORDER, catItemID
    from purchaseOrderDetails
    where completed=0 AND qtyRequested>qtyReceived AND catItemID=#ID#
    group by catItemID
</cfquery>
<cfif demand.INCART NEQ ""><cfset thisDemand=demand.INCART><cfelse><cfset thisDemand=0></cfif>
<cfif sellhist.SOLD NEQ ""><cfset thisSold=sellhist.SOLD><cfelse><cfset thisSold=0></cfif>
	<tr <cfif albumStatusID LTE 20 OR albumStatusID GTE 25>bgcolor="magenta"<cfelseif ONHAND-thisDemand LTE 0 AND thisDemand GT 0>bgcolor="cyan"<cfelseif ONHAND-thisDemand LT thisSold AND thisDemand GT 0>bgcolor="yellow"</cfif>>
    	<td>#shelfCode#</td>
	<td><cfif discogsID GT 0><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">#discogsID#</a><cfelse><a href="http://www.discogs.com/search/?q=#catnum#&type=all" target="discogsFrame">Find</a></cfif></td>
    	<td><a href="catalogEdit.cfm?ID=#ID#" target="orderingitems">#catnum#</a></td>
        <td>#Left(label,15)#</td>
        <td>#Left(artist,20)#</td>
        <td>#Left(title,20)#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#Left(media,4)#</td>
        <td>#DollarFormat(cost)#</td>
        <td>#DollarFormat(wholesalePrice)#</td>
        <td>#DateFormat(releaseDate,"yyyy-mm-dd")#</td>
        <td align="center">#ONHAND#</td>
    	<!---<cfquery name="buyhist" dbtype="query">
            select *
            from buyHistoryAll
            where catItemID=#ID#
        </cfquery>
        <td align="center"><cfif buyhist.recordCount GT 0>#buyhist.BOUGHT#<cfelse>&nbsp;</cfif></td>//--->
        <td align="center"><cfif sellhist.recordCount GT 0>#sellhist.SOLD#<cfelse>0</cfif></td>
        <td align="center"><cfif sellhist.recordCount GT 0>#open.SOLD#<cfelse>0</cfif></td>
        <td align="center"><cfif demand.recordCount GT 0>#demand.INCART#<cfelse>0</cfif></td>
        <td align="center"><cfif demand.recordCount GT 0>#backorder.BACKORDER#<cfelse>0</cfif></td>
        <td align="center"><cfif onorder.recordCount GT 0>#onorder.ONORDER#<cfelse>0</cfif></td>
     </tr>
</cfoutput>
</table>
</body>
</html>
