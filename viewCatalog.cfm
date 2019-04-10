<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 - Full Catalog</title>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size: x-small; vertical-align:top;}
</style>
</head>

<body>
<cfquery name="allCatItemsPage" dbtype="query">
	select label,catnum,artist,title,NRECSINSET,media,price,genre,reissue,countryAbbrev,ONHAND,ONSIDE
    from Application.dt304items
    order by label, catnum
</cfquery>
<table border="1" style="border-collapse:collapse;" cellpadding="2" cellspacing="0">
<cfoutput query="allCatItemsPage">
<tr>
<td>#UCase(label)#</td>
<td>#UCase(catnum)#</td>
<td>#UCase(artist)#</td>
<td>#UCase(title)#</td>
<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
<td>#DollarFormat(price)#</td>
<td>#genre#</td>
<td>#countryAbbrev#</td>
<td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
<td>#ONHAND+ONSIDE#</td>
</tr>
</cfoutput>
</table>
</body>
</html>
