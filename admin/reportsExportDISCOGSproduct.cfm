<cfsetting requesttimeout="900">
<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
<cfset joedspin="">
<cfquery name="inventoryReport" datasource="#DSN#">
	select *
	from catItemsQuery
	where ((isVendor=1 OR shelfCode='BS') OR left(shelfCode,1)='D') AND ((ONHAND>0  AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999 AND (discogsFormat IN ('Vinyl','CD'))
    order by label, catnum
</cfquery>
<cfquery name="allTracksDISCOGS" datasource="#DSN#">
	select * 
	from catTracks
</cfquery>
<cfset joedspin="sku,artist,title,label,genre,format,price,media_condition,catno,sleeve_condition,comments,description,accept_offer,tracks,track_count,image_url_thumbnail,audioclip_url#lineFeed#">
<!---<table border="1" cellpadding="1" cellspacing="0" style="border-collapse:collapse">//--->
<cfloop query="inventoryReport">
<!---<cfif DateFormat(DTDateUpdated,"yyyy-mm-dd") LT "2008-08-01" AND Left(shelfCode,1) NEQ 'D' AND shelfCode NEQ 'BS' AND albumStatusID NEQ 23><cfset thisPrice=NumberFormat(PRICE/2,'0.00')><cfelseif shelfCode EQ 'BS'><cfset thisPrice=NumberFormat(PRICE*0.60,'0.00')><cfelse><cfset thisPrice=NumberFormat(PRICE,'0.00')></cfif><cfif shelfCode EQ "BS"><cfset thisPrice=price*.8><cfelse><cfset thisPrice=PRICE></cfif>//--->
<!---<cfif DateFormat(varDateODBC,"mm/dd/yy") LTE "10/12/10">//--->
<!---<cfif shelfCode EQ "DT"><cfset thisPrice=price+1><cfelse>//---><!---</cfif>//---><!---<cfelse><cfset thisPrice=PRICE+1></cfif>//--->
<cfquery name="tracks" dbtype="query">
	select *
	from allTracksDISCOGS
	where catID=#ID# order by tSort
</cfquery>
<cfset thisMP3="">
<cfif tracks.RecordCount GT 0>
	<cfset trackList="">
	<cfset startedTracks=false>
    <cfset tnum=0>
    <cfset thisMP3="">
	<cfloop query="tracks">
		<cfset tnum=tnum+1>
		<cfif startedTracks>
			<cfset trackList=trackList&"||"&tNum&". "&tName>
		<cfelse>
			<cfset trackList=tNum&". "&tName>
		</cfif>
        <cfif thisMP3 EQ "">
        	<cfif mp3Loaded>
            	<cfset thisMP3="http://www.downtown304.com/media/oT#tracks.ID#.mp3">
            </cfif>
        </cfif>
		<cfset startedTracks=true>
	</cfloop>
    <cfset trackCount=tracks.RecordCount>
<cfelse>
	<cfset trackList="">
    <cfset trackCount="">
</cfif>
<cfset trackList=Replace(trackList,chr(9)," ","all")>
<cfif reissue OR genreID EQ 7><cfset thisComm="Reissue Edition - This item is NEW"><cfelse><cfset thisComm="This item is NEW"></cfif>
<cfif NRECSINSET GT 1><cfset thisMedia=NRECSINSET&'x'&media><cfelse><cfset thisMedia=media></cfif>
<cfif jpgLoaded><cfset thisThumb="http://www.downtown304.com/images/items/oI#ID#.jpg"><cfelse><cfset thisThumb=""></cfif>
<cfset joedspin=joedspin&"#DateFormat(varDateODBC,'yyyymmdd')#-#ID#,#Replace(artist,',',' ','all')#,#Replace(Replace(Replace(title,',',' ','all'),' [Warehouse Find]','','all'),' [Re-press]','','all')#,#Replace(label,',',' ','all')#,#discogsName#,#discogsFormat#,#NumberFormat(price,'000.00')#,Near Mint (NM or M-),#Replace(catnum,',',' ','all')#,Near Mint (NM or M-),#thisComm#,#thisMedia# - #genre#,N,#Replace(trackList,',',' ','all')#,#trackCount#,#thisThumb#,#thisMP3##lineFeed#">
<!---<cfoutput><tr><td>#discogsID#</td><td>#label#</td><td>#catnum#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td><td>#DollarFormat(thisPrice)#</td></tr></cfoutput>//--->
<cfset thisMP3=""></cfloop>
<!---</table>//--->
<cffile action="write"
	file="#serverPath#\joedspinDiscogsP.csv"
	output="#joedspin#">
	
	
<cfmail to="order@downtown304.com" cc="judy@downtown161.com" from="order@downtown304.com" subject="Discogs Product Export File Attached" mimeattach="#serverPath#\joedspinDiscogsP.csv"></cfmail>

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
	transfermode="ascii" passive="no">//--->


<p>Discogs PRODUCT Export file SENT<br />
<cfoutput>#inventoryReport.RecordCount# Items included</cfoutput></p>
<cfinclude template="pageFoot.cfm">