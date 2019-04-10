<!---<cfcache timespan="#createTimeSpan(0,12,0,0)#">//--->
Temporarily Unavailable<cfabort>
<cfparam name="url.chartID" default="0">
<cfparam name="url.chartName" default="">
<cfparam name="url.listID" default="0">
<cfparam name="url.artistID" default="0">
<cfparam name="url.labelID" default="0">
<cfparam name="url.artistID2" default="0">
<cfparam name="url.labelID2" default="0">
<cfparam name="url.artistID3" default="0">
<cfparam name="url.labelID3" default="0">
<cfset listName="">
<cfset catFind=false>
<cfif url.chartID NEQ 0>
	<cfquery name="thisChart" datasource="#DSN#">
		select *
		from artistListsQuery
		where ID=<cfqueryparam value="#url.chartID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfset thisChartID=thisChart.ID>
	<cfquery name="thisChartItems" datasource="#DSN#" cachedwithin="#createTimeSpan(0,12,0,0)#">
		select *
		from artistListsItemsQuery
		where listID=#thisChartID#
		order by sort
	</cfquery>
	<cfoutput query="thisChart">
	<playlist version="1" xmlns="http://xspf.org/ns/0/">
		<title>#artist# : #listName#</title>
		<info>http://www.downtown304.com/</info>
		<annotation>#artist# : #listName#</annotation>
		<trackList>
	<cfloop query="thisChartItems">
	<cfif trackID NEQ 0>
			<cfset thisID=trackItemID>
			<cfset thisArtist=trackArtist>
			<cfset thisTitle=tName>
			<cfset thisLabel=trackLabel>
			<cfset thisTrackID=trackID>
			<cfset thisArtistID=trackArtistID>
		 <cfelse>
			<cfset thisID=itemID>
			<cfset thisArtist=itemArtist>
			<cfset thisTitle=itemTitle>
			<cfset thisLabel=itemLabel>
			<cfset thisArtistID=artistID>
			<!---<cfquery name="firstTrack" datasource="#DSN#" maxrows="1">
				select *
				from catTracks
				where catID=#itemID#
				order by tSort
			</cfquery>//--->
            <cfquery name="firstTrack" dbtype="query" maxrows="1">
                select *
                from Application.allTracks
                where catID=#itemID#
                order by tSort
            </cfquery>
			<cfset thisTrackID=firstTrack.ID>
		</cfif>
		<cfif mp3Alt NEQ 0 AND mp3Alt NEQ ""><cfset trID=mp3Alt><cfelse><cfset trID=thisTrackID></cfif>
		<cfset imagefile="labels/label_WhiteLabel.gif">
		<cfif jpgLoaded EQ 1>
			<cfset imagefile="items/oI#itemID#.jpg">
		<cfelseif logofile NEQ "">
			<cfset imagefile="labels/" & logofile>
		</cfif>
		<cfif mp3Loaded EQ 1 OR mp3Alt NEQ 0>
			<track>
				<title>#thisTitle#</title>
				<creator>#thisArtist# [#thisLabel#]</creator>
				<location>http://www.downtown304.com/media/oT#trID#.mp3</location>
				<info>http://www.downtown304.com/index.cfm?sID=#thisID#</info>
				<identifier>#thisLabel#</identifier>
				<image>http://www.downtown304.com/images/#imagefile#</image>
			</track>
	</cfif>
	</cfloop>
	
		</trackList>
	</playlist>
	</cfoutput>
<cfelseif url.listID NEQ 0>

<cfelseif url.chartName NEQ "">
	<cfinclude template="dt304playlist_#url.chartName#.cfm">
	<cfset catFind=true>
<cfelseif (url.labelID NEQ 0 AND isNumeric(url.labelID)) OR (url.artistID NEQ 0 AND IsNumeric(url.artistID))>

<cfset labelString="">
<cfset artistString="">
<cfif url.labelID NEQ 0 AND isNumeric(url.labelID)>
	<cfset labelString="labelID=#url.labelID#">
	<cfif url.labelID2 NEQ 0 AND isNumeric(url.labelID2)>
		<cfset labelString=labelString&" OR labelID=#url.labelID2#">
		<cfif url.labelID3 NEQ 0 AND IsNumeric(url.labelID3)>
			<cfset labelString=labelString&" OR labelID=#url.labelID3#">
		</cfif>
		<cfset labelString="("&labelString&")">
	</cfif>
</cfif>
<cfif url.artistID NEQ 0 AND isNumeric(url.artistID)>
	<cfset artistString="artistID=#url.artistID#">
	<cfif url.artistID2 NEQ 0 AND isNumeric(url.artistID2)>
		<cfset artistString=artistString&" OR artistID=#url.artistID2#">
		<cfif url.artistID3 NEQ 0 AND isNumeric(url.artistID3)>
			<cfset artistString=artistString&" OR artistID=#url.artistID3#">
		</cfif>
		<cfset artistString="("&artistString&")">
	</cfif>
</cfif>
<cfif artistString NEQ "" AND labelString NEQ "">
	<cfset sString="("&artistString&") OR ("&labelString&")">
<cfelse>
	<cfset sString=artistString&labelString>
</cfif>
<!---<cfif Find(sString," OR ") EQ 0>
	<cfset sString=Replace(Replace(sString,"(","","all"),")","","all")>
</cfif>//--->
<!---<cfoutput>#sString#</cfoutput><cfabort>//--->
	<cfquery name="listItems" datasource="#DSN#">
		select *
		from catTracksQuery
		where #sString#
		AND ((left(shelfCode,'1')='D' OR shelfCode='OD' OR isVendor=1) AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999) AND mp3Loaded=1
		order by itemID DESC, tSort
	</cfquery>
	<cfset catFind=true>
</cfif>
<cfif catFind>
<playlist version="1" xmlns="http://xspf.org/ns/0/">
<cfoutput>
	<title>#listName#</title>
	<info>http://www.downtown304.com/</info>
	<annotation>#listName#</annotation>
	
</cfoutput>
<trackList>
<cfoutput query="listItems">
	<cfset imagefile="labels/label_WhiteLabel.gif">
	<cfif jpgLoaded>
		<cfset imagefile="items/oI#itemID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/" & logofile>
	</cfif>
		<track>
			<title>#title# - #tName#</title>
			<creator>#artist# [#label#]</creator>
			<location>http://www.downtown304.com/media/oT#ID#.mp3</location>
			<info>http://www.downtown304.com/index.cfm?sID=#itemID#</info>
			<identifier>#label#</identifier>
			<image>http://www.downtown304.com/images/#imagefile#</image>
		</track>
</cfoutput>
	</trackList>
</playlist>
</cfif>