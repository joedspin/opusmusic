<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Label Zeroes</title>
<style>
td {font-size: x-small;}
</style>
</head>
<cfparam name="url.labelID" default="0">
<cfquery name="listOutOfStockONSIDE" datasource="#DSN#">
	select *
    from catItemsQuery
    where ONSIDE<1 AND labelID=#url.labelID# and left(shelfCode,1)='D' AND shelfCode<>'DO' AND noReorder=0
    order by catnum
</cfquery>
<body>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="listOutOfStockONSIDE">
<tr>
	<td>#catnum#</td>
    <td>#label#</td>
    <td>#artist#</td>
    <td>#title#</td>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
</tr>
</cfoutput>
</table>
</body>
</html>
