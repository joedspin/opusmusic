<cfparam name="form.name" default="">
<cfparam name="form.sort" default="">
<cfparam name="form.letter" default="a">
<cfparam name="form.website" default="">
<cfparam name="form.active" default="no">
<cfquery name="addArtist" datasource="#DSN#">
	insert into artists (name, sort, website, active)
	values (<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.sort#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.website#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#YesNoFormat(form.active)#" cfsqltype="cf_sql_bit">)
</cfquery>
<cfquery name="Application.adminAllArtists" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,0,0,1)#">
	select *
    from artists
    order by sort, name
</cfquery>
<cflocation url="listsArtists.cfm?letter=#form.letter#">