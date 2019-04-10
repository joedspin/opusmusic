<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 - Catalog Sorting Guide</title>
<style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: small;
	color: #FFFFFF;
}
body {
	background-color: #333333;
	margin-left: 80px;
	margin-top: 80px;
}
-->
</style></head>

<body>
<cfparam name="url.catnum" default="nothingtofind">
<cfquery name="alphaGuide" datasource="#DSN#" maxrows="6">
	select *
    from catItemsQuery
    where catnum<='#url.catnum#' AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999 AND left(shelfCode,1)<>'D'
    order by label, catnum DESC
</cfquery>
<cfset listOutput="">
<cfloop query="alphaGuide">
	<cfif catnum EQ url.catnum>
        <cfset listOutput="<tr bgcolor='##3399CC' style='font-weight: bold;'><td>" &catnum & "</td><td>" & label & "</td><td>" & UCase(artist) & "</td><td>" & title & "</td></tr>" & listOutput>
    <cfelse>
        <cfset listOutput="<tr><td>" &catnum & "</td><td>" & label & "</td><td>" & UCase(artist) & "</td><td>" & title & "</td></tr>" & listOutput>
    </cfif>
</cfloop>
<cfquery name="alphaGuide" datasource="#DSN#" maxrows="5">
	select *
    from catItemsQuery
    where catnum>'#url.catnum#' AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999 AND left(shelfCode,1)<>'D'
    order by label, catnum
</cfquery>
<cfloop query="alphaGuide">
	<cfset listOutput=listOutput&"<tr><td>" &catnum & "</td><td>" & label & "</td><td>" & UCase(artist) & "</td><td>" & title & "</td></tr>">
</cfloop>
<cfoutput><table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">#listOutput#</table></cfoutput>
</body>
</html>
