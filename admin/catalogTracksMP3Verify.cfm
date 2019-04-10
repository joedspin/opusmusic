<cfsetting requesttimeout="60000">
<cfquery name="tracks" datasource="#DSN#">
	select *
	from catTracks
	where (mp3Loaded=No or mp3Loaded Is Null) AND ID>30000
</cfquery>
<cfset trackStatus="true">
<cfloop query="tracks">
	<cfdirectory directory="d:\media" filter="oT#tracks.ID#.mp3" name="trackCheck" action="list">
	<cfif trackCheck.recordCount NEQ 0>
		<cfquery name="updateTrack" datasource="#DSN#">
			update catTracks
			set mp3Loaded=1
			where ID=#tracks.ID#
		</cfquery>
	</cfif>
</cfloop>
