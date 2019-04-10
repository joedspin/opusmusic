<cfquery name="catFind" datasource="#DSN#">
	select *
	from catTracksQuery
	where (artist LIKE <cfqueryparam value="%darryl james%" cfsqltype="cf_sql_char"> OR
		artist LIKE <cfqueryparam value="%DFA%" cfsqltype="cf_sql_char"> OR
		title LIKE <cfqueryparam value="%DFA%" cfsqltype="cf_sql_char"> OR
		title LIKE <cfqueryparam value="%Fall Out%" cfsqltype="cf_sql_char"> OR
		label LIKE <cfqueryparam value="%Fall Out%" cfsqltype="cf_sql_char"> OR
		tName LIKE <cfqueryparam value="%DFA%" cfsqltype="cf_sql_char">) 
		AND labelID<>259
		AND ((left(shelfCode,'1')='D' OR isVendor=1) AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0))
		order by itemID DESC, tSort
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>opus lists</title>
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<style type="text/css">
td img {display: block;}body {
	background-color: #000000;
}
.style1 {color: #333333}
.style2 {color: #333333; font-weight: bold; }
</style>
</head>

<body onLoad="MM_preloadImages('images/boxButtonListen_f3.jpg','images/boxButtonListen_f2.jpg','images/boxButtonBuy_f3.jpg','images/boxButtonBuy_f2.jpg','images/boxButtonBin_f3.jpg','images/boxButtonBin_f2.jpg','images/boxButtonView_f3.jpg','images/boxButtonView_f2.jpg')">
<cfinclude template="topNav.cfm">
<table border="0" cellpadding="4" cellspacing="0" style="border-collapse:collapse;" align="center">

<tr>
	<td align="left" valign="bottom"><h4>Darryl James (aka DFA)<br />
		<font size="1"><a href="http://www.myspace.com/djdarryljames" target="_blank">View Darryl James's Myspace page</a></font></h4>
	  </td>
</tr>
<cfinclude template="artistPage.cfm">