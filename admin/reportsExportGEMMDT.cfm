<cfsetting requesttimeout="900">
<cfquery name="archiveItems" datasource="#DSN#">
	update catItems
	set active=0
	where ONHAND=0
</cfquery>
<cfset joedspin="">
<cfquery name="inventoryReport" datasource="#DSN#">
	select *
	from catItemsQuery
	where (shelfID=7 OR shelfID=9 OR shelfID=11) AND albumStatusID < 25 AND ONHAND>0
</cfquery>
<cfloop query="inventoryReport">
<cfquery name="tracks" datasource="#DSN#">
	select *
	from catTracks
	where catID=#ID# order by tSort
</cfquery>
<cfif tracks.RecordCount GT 0>
	<cfset thisDescrip="">
	<cfset startedTracks=false>
	<cfloop query="tracks">
		<cfif startedTracks>
			<cfset thisDescrip=thisDescrip&"; "&tName>
		<cfelse>
			<cfset thisDescrip=tName>
		</cfif>
		<cfset startedTracks=true>
	</cfloop>
<cfelse>
	<cfset thisDescrip=descrip>
</cfif>
<cfset thisONHAND=ONHAND>
<cfif thisONHAND GT 30><cfset thisONHAND=30+Right(thisONHAND,"1")></cfif>
<cfif Left(shelfCode,1) EQ 'D' OR shelfCode EQ 'OD'>
	<cfset thisPrice=PRICE*.96>
<cfelse>
	<cfset thisPrice=PRICE>
</cfif>
<cfset joedspin=joedspin&"#ID##shelfCode##chr(9)##chr(9)##artist##chr(9)##title##chr(9)##CONDITION_MEDIA##chr(9)##CONDITION_COVER##chr(9)##DollarFormat(thisPrice)##chr(9)##label##chr(9)##catnum##chr(9)##countryAbbrev##chr(9)##DateFormat(releaseDate,"yyyy")##chr(9)##NRECSINSET##chr(9)##thisONHAND##chr(9)##thisDescrip##chr(9)##media##chr(9)##genre##lineFeed#">
</cfloop>
<cffile action="write"
	file="#serverPath#\DOWNTOWN161_replace.txt"
	output="#joedspin#">
	
	
<cfmail to="joe@downtown161.com" from="order@downtown304.com" subject="DT GEMM Export File Attached" mimeattach="#serverPath#\DOWNTOWN161_replace.txt"></cfmail>

<!---<cfftp 
	server="gemm.com"
	directory="place_catalogs_here"
	username="anonymous"
	password="marianne@downtown304.com"
	action="putfile"
	remotefile="joedspin_replace.txt"
	failifexists="no"
	stoponerror="no"
	localfile="#serverPath#\joedspin_replace.txt" 
	transfermode="ascii">//--->

<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
<p>Export file SENT<br />
<cfoutput>#inventoryReport.RecordCount# Items included</cfoutput></p>
<cfinclude template="pageFoot.cfm">