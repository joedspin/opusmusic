<cfparam name="url.oClip" default="0">
<cfif url.oClip EQ "" OR NOT IsValid("integer",url.oClip)><cfset thisClip=0><cfelse><cfset thisClip=url.oClip></cfif>
<cfquery name="thisTrack" dbtype="query">
	SELECT ID, catID, artist, title, tName, ONHAND, albumStatusID, ONSIDE
	from Application.allTracks
	where ID=#thisClip#
</cfquery>
<cfif thisTrack.recordCount GT 0>
	<cfoutput query="thisTrack">
    	<cflocation url="media/oT#thisTrack.ID#.mp3">
	</cfoutput>
</cfif>