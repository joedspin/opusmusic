<playlist version="1" xmlns="http://xspf.org/ns/0/">
<cfparam name="url.chartID" default="0">
<cfquery name="thisChart" datasource="#DSN#">
	select *
	from artistListsQuery
	where ID=<cfqueryparam value="#url.chartID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfset thisChartID=thisChart.ID>
<cfquery name="thisChartItems" datasource="#DSN#">
	select *
	from artistListsItemsQuery
	where listID=<cfqueryparam value="#thisChartID#" cfsqltype="cf_sql_integer">
	order by sort
</cfquery>

<cfoutput query="thisChart">

	<title>#artist# : </title>
	<info>http://www.downtown304.com/</info>
	<annotation>#listName#</annotation>
	<trackList>
    <track>
			<title>TEST</title>
			<creator>TEST</creator>
			<location>http://www.downtown304.com/media/oT00000.mp3</location>
			<info>http://www.downtown304.com/index.cfm?sID=00000</info>
			<identifier>TEST</identifier>
			<image>http://www.downtown304.com/images/spacer.gif</image>
		</track>
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
		<cfquery name="firstTrack" dbtype="query" maxrows="1">
			select *
			from Application.allTracks
			where catID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
			order by tSort
		</cfquery>
		<cfset thisTrackID=firstTrack.ID>
	</cfif>
	<cfif mp3Alt NEQ 0 AND mp3Alt NEQ ""><cfset trID=mp3Alt><cfelse><cfset trID=thisTrackID></cfif>
	<cfset imagefile="labels/label_WhiteLabel.gif">
	<cfif jpgLoaded>
		<cfset imagefile="items/oI#itemID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/" & logofile>
	</cfif>
	<cfif mp3Loaded OR mp3Alt NEQ 0>
		<track>
			<title>#thisTitle#</title>
			<creator>#thisArtist#</creator>
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