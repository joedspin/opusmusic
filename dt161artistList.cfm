<!---<cfcache timespan="#createTimeSpan(0,12,0,0)#">//--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown161</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: black;
}
.style1 {
	color:#000033;
	font-weight: bold;
}
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #CCCCCC;
}
a:link {
	color:#003399;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #003399;
}
a:hover {
	text-decoration: none;
	color: #003399;
}
a:active {
	text-decoration: none;
	color: #003399;
}
-->
</style></head>
<body>
<cfparam name="url.letter" default="A">
<cfquery name="letterList" datasource="#DSN#" cachedWithin="#CreateTimeSpan(1, 0, 0, 0)#">
	select DISTINCT Left(sort,1) As labelLetter
	FROM artists INNER JOIN catItemsQuery ON artists.ID = catItemsQuery.artistID
	WHERE (shelfID=11 AND albumStatusID<25 AND ONHAND>0)
	order by Left(sort,1)
</cfquery>
<!---select *
	from artists
	WHERE artistLetter=<cfqueryparam value="#UCase(url.letter)#" cfsqltype="cf_sql_char"> OR artistLetter=<cfqueryparam value="#LCase(url.letter)#" cfsqltype="cf_sql_char">//--->
<cfquery name="allArtists" datasource="#DSN#">
	select DISTINCT artists.ID AS ID, name, sort
	from artists LEFT JOIN catItemsQuery ON artists.ID=catItemsQuery.artistID
	where (left(sort,1)=<cfqueryparam value="#UCase(url.letter)#" cfsqltype="cf_sql_char"> OR left(sort,1)=<cfqueryparam value="#LCase(url.letter)#" cfsqltype="cf_sql_char">) AND Left([shelfCode],1)='D' AND ONHAND>0 AND albumStatusID<25
    order by sort
</cfquery>
<cfset endCol1=allArtists.recordCount/2>
<cfset pageGroup="artists">

<p>&nbsp;</p>
<table border="1" bordercolor="#669933" cellspacing="0" cellpadding="4" align="center" style="border-collapse:collapse;">
	<tr>
		<cfoutput query="letterList">
			<cfif labelLetter NEQ "">
				<td align="center"><a href="dt161artistList.cfm?letter=#UCase(labelLetter)#">#UCase(labelLetter)#</a></td>
			</cfif>
		</cfoutput>
	</tr>
</table>
<table border="0" cellpadding="10" cellspacing="0" style="border-collapse:collapse;" align="center">
<tr><td valign="top">
    	<cfset countArtists=0>
        <cfset colSplit=false>
<blockquote><cfset lastID=0><cfoutput query="allArtists"><cfif lastID NEQ ID>
        	<cfif countArtists GT endCol1 AND colSplit EQ false>
            	</td><td valign="top"><cfset colSplit=true>
            </cfif>
	<p style="margin-top: 9px; margin-bottom: 9px;"><a href="dt161main.cfm?af=#ID#&group=all">#name#</a></p>
<cfset lastID=ID></cfif>
            <cfset countArtists=countArtists+1></cfoutput></blockquote>
            </td></tr></table>
<p>&nbsp;</p>
</body>
</html>