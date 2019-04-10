<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
</head>

<body>
<cfquery name="listit" datasource="#DSN#">
	select *
	from catItems
	where specialItem=1
</cfquery>
<!---
<cfquery name="catFind" dbtype="query" maxrows="#backmax#">
	select *
	from Application.dt#siteChoice#Items
	where ((ONHAND>0  AND (albumStatusID<=22 OR albumStatusID=148)) OR ONSIDE>0 OR albumStatusID=30)
		#labelExclusions# #notNewSwitch# #ONSIDE999#
		AND releaseDate>'#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#'
	order by #thisOrderBy# #thisSortOrder##ONHANDswitch#
</cfquery>//--->

<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="listit">
<tr>
	<td>#ONHAND#</td>
    <td>#DateFormat(realReleaseDate,"yyyy-mm-dd")#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td> 
	<td>#DollarFormat(price)#</td>
    <td>#DollarFormat(price*.75)#</td>
</tr>
</cfoutput>
</table>
</body>
</html>
