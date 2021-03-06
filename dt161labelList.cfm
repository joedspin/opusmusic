<!---<cfcache timespan="#createTimeSpan(0,12,0,0)#">//--->
<cfparam name="url.letter" default="A">
<!---select *
	from labels LEFT JOIN catItemsQuery ON labels.ID=catItemsQuery.labelID
	where (labelLetter=<cfqueryparam value="#UCase(url.letter)#" cfsqltype="cf_sql_char"> OR labelLetter=<cfqueryparam value="#LCase(url.letter)#" cfsqltype="cf_sql_char">) AND Left([shelfCode],1)='D' AND ONHAND>0 AND albumStatusID<25  //--->
<cfquery name="allLabels" datasource="#DSN#">
	select DISTINCT labels.ID AS ID, name, labels.logoFile, sort
	from labels LEFT JOIN catItemsQuery ON labels.ID=catItemsQuery.labelID
	where (left(sort,1)=<cfqueryparam value="#UCase(url.letter)#" cfsqltype="cf_sql_char"> OR left(sort,1)=<cfqueryparam value="#LCase(url.letter)#" cfsqltype="cf_sql_char">) AND Left([shelfCode],1)='D' AND ONHAND>0 AND albumStatusID<25
    order by sort
</cfquery>
<cfquery name="letterList" datasource="#DSN#" cachedWithin="#CreateTimeSpan(1, 0, 0, 0)#">
	select DISTINCT Left(sort,1) As labelLetter
	FROM labels INNER JOIN catItemsQuery ON labels.ID = catItemsQuery.labelID
	WHERE Left([shelfCode],1)='D' AND ONHAND>0 AND albumStatusID<25 
	order by Left(sort,1)
</cfquery>
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
</style>
</head>
<body>
<cfset pageGroup="labels">
<p>&nbsp;</p>
<table border="1" bordercolor="#669933" cellspacing="0" cellpadding="4" align="center" style="border-collapse:collapse;">
	<tr>
		<cfoutput query="letterList">
			<cfif labelLetter NEQ "">
				<td align="center"><a href="dt161labelList.cfm?letter=#UCase(labelLetter)#">#UCase(labelLetter)#</a></td>
			</cfif>
		</cfoutput>
	</tr>
</table>
<p>&nbsp;</p>
<cfset lastID=0>
<table width="500" border="1" align="center" cellpadding="5" bordercolor="#000000" style="border-collapse:collapse;">
<cfoutput query="allLabels">
	<cfif lastID NEQ ID>
		<cfset imagefile="labels/label_WhiteLabel.gif">
				<cfset imagefolder="">
				<cfif logofile NEQ "">
					<cfif logofile NEQ "">
						<cfset imagefile="labels/" & logofile>
					</cfif>
				</cfif>
			<tr>
				<td width="60"><a href="dt161main.cfm?lf=#ID#&group=all"><img src="images/#imagefile#" width="50" height="50" border="0" /></a></td>
				<td><a href="dt161main.cfm?lf=#ID#&group=all">#name#</a></td>
			</tr>
	<cfset lastID=ID>
		</cfif>
</cfoutput></table>
<p>&nbsp;</p>
</body>
</html>