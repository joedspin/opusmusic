<cfparam name="url.ID" default="0">
<cfparam name="url.mergeID" default="0">
<cfquery name="sourceItem" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID=#url.mergeID#
</cfquery>
<cfloop query="sourceItem"><!--- cost=<cfqueryparam value="#cost+1#" cfsqltype="cf_sql_money">, //--->
<cfset thisJPG=jpgLoaded>
<cfif jpgLoaded EQ 1>
	<cffile action="copy" source="#serverpath#\images\items\oI#url.mergeID#.jpg" nameconflict="overwrite" destination="oI#url.ID#.jpg"><cfset thisJPG=1>
</cfif>
<cfquery name="matchItem" datasource="#DSN#">
		update catItems 
			set title=<cfqueryparam value="#title#" cfsqltype="cf_sql_char">,
			artistID=<cfqueryparam value="#artistID#" cfsqltype="cf_sql_char">,
			labelID=<cfqueryparam value="#labelID#" cfsqltype="cf_sql_char">,
			countryID=<cfqueryparam value="#countryID#" cfsqltype="cf_sql_char">,
			mediaID=<cfqueryparam value="#mediaID#" cfsqltype="cf_sql_char">,
			genreID=<cfqueryparam value="#genreID#" cfsqltype="cf_sql_char">,
			DTdateUpdated=<cfqueryparam value="#releaseDate#" cfsqltype="cf_sql_date">,
			releaseDate=<cfqueryparam value="#releaseDate#" cfsqltype="cf_sql_date">,
			shelfID=11,
			NRECSINSET=<cfqueryparam value="#NRECSINSET#" cfsqltype="cf_sql_char">,
			ONSIDE=999,
			jpgLoaded=#thisJPG#
         where ID=#url.ID#
	</cfquery>
	<cfquery name="itemTracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#url.mergeID#
	</cfquery>
    <cfquery name="killOldTracks" datasource="#DSN#">
        delete from catTracks where catID=#url.ID#
    </cfquery>
	<cfloop query="itemTracks">
	<cfif itemTracks.mp3Alt GT 0><cfset thisAlt=mp3Alt><cfelse><cfset thisAlt=itemTracks.ID></cfif>
		<cfdirectory directory="#serverpath#/media" filter="oT#thisAlt#.mp3" name="trackCheck" action="list">
		<cfif trackCheck.recordCount EQ 0><cfset thisAlt=0></cfif>
        
		<cfquery name="addTrack" datasource="#DSN#">
			insert into catTracks (catID, tName, tSort, mp3Alt)
			values (
				<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#itemTracks.tName#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#itemTracks.tSort#" cfsqltype="cf_sql_char">,
				#thisAlt#
			)
		</cfquery>
	</cfloop>
</cfloop>
<cflocation url="catalog.cfm">