<cfparam name="form.name" default="">
<cfparam name="form.sort" default="">
<cfparam name="form.letter" default="a">
<cfparam name="form.active" default="no">
<cfparam name="form.groomed" default="no">
<cfparam name="form.special" default="no">
<cfparam name="form.highlight" default="no">
<cfquery name="addLabel" datasource="#DSN#">
	insert into labels (name, sort, logofile, active)
	values (<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.sort#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.logofile#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.active#" cfsqltype="cf_sql_bit">)
</cfquery>
<cfquery name="Application.adminAllLabels" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,0,0,1)#">
	select *
    from labels
    order by sort, name
</cfquery>
<cflocation url="listsLabels.cfm?letter=#form.letter#">

<!---
groomed, special, highlight,
		<cfqueryparam value="#form.groomed#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.special#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.highlight#" cfsqltype="cf_sql_bit">//--->