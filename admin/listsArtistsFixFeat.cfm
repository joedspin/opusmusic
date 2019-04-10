<cfsetting requesttimeout="6000">
<cfquery name="allArtists" datasource="#DSN#">
	select *
	from artists
	where name LIKE '%ftr.%'
</cfquery>
<cfloop query="allArtists">
	<cfquery name="updateArtist" datasource="#DSN#">
		update artists
		set sort='#Replace(allArtists.sort," ","","all")#'
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