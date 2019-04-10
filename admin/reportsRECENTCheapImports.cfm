<cfparam name="url.statusID" default="21"><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size:11px}
</style>
</head>

<body>
<cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput>
<cfquery name="recentCheap" datasource="#DSN#">
	select *
	from catItemsQuery
	where ONSIDE<>999 AND (albumStatusID<25 AND ONHAND>0) AND left(shelfCode,1)<>'D' AND cost<8.00
	order by releaseDate DESC
</cfquery>
<table border="1" cellpadding="2" style="border-collapse:collapse;">
<cfoutput query="recentCheap">
<tr>
	<td>#DateFormat(releaseDate,"mm-dd-yy")#</td>
    <td align="right">#ONHAND#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#Left(artist,20)#</td>
	<td>#left(title,20)#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
    <td>#DollarFormat(cost)#</td></tr>
</cfoutput>
</table>
</body>
</html>
