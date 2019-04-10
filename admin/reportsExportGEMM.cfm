<cfsetting requesttimeout="1800">
<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm"><cfset joedspin="">
<cfquery name="inventoryReport" datasource="#DSN#">
	select *
	from catItemsQuery
	where ((isVendor=1 OR left(shelfCode,1)='D' OR shelfCode='BS') AND (ONHAND>0 AND albumStatusID<25))
    order by label, catnum
</cfquery><!--- removed the following to eliminate Scorpio entries...: OR shelfCode='SC' //--->
<cfquery name="allTracksGEMM" datasource="#DSN#">
	select * 
	from catTracks
</cfquery>
<table border="1" cellpadding="1" cellspacing="0" style="border-collapse:collapse">
<cfloop query="inventoryReport">
<cfquery name="tracks" dbtype="query">
	select *
	from allTracksGEMM
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
	<cfset thisDescrip=Replace(thisDescrip,chr(9)," ","all")>
<cfelse>
	<cfset thisDescrip="">
</cfif>
<!---<cfset thisDescrip=ReplaceNoCase(thisDescrip," [Warehouse Find]","","all")>
<cfset thisDescrip=ReplaceNoCase(thisDescrip," [Repress]","","all")>
<cfset thisDescrip=ReplaceNoCase(thisDescrip,"Reissue","","all")>
<cfset thisDescrip=Replace(thisDescrip," )",")","all")>
<cfset thisDescrip=Replace(thisDescrip,"( ","(","all")>
<cfset thisDescrip=Replace(thisDescrip,"()","","all")>//--->
<!---<cfif ONSIDE GT 0><cfset thisONHAND=ONSIDE><cfelse><cfset thisONHAND=ONHAND></cfif>//--->
<!---<cfif shelfCode EQ "SC"><cfset thisONHAND=5></cfif>//--->
<cfset thisONHAND=ONHAND+ONSIDE>
<cfif thisONHAND GT 10><cfset thisONHAND=10+Right(thisONHAND,"1")></cfif>
<!--- <cfif DateFormat(DTDateUpdated,"yyyy-mm-dd") LT "2011-12-01" AND Left(shelfCode,1) NEQ 'D'><cfset thisPrice=NumberFormat(PRICE*.7,'0.00')><cfelseif shelfCode EQ 'BS'><cfset thisPrice=NumberFormat(PRICE*0.50,'0.00')><cfelse><cfset thisPrice=cost+2.00></cfif>temporarily set price = cost+2.00 ... change back to thisPrice=PRICE//--->
<cfset thisPrice=PRICE>
<cfset thisThumb="">
<cfset thisfullImg="">
<cfif jpgLoaded><cfset thisThumb="http://www.downtown304.com/images/items/oI#ID#.jpg"></cfif>
<cfif fullImg NEQ ""><cfset thisFullImg="http://www.downtown304.com/images/items/oI#ID#full.jpg"></cfif>
<cfset joedspin=joedspin&"#ID##shelfCode##chr(9)##chr(9)##artist##chr(9)##title##chr(9)#M-#chr(9)#M-#chr(9)##DollarFormat(thisPrice)##chr(9)##label##chr(9)##catnum##chr(9)##countryAbbrev##chr(9)##DateFormat(releaseDate,"yyyy")##chr(9)##NRECSINSET##chr(9)##thisONHAND##chr(9)##thisDescrip##chr(9)##media##chr(9)##genre##chr(9)##thisThumb##chr(9)##thisFullImg##lineFeed#">
<!---<cfoutput><tr><td>#label#</td><td>#catnum#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td><td>#DollarFormat(thisPrice)#</td></tr></cfoutput>//--->
</cfloop>
</table>

<cffile action="write"
	file="#serverPath#\joedspin.replace.txt"
	output="#joedspin#">
	
	
<cfmail to="order@downtown304.com" from="order@downtown304.com" subject="GEMM Export File Attached" mimeattach="#serverPath#\joedspin.replace.txt"></cfmail>
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