<cfparam name="form.vendorID" default="0">
<cfparam name="url.vendorID" default="#form.vendorID#">
<cfparam name="url.sortby" default="dateRequested">
<cfparam name="url.sortorder" default="DESC">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 . Purchase Order</title>
<style>
td {font-family:Arial, Helvetica, sans-serif; font-size: 11px;}
body {font-family:Arial, Helvetica, sans-serif; font-size: 11px;}
</style>
</head>

<body>

<cfif url.vendorID EQ 15>
<cfquery name="onPurchOrder" datasource="#DSN#">
	select DISTINCT catItemID, catnum, Sum(qtyRequested-qtyReceived) As orderQuantity, artist, title, label, NRECSINSET, media, dateRequested, partner, POItem_ID, vendorID, shelfCode, albumStatusID
    from purchaseOrderDetailsQuery
    where vendorID IN (15,31,32,33,34) and completed<>1 AND qtyRequested<>0 AND qtyRequested>qtyReceived
    group by catItemID, catnum, qtyRequested, artist, title, label, NRECSINSET, media, dateRequested, partner, POItem_ID, vendorID, shelfCode, albumStatusID
    order by vendorID, #url.sortby# #url.sortorder#
</cfquery>
<cfelse>
<cfquery name="onPurchOrder" datasource="#DSN#">
	select DISTINCT catItemID, catnum, Sum(qtyRequested-qtyReceived) As orderQuantity, artist, title, label, NRECSINSET, media, dateRequested, partner, POItem_ID, shelfCode, albumStatusID
    from purchaseOrderDetailsQuery
    where vendorID=#url.vendorID# and completed<>1 AND qtyRequested<>0 AND qtyRequested>qtyReceived
    group by catItemID, catnum, qtyRequested, artist, title, label, NRECSINSET, media, dateRequested, partner, POItem_ID, shelfCode, albumStatusID
    order by #url.sortby# #url.sortorder#
</cfquery>
</cfif>
<h1><cfoutput>#onPurchOrder.partner#</cfoutput></h1>
<table cellpadding="6" cellspacing="0" border="1" style="border-collapse:collapse;" width="100%">
<cfoutput><tr style="font-weight:bold;">
	<td>ORD</td>
    <td><cfif url.sortby NEQ "catnum"><a href="reportsPO.cfm?vendorID=#url.vendorID#&sortby=catnum&sortorder=ASC">CATNUM</a>&nbsp;&nbsp;<cfelse>CATNUM</cfif></td>
    <td><cfif url.sortby NEQ "label"><a href="reportsPO.cfm?vendorID=#url.vendorID#&sortby=label&sortorder=ASC">LABEL</a>&nbsp;&nbsp;<cfelse>LABEL</cfif></td>
    <td><cfif url.sortby NEQ "artist"><a href="reportsPO.cfm?vendorID=#url.vendorID#&sortby=artist&sortorder=ASC">ARTIST</a>&nbsp;&nbsp;<cfelse>ARTIST</cfif></td>
    <td><cfif url.sortby NEQ "title"><a href="reportsPO.cfm?vendorID=#url.vendorID#&sortby=title&sortorder=ASC">TITLE</a><cfelse>TITLE</cfif></td>
    <td><cfif url.sortby NEQ "media"><a href="reportsPO.cfm?vendorID=#url.vendorID#&sortby=media&sortorder=ASC">MEDIA</a><cfelse>MEDIA</cfif></td>
    <td><cfif url.sortby NEQ "status"><a href="reportsPO.cfm?vendorID=#url.vendorID#&sortby=albumStatusID&sortorder=DESC">STATUS</a><cfelse>STATUS</cfif></td>
    <td><cfif url.sortby NEQ "dateRequested"><a href="reportsPO.cfm?vendorID=#url.vendorID#&sortby=dateRequested&sortorder=DESC">DATE</a><cfelse>DATE</cfif></td>
    <td>&nbsp;</td>
</tr></cfoutput>   
<cfset listoutput="">
<cfset recCount=0>
<cfset prevCat="">
<cfset catSum=0>
<cfset lastRow="">
<cfset lastShelf="">
<cfif onPurchOrder.recordCount GT 0>
    <cfset poCt=0>
    <cfloop query="onPurchOrder">
    	
    	<cfset poCt=poCt+1>
        <cfset recCount=recCount+orderQuantity>
		<cfif albumStatusID EQ 44><cfset status="NEW"><cfelse><cfset status="RESTOCK"></cfif>
        <cfif catnum EQ prevCat>
        	<cfset catSum=NumberFormat(catSum)+NumberFormat(orderQuantity)>
			<cfset lastRow="<tr><td align='right'>#catSum#</td>
                <td>#UCASE(catnum)#</td>
                <td>#UCASE(label)#</td>
                <td>#UCASE(artist)#</td>
                <td>#UCASE(title)#</td>
                <td>">
                <cfif NRECSINSET GT 1>
                    <cfset lastRow=lastRow&NRECSINSET&"x">
                </cfif>
                <cfset lastRow=lastRow&"#media#</td>
				<td>#status#</td>
                <td>#DateFormat(dateRequested,"mmm d, yyyy")#</td>">
                <cfif url.sortby NEQ "catnum">
                    <cfset lastRow=lastRow&"<td><a href='reportsPOdelete.cfm?ID=#POItem_ID#&vendorID=#url.vendorID#'>DEL</a></td></tr>">
                <cfelse>
                    <cfset lastRow=lastRow&"<td align='center'>#shelfCode#</td></tr>">
                </cfif>
        <cfelse>
        	<cfset listoutput=listoutput&lastRow>
            <cfset prevCat=catnum>
            <cfset catSum=NumberFormat(orderQuantity)>
			<cfset lastRow="<tr><td align='right'>#catSum#</td>
            <td>#UCASE(catnum)#</td>
            <td>#UCASE(label)#</td>
            <td>#UCASE(artist)#</td>
            <td>#UCASE(title)#</td>
            <td>">
			<cfif NRECSINSET GT 1>
            	<cfset lastRow=lastRow&NRECSINSET&"x">
			</cfif>
            <cfset lastRow=lastRow&"#media#</td>
			<td>#status#</td>
            <td>#DateFormat(dateRequested,"mmm d, yyyy")#</td>">
            <cfif url.sortby NEQ "catnum">
            	<cfset lastRow=lastRow&"<td><a href='reportsPOdelete.cfm?ID=#POItem_ID#&vendorID=#url.vendorID#'>DEL</a></td></tr>">
			<cfelse>
            	<cfset lastRow=lastRow&"<td align='center'>#shelfCode#</td></tr>">
			</cfif>
        </cfif>
        <cfif shelfCode NEQ lastShelf AND lastShelf NEQ "">
        	<cfset listoutput=listoutput&"<tr><td colspan=8>#shelfCode#</td></tr>">
        </cfif>
        <cfset lastShelf=shelfCode>
    </cfloop>
    <cfset listoutput=listoutput&lastRow>
    <cfoutput>#listoutput#</cfoutput>
    <tr>
    	<td align="right"><b><cfoutput>#recCount#</cfoutput></b></td>
        <td colspan="7">&nbsp;</td>
    </tr>
</cfif>
</table>
</body>
</html>

