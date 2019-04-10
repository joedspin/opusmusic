<cfquery name="addArtists" datasource="#DSN#">
	select *
	from joedspin
	where PARTNER='DI' OR PARTNER='DS' OR PARTNER='DO'
</cfquery>
<cfloop query="addArtists">
	<cfif ARTIST_FIRST NEQ "">
		<cfset newArtist=ARTIST_LAST & ', ' & ARTIST_FIRST>
	<cfelse>
		<cfset newArtist=ARTIST_LAST>
	</cfif>
	<cfquery name="checkArtist" datasource="#DSN#">
		select *
		from artists
		where name='#newArtist#'
	</cfquery>
	<cfif checkArtist.recordCount EQ 0>
		<cfquery name="insertArtist" datasource="#DSN#">
			insert into
			artists (name, sort)
			values (
				<cfqueryparam value="#newArtist#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#Replace(UCase(newArtist)," ","","all")#" cfsqltype="cf_sql_char">
			)
		</cfquery>
	</cfif>
</cfloop>