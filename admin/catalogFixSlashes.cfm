<cfsetting requesttimeout="6000">
<cfquery name="fixSlashes" datasource="#DSN#">
	select *
	from catItems
	where title LIKE '%/%'
</cfquery>
<cfloop query="fixSlashes">
	<cfquery name="updateCat" datasource="#DSN#">
		update catItems
		set title='#Replace(Replace(fixSlashes.title,""," / ","all"),"  "," ","all")#'
		where ID=#fixSlashes.ID#
	</cfquery>
</cfloop>
<cfquery name="fixTrackSlashes" datasource="#DSN#">
	select *
	from catTracks
	where tName LIKE '%/%'
</cfquery>
<cfloop query="fixTrackSlashes">
	<cfquery name="updateTracks" datasource="#DSN#">
		update catTracks
		set tName='#Replace(Replace(fixTrackSlashes.tName,""," / ","all"),"  "," ","all")#'
		where ID=#fixTrackSlashes.ID#
	</cfquery>
</cfloop>
<cfquery name="fixArtistSlashes" datasource="#DSN#">
	select *
	from artists
	where name LIKE '%/%'
</cfquery>
<cfloop query="fixArtistSlashes">
	<cfquery name="updateArtists" datasource="#DSN#">
		update artists
		set name='#Replace(Replace(fixArtistSlashes.name,""," / ","all"),"  "," ","all")#'
		where ID=#fixArtistSlashes.ID#
	</cfquery>
</cfloop>