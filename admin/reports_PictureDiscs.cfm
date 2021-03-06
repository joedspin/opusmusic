<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Picture Discs</title>
</head>

<body>
<cfquery name="djonly" datasource="#DSN#">
	select *
    from catItemsQuery
    where (labelID IN (4135,8993,461,8859,8795,8771,8772) OR title LIKE '%Picture Disc%' OR ID IN (39036,51031,62660,65328,65429,67870,67902,68627,68639,68643,68749,69853,70071)) AND albumStatusID<25 AND ONHAND>0
    order by artist, title
</cfquery>

<cfset lastcatnum="">
<cfoutput query="djonly">
<cfif catnum NEQ lastcatnum>
<cfset lastcatnum=catnum>
<table border="1" style="border-collapse:collapse;" cellpadding="10" cellspacing="0" width="600">
	<cfset activeItemID=ID>
    <cfif djonly.jpgLoaded>
		<cfset imagefile="items/oI#djonly.ID#.jpg">
    <cfelseif djonly.jpgLoaded AND logofile EQ "">
    	<cfset imagefile="items/oI#djonly.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
	<cfquery name="tracksdj"  datasource="#DSN#">
		select *
		from catTracks
		where catID=#activeItemID#
		order by tSort
	</cfquery>
    <tr>
    	<td rowspan="2" valign="top" width="75"><img src="http://www.downtown304.com/images/#imageFile#" /></td>
        <td valign="top" nowrap><strong>#Ucase(artist)#<br />#title#<br>#CATNUM#</strong>
        <td valign="top" nowrap width="25"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
    </tr>
    <tr>
    	<td colspan="2" nowrap>
        <cfset tstart=false>
        <cfloop query="tracksdj"><cfif tstart><br /></cfif><cfset tstart=true>#tName#</cfloop>&nbsp;</td>
    </tr>
</table><img src="images/spacer.gif" width="600" height="10" />
</cfif>
</cfoutput>

</body>
</html>