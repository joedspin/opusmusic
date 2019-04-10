<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DT 161 New Releases Report</title>
<style>
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {vertical-align:top;}
</style>
</head>

<body>
<cfparam name="url.sb" default="ONHAND">
<cfquery name="invList" datasource="#DSN#">
	select catItemsQuery.*, DTalbumStatus.album_Status_Name as albumStatus
    from catItemsQuery left join DTalbumStatus ON catItemsQuery.albumStatusID=DTalbumStatus.ID
    where Left(shelfCode,1)='D' AND releaseDate>=<cfqueryparam cfsqltype="cf_sql_date" value="4/1/2010"> AND albumStatusID<100
    order by label, catnum
</cfquery>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse; border-color: #333333;">
<cfoutput query="invList">
<tr>
<td>#label#</td>
<td>#catnum#</td>
<td>#artist#</td>
<td>#title#</td>
<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>
<td>#albumStatus#</td>
</tr>
</cfoutput>
</table>
</body>
</html>
