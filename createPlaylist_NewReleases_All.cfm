<cfset m3uOutput="##EXTM3U
">
<cfset siteChoice="304">
<cfset trackChoice="Application.allTracks">
<cfquery name="catFind" dbtype="query">
    select *
    from Application.dt#siteChoice#Items
    where ((ONHAND>0  AND (albumStatusID<=22 OR albumStatusID=148)) OR ONSIDE>0 OR albumStatusID=30)
        AND releaseDate>'#DateFormat(DateAdd('d',-30,varDateODBC),"yyyy-mm-dd")#'
    order by releaseDate DESC, ONHAND DESC
</cfquery>
<cfoutput query="catFind">
	<cfset activeItemID=catItemID>
    <cfquery name="tracks" dbtype="query">
        select *
        from Application.allTracks
        where catID=#activeItemID#
        order by tSort
    </cfquery>
    <cfloop query="tracks">
			<cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
			<cfif tracks.mp3Loaded OR mp3Alt NEQ 0>
<cfset m3uOutput=m3uOutput&"##EXTINF:180,#artist# - #title# : #tName#
http://www.downtown304.com/media/oT#trID#.mp3
">
</cfif>
	  </cfloop>
</cfoutput>
<cfoutput>#m3uOutput#</cfoutput>
