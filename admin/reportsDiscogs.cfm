<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Needs Discogs ID</title>
<style>
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {vertical-align:top;}
</style>
</head>

<body>
<cfparam name="url.sb" default="ONHAND">
<cfquery name="invList" datasource="#DSN#">
	select *
    from catItemsQuery
    where (ONSIDE>0 OR (ONHAND>0 AND AlbumStatusID<25)) AND ONSIDE<>999 AND (discogsID='' OR discogsID<=0) AND mediaID NOT IN (19,20,21,22,23,24)
    order by dtDateUpdated, label, catnum
</cfquery>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse; border-color: #333333;">
<cfoutput query="invList">
<tr>
<td align="center">#discogsID#</td>
<td align="center">#ONHAND#</td>
<td>#label#</td>
	<td><a href="catalogEdit.cfm?ID=#ID#" target="discogsedit">#catnum#</a></td>
<td>#artist#</td>
<td>#title#</td>
<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
<td>#DateFormat(releaseDate,"yyyy-mm-dd")#</td>
</tr>
</cfoutput>
</table>
</body>
</html>
