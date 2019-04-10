<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 . Catalog Received</title>
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size:x-small;}
//-->
</style>
</head>

<body>
<cfquery name="topplers" datasource="#DSN#">
	select *
    from catItemsQuery
    where shelfCode='TO'
   	order by label, catnum
</cfquery>
<table border='1' cellpadding='2' cellspacing='0' style="border-collapse:collapse;">
<cfoutput query="topplers">
	<tr>
    	<td>#ONHAND#</td>
    	<td>#catnum#</td>
        <td>#Left(label,15)#</td>
        <td>#Left(artist,20)#</td>
        <td>#Left(title,20)#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#Left(media,4)#</td>
     </tr>
</cfoutput>
</table>
</body>
</html>
