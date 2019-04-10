<cfsetting requesttimeout="900">
<cfset imagefile="">
<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm"><cfset joedspin="">
<cfquery name="inventoryReport" datasource="#DSN#">
	select *
	from catItemsQuery
	where (isVendor=1 OR left(shelfCode,1)='D' OR shelfCode='BS') AND ((ONHAND>0  AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999 AND (discogsFormat IN ('Vinyl','CD'))
    order by label, catnum
</cfquery>
<cfquery name="allTracks" datasource="#DSN#">
	select * 
	from catTracks
</cfquery>
<table border="1" cellpadding="1" cellspacing="0" style="border-collapse:collapse">
<cfset thisDescrip="">
<cfloop query="inventoryReport">
<cfquery name="tracks" dbtype="query">
	select *
	from allTracks
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
	<cfset thisDescrip=Replace(descrip,"#linefeed#"," ","all")>
</cfif>
<cfset thisDescrip=Replace(thisDescrip,chr(9)," ","all")>
<!---<cfif ONSIDE GT 0><cfset thisONHAND=ONSIDE><cfelse><cfset thisONHAND=5+Right(ONHAND,"1")></cfif>//--->
<cfset thisPrice=PRICE><!---<cfif DateFormat(DTDateUpdated,"yyyy-mm-dd") LT "2011-12-01" AND Left(shelfCode,1) NEQ 'D'><cfset thisPrice=NumberFormat(PRICE*.7,'0.00')><cfelseif shelfCode EQ 'BS'><cfset thisPrice=NumberFormat(PRICE,'0.00')><cfelse><cfset thisPrice=cost+2.00></cfif>//--->
<cfif FindNoCase("Picture Disc",title)><cfset picInsert=" Pic Disc"><cfelse><cfset picInsert=""></cfif>
<!--- October 2010 added *.85 to price to do sale for Columbus Day //--->
<cfset joedspin=joedspin&"#ID##shelfCode##chr(9)##artist##chr(9)##title##chr(9)#Near Mint [NM or M-] / Near Mint [NM or M-]#chr(9)##DollarFormat(thisPrice)##chr(9)##label##chr(9)##catnum##chr(9)##countryAbbrev##chr(9)##DateFormat(releaseDate,"yyyy")##chr(9)#"><cfif NRECSINSET NEQ 1><cfset joedspin=joedspin&"#NRECSINSET#X "></cfif>
<cfset joedspin=joedspin&"#media##picInsert##chr(9)##ONHAND##chr(9)##thisDescrip##chr(9)##genre#">
<!---<cfif jpgLoaded EQ 1>
		<cfset imagefile="items/oI#ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="">
	</cfif>//--->
<cfif imagefile NEQ ""><cfset joedspin=joedspin&"#chr(9)#http://www.downtown304.com/images/#imageFile##lineFeed#"><cfelse><cfset joedspin=joedspin&"#chr(9)##lineFeed#"></cfif>
<!---<cfoutput><tr><td>#label#</td><td>#catnum#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td><td>#DollarFormat(thisPrice)#</td></tr></cfoutput>//--->
</cfloop>
</table>
<cffile action="write"
	file="#serverPath#\joedspin.musicstack.txt"
	output="#joedspin#">
	
	
<cfmail to="order@downtown304.com" from="order@downtown304.com" subject="MusicStack Export File Attached" mimeattach="#serverPath#\joedspin.musicstack.txt"></cfmail>
<!---
<cfftp 
	server="gemm.com"
	directory="place_catalogs_here"
	username="anonymous"
	password="marianne@downtown304.com"
	action="putfile"
	remotefile="joedspin_replace.txt"
	failifexists="no"
	stoponerror="no"
	localfile="#serverPath#\joedspin_replace.txt" 
	transfermode="ascii" passive="no">//--->


<p>Export file SENT<br />
<cfoutput>#inventoryReport.RecordCount# Items included</cfoutput></p>
<cfinclude template="pageFoot.cfm">