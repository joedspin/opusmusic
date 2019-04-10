The page is no longer in use. Please contact the web administrator for advice.<cfabort><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304 admin</title>
</head>

<body>
<p>Downtown 304 online admin tool</p>
<p>Catalog</p>
<p>DT Back In Stock to Regular Import</p>
<cfparam name="form.DTBTRtext" default="">
<cfparam name="form.uu" default="">
<cfparam name="form.pp" default="">
<cfif form.uu NEQ "DT161" AND form.pp NEQ "ggHy77Tjx8H">ERROR - Access Denied<cfabort></cfif>
<cfif form.DTBTRtext EQ "">
	ERROR<cfabort>
<cfelse>
<cffile action="write" 
		file="#serverPath#\DTBTR.txt"
		output="#form.DTBTRtext#">
	<cfhttp method="Get"
		url="DTBTR.txt"
		name="DTBTR"
		delimiter="|"
		textqualifier="" 
		columns="Album_Detail_ID">
<cfquery name="getBTRItems" dbType="Query">
	select *
	from DTBTR
</cfquery>
<cfquery name="DTformat" datasource="#DSN#">
	select *
	from DTAlbumFormats
</cfquery>	
<cfquery name="DTBTRLoad" dbtype="query">
	select * from getBTRItems, DTFormat WHERE CAST(Album_Format_ID AS INTEGER)=<cfqueryparam value="#DTformat.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<br />
<cfif getBTRItems.RecordCount GT 0>
	<cfloop query="getBTRItems">
		<cfset thisMediaId=mediaID>
		<cfif thisMediaID EQ ''><cfset thisMediaID=1></cfif>
		<cfquery name="updateItems" datasource="#DSN#">
			update catItemsQuery
			set albumStatusID=24
			where shelfID=11 AND dtID=<cfqueryparam value="#getBTRItems.Album_Detail_ID#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cfloop>
	<p>Done.<br />
	<b><cfoutput>#getBTRItems.RecordCount#</cfoutput> Items Processed.</b></p>
<cfelse>
	<p>No Items found.</p>
</cfif>
</cfif>
</body>
</html>
