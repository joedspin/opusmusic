<cfparam name="form.ID" default="0">
<cfparam name="form.name" default="">
<cfparam name="form.sort" default="">
<cfparam name="form.website" default="">
<cfparam name="form.active" default="no">
<cfparam name="form.letter" default="a">
<cfparam name="form.editItem" default="0">
<cfparam name="form.find" default="">
<cfquery name="updateLabel" datasource="#DSN#">
	update artists
	set
		name=<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
		sort=<cfqueryparam value="#Replace(Ucase(form.sort)," ","","all")#" cfsqltype="cf_sql_char">,
		website=<cfqueryparam value="#form.website#" cfsqltype="cf_sql_char">,
		active=<cfqueryparam value="#YesNoFormat(form.active)#" cfsqltype="cf_sql_bit">
	where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cfquery name="Application.adminAllArtists" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,0,0,1)#">
	select *
    from artists
    order by sort, name
</cfquery>
<cfif form.editItem NEQ 0>
	<cflocation url="catalogEdit.cfm?ID=#form.editItem#">
<cfelse>
	<cflocation url="listsArtists.cfm?letter=#form.letter#&find=#form.find#">
</cfif>