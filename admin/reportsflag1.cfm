<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size: small;}
.tracks {font-size: xx-small;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Import Sale</title>
</head>
<cfquery name="flaglist" datasource="#DSN#">
	select *
    from catItemsQuery
    where flag1=1 AND ONHAND>0 AND albumStatusID<25 order by label, catnum
</cfquery>
<body>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" bordercolor="black">
<cfoutput query="flaglist">
<tr><td>#label#<br /><font class="tracks">#UCase(catnum)#</font></td><td><b>#artist#</b><br />#title#&nbsp;&nbsp;&nbsp;(<cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#) [#ONHAND#]</td></tr>
</cfoutput>
</table>
</body>
</html>
