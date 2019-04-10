<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size: small; vertical-align:top;}
.tracks {font-size: xx-small;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>BS Shelf List</title>
</head>
<cfquery name="bslist" datasource="#DSN#">
	select *
    from catItemsQuery
    where shelfCode='BS' AND ONHAND>0 AND albumStatusID<25 order by label, catnum
</cfquery>
<body>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" bordercolor="black">
<cfoutput query="bslist">
<tr><td><cfif discogsID NEQ 0>DISCOGS<cfelse>&nbsp;</cfif><td>#label#</td><td>#UCase(catnum)#</td><td><b>#artist#</b></td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td><td>[#ONHAND#]</td></tr>
</cfoutput>
</table>
</body>
</html>
