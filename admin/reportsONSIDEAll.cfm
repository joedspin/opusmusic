<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>DT304 ONSIDE Report</title>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size:11px}
</style>
</head>

<body>
<cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput>
<cfquery name="operationCleanONSIDE" datasource="#DSN#">
	select *
	from catItemsQuery
	where ONSIDE>0 AND ONSIDE<>999
	order by label, catnum
</cfquery>
<cfset lastLabel=0>
<table border="1" cellpadding="2" style="border-collapse:collapse;">
<cfoutput query="operationCleanONSIDE">
<cfif labelID NEQ lastLabel>
	<tr><td colspan="7"><b>#label#</b></td>
	<cfset lastLabel=labelID>
</cfif>
<cfquery name="sellHistory" datasource="#DSN#">
	select Max(dateUpdated) as lastSellDate
	from orderItemsQuery
	where catItemID=#ID# AND adminAvailID=6
</cfquery>
<tr><td align="right">#ONHAND#</td>
	<td align="right">#ONSIDE#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#Left(artist,20)#</td>
	<td>#left(title,20)#</td>
	<td><cfif sellHistory.recordCount GT 0>#DateFormat(sellHistory.lastSellDate,"mm/dd/yyyy")#<cfelse>NEVER</cfif></tr>
</cfoutput>
</table>
</body>
</html>
