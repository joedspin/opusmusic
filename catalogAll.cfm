<cfparam name="url.joepass" default=""><cfif url.joepass NEQ "go"><cfabort></cfif><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>downtown304.com</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<style type="text/css">
<!--
td {vertical-align:top; font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	color:#CCCCCC}
body {
	background-color: #000000;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color:#CCCCCC;
}
.style1 {color: #FFCC00;	font-weight: bold;}
.style2 {color: #333333}
.style3 {color:#FF6699;	font-weight: bold;}
.style5 {color: #000000; font-weight: bold; }
-->
</style></head>
<body onload="MM_preloadImages('images/topnav_v2_r2_c2_f2.jpg','images/topnav_v2_r2_c2_f3.jpg','images/topnav_v2_r2_c4_f2.jpg','images/topnav_v2_r2_c4_f3.jpg','images/topnav_v2_r2_c6_f2.jpg','images/topnav_v2_r2_c6_f3.jpg','images/topnav_v2_r2_c8_f2.jpg','images/topnav_v2_r2_c8_f3.jpg','images/topnav_v2_r2_c10_f2.jpg','images/topnav_v2_r2_c10_f3.jpg','images/topnav_v2_r2_c12_f2.jpg','images/topnav_v2_r2_c12_f3.jpg','images/topnav_v2_r2_c14_f2.jpg','images/topnav_v2_r2_c14_f3.jpg','images/topnav_v2_r2_c16_f2.jpg','images/topnav_v2_r2_c16_f3.jpg');">

<cfquery name="inventoryReport" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select *
	from catItemsQuery
	where (isVendor=1 OR shelfID=11 OR shelfCode='BS') AND ((ONHAND>0  AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
    order by label, catnum
</cfquery>
<p>&nbsp;</p>
<table border="1" cellpadding="4" cellspacing="0" width="90%" style="border-collapse:collapse;" align="center">
<cfoutput query="inventoryReport">
<tr><td>#label#</td><td>#catnum#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td><td><a href="opussitelayout07main.cfm?sID=#ID#">VIEW</a></td></tr>
</cfoutput>
</table>
<p>&nbsp;</p>
</body>
</html>