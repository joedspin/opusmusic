<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size: small;}
.tracks {font-size: xx-small;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>New Releases</title>
</head>
<cfquery name="newList" datasource="#DSN#">
	select *
    from catTracks LEFT JOIN catItemsQuery ON catTracks.catID=catItemsQuery.ID
    where albumStatusID<22 AND releaseDate>'#DateFormat(DateAdd('d',-17,varDateODBC),"yyyy-mm-dd")#' AND ONSIDE<>999
    order by releaseDate DESC
</cfquery>
<body>
<table border="1" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" bordercolor="black">
<cfset lastID=0>
<cfset lastCATNUM="">
<cfoutput query="newList">
<cfif jpgLoaded AND NOT (fullImg NEQ "")>
		<cfset imagefile="items/oI#catID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
<cfif lastID NEQ catID>
<cfif lastID NEQ 0></td></tr></cfif><tr><td rowspan="2" valign="top"><img src="images/#imageFile#" width="75" height="75" /></td><td><b>#artist#</b><br />#title#&nbsp;&nbsp;&nbsp;(<cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#)<!--- [#ONHAND#]//---></td><td>#label#<br /><font class="tracks">#UCase(catnum)#</font></td></tr>
<tr><td colspan="2" class="tracks"></cfif>
<cfif lastCATNUM EQ catnum><br></cfif>#tName#
<cfset lastID=catID>
<cfset lastCATNUM=catnum>
</cfoutput>
</tr>
</table>
</body>
</html>
