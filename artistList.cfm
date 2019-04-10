<!---<cfcache timespan="#createTimeSpan(0,12,0,0)#">//--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>downtown304.com</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	background-color: #000000;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: white;
}
.style1 {
	color: #FFCC00;
	font-weight: bold;
}
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #CCCCCC;
}
a:link {
	color: #669933;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #669933;
}
a:hover {
	text-decoration: none;
	color: #FFCC00;
}
a:active {
	text-decoration: none;
	color: #66CCFF0;
}
-->
</style></head>
<body>
<cfparam name="url.letter" default="A">
<cfquery name="Application.letterList" datasource="#DSN#" cachedWithin="#CreateTimeSpan(1, 0, 0, 0)#">
	select DISTINCT Left(sort,1) As labelLetter
	FROM artists INNER JOIN catItemsQuery ON artists.ID = catItemsQuery.artistID
	WHERE shelfID=11 OR isVendor=1
	order by Left(sort,1)
</cfquery>
<cfquery name="allArtists" dbtype="query">
	select *
	from Application.artists
	WHERE artistLetter=<cfqueryparam value="#UCase(url.letter)#" cfsqltype="cf_sql_char"> OR artistLetter=<cfqueryparam value="#LCase(url.letter)#" cfsqltype="cf_sql_char">
</cfquery>
<cfset endCol1=allArtists.recordCount/2>
<cfset pageGroup="artists">
<!---cfinclude template="topNav.cfm">
    <cfinclude template="middleNav.htm">//--->
		<cfinclude template="middleNav.cfm">
<p>&nbsp;</p>
<table border="1" bordercolor="#669933" cellspacing="0" cellpadding="4" align="center" style="border-collapse:collapse;">
	<tr>
		<cfoutput query="Application.letterList">
			<cfif labelLetter NEQ "">
				<td align="center"><a href="artistList.cfm?letter=#UCase(labelLetter)#">#UCase(labelLetter)#</a></td>
			</cfif>
		</cfoutput>
	</tr>
</table>
<table border="0" cellpadding="10" cellspacing="0" style="border-collapse:collapse;">
<tr><td valign="top">
    	<cfset countArtists=0>
        <cfset colSplit=false>
<blockquote><cfset lastID=0><cfoutput query="allArtists"><cfif lastID NEQ ID>
        	<cfif countArtists GT endCol1 AND colSplit EQ false>
            	</td><td valign="top"><cfset colSplit=true>
            </cfif>
	<p style="margin-top: 9px; margin-bottom: 9px;"><a href="opussitelayout07main.cfm?af=#ID#&group=all">#name#</a></p>
<cfset lastID=ID></cfif>
            <cfset countArtists=countArtists+1></cfoutput></blockquote>
            </td></tr></table>
<p>&nbsp;</p>
</body>
</html>