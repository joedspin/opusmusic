<cfparam name="form.custID" default="0">
<cfparam name="url.custID" default="#form.custID#">
<cfparam name="url.sortby" default="dateRequested">
<cfparam name="url.sortorder" default="DESC">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 . Purchase Order</title>
<style>
td {font-family:Arial, Helvetica, sans-serif; font-size: 10px;}
</style>
</head>

<body>

<cfquery name="onPurchOrder" datasource="#DSN#">
	select DISTINCT catItemID, catnum, Sum(qtyRequested-qtyReceived) As orderQuantity, artist, title, label, NRECSINSET, media, dateRequested, partner, cost
    from purchaseOrderDetailsQuery
    where customerID=#url.custID#
    group by catItemID, catnum, qtyRequested, artist, title, label, NRECSINSET, media, dateRequested, partner, cost
    order by dateRequested DESC, partner, catnum
</cfquery>
<cfif onPurchOrder.recordCount GT 0>
    <cfset poCt=0>
    <cfset partnerLast="">
    <cfoutput query="onPurchOrder">
	<cfif partnerLast NEQ partner>
    <cfif partnerLast NEQ "">
        <tr>
            <td align="right"><b>#recCount#</b></td>
            <td colspan="5">&nbsp;</td>
        </tr>
        </table>
    </cfif>
    <h1>#partner#</h1>
    <table cellpadding="6" cellspacing="0" border="1" style="border-collapse:collapse;" width="100%">
    <cfset recCount=0>
    </cfif>
    	<cfset poCt=poCt+1>
        <cfset recCount=recCount+orderQuantity>
    	<tr>
            <td align="right">#orderQuantity#</td>
            <td>#catnum#</td>
            <td>#label#</td>
            <td>#artist#</td>
            <td>#title#</td>
            <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
            <td>#DateFormat(dateRequested,"mmm d, yyyy")#</td>
            <td>#DollarFormat(cost)#</td>
        </tr>
       <cfset partnerLast=partner>
    </cfoutput>
    
</cfif>
</table>
</body>
</html>

