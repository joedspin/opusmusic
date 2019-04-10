<cfparam name="url.purchyear" default="#DateFormat(varDateODBC,"yyyy")-1#">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 . Catalog Received</title>
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
//-->
</style>
</head>
<body>
	<cfquery name="catRcvd" datasource="#DSN#">
        select *
        from catRcvd Left JOIN catItemsQuery ON catItemsQuery.ID=catRcvd.catItemID where 
       dateReceived > <cfqueryparam cfsqltype="cf_sql_date" value="#url.purchyear-1#-12-31"> AND dateReceived < <cfqueryparam cfsqltype="cf_sql_date" value="#url.purchyear+1#-01-01"> AND shelfID<>11
       </cfquery>
<h1>Downtown 304 . Catalog Received</h1>
<h2>Purchases <cfoutput>#url.purchyear#</cfoutput></h2>
<cfset receivedCount=0>
<cfset receivedCost=0>
<table border='1' cellpadding='4' cellspacing='0' style="border-collapse:collapse;">
<tr style="font-weight:bold; background-color:#CCCCCC;">
		<td>QTY</td>
        <td>CATNUM</td>
        <td>LABEL</td>
        <td>ARTIST</td>
        <td>TITLE</td>
        <td>MEDIA</td>
        <td>COST</td>
        <td>PRICE</td>
        <td>STATUS</td>
        <td>RLSDATE</td>
        <td>UPDTD</td>
</tr>
<cfoutput query="catRcvd">
<cfset receivedCount=receivedCount+qtyRcvd>
<cfset receivedCost=receivedCost+(qtyRcvd*cost)>
	<tr>
    	<td>#qtyRcvd#</td>
        <td>#catnum#</td>
        <td>#label#</td>
        <td>#artist#</td>
        <td>#title#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
        <td align="right">#DollarFormat(cost)#</td>
        <td align="right">#DollarFormat(price)#</td>
        <td>#Album_Status_Name#</td>
        <cfif DateFormat(releaseDate,"yyyy-mm-dd") NEQ DateFormat(varDateODBC,"yyyy-mm-dd")>
        	<td style="font-weight: bold;"><cfelse><td style="background-color:##CCCCCC;"></cfif>#DateFormat(releaseDate,"mm/dd/yy")#</td>
        <cfif DateFormat(dtDateUpdated,"yyyy-mm-dd") NEQ DateFormat(varDateODBC,"yyyy-mm-dd")>
        	<td style="font-weight: bold;"><cfelse><td style="background-color:##CCCCCC;"></cfif>
        #DateFormat(dtDateUpdated,"mm/dd/yy")#</td>
     </tr>
</cfoutput>
</table>
<cfoutput>Total  = #receivedCount#<br /><br />
Cost = #DollarFormat(receivedCost)#</cfoutput>
</body>
</html>
