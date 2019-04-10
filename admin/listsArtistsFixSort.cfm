<cfsetting requesttimeout="6000">
<cfquery name="allArtists" datasource="#DSN#">
	select *
	from artists
	where sort<>'' AND sort Is Not Null
</cfquery>
<cfloop query="allArtists">
	<cfquery name="updateArtist" datasource="#DSN#">
		update artists
		set sort='#Replace(Ucase(allArtists.sort)," ","","all")#'
		where ID=#allArtists.ID#
	</cfquery>
</cfloop>
<cfquery name="allArtists" datasource="#DSN#">
	select *
	from artists
	where sort='' or sort Is Null
</cfquery>
<cfloop query="allArtists">
	<cfquery name="updateArtist" datasource="#DSN#">
		update artists
		set sort='#Replace(Ucase(allArtists.name)," ","","all")#'
		where ID=#allArtists.ID#
	</cfquery>
</cfloop>