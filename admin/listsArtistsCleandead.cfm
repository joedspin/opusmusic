<cfsetting requesttimeout="900">
<cfquery name="allArtists" datasource="#DSN#">
	select *
	from artists
	order by name
</cfquery>
<cfloop query="allArtists">
	<cfquery name="checkArtist" datasource="#DSN#">
		select *
		from catItems
		where artistID=#allArtists.ID#
	</cfquery>
	<cfoutput>#name# </cfoutput>
	<cfif checkArtist.recordCount EQ 0>
		<cfquery name="clearDead" datasource="#DSN#">
			delete *
			from artists
			where ID=#allArtists.ID#
		</cfquery>
		<font color="red">DELETED</font><br>
	</cfif>
</cfloop>