<cfparam name="form.ID" default="0">
<cfparam name="form.name" default="">
<cfparam name="form.sort" default="">
<cfparam name="form.active" default="no">
<cfparam name="form.groomed" default="no">
<cfparam name="form.special" default="no">
<cfparam name="form.highlight" default="no">
<cfparam name="form.letter" default="a">
<cfparam name="form.uploadFile" default="">
<cfparam name="form.cancel" default="">
<cfparam name="form.logofile" default="">
<cfparam name="form.delete" default="">
<cfparam name="form.editItem" default="0">
<cfparam name="form.find" default="">
<cfparam name="url.delete" default="">
<cfset loadlogofile=form.logofile>
<cfif url.delete NEQ "">
	<cfdirectory name="checkArt" directory="#serverPath#\images\labels" filter="#url.delete#" action="list">
	<cfif checkArt.recordCount GT 0>
		<cffile action="delete" file="#serverPath#\images\labels\#url.delete#">
	</cfif>
	<cfset loadlogofile="">
<cfelseif form.uploadFile NEQ "">
	<cffile action="upload"
		destination="#serverPath#\images\labels"
		nameConflict="overwrite"
		fileField="uploadFile">
		<cfset loadlogofile=cffile.serverFile>
</cfif>
<cfquery name="updateLabel" datasource="#DSN#">
	update labels
	set
		name=<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
		sort=<cfqueryparam value="#form.sort#" cfsqltype="cf_sql_char">,
		logofile=<cfqueryparam value="#loadlogofile#" cfsqltype="cf_sql_char">,
		active=<cfqueryparam value="#form.active#" cfsqltype="cf_sql_bit">,
		special=<cfqueryparam value="#form.special#" cfsqltype="cf_sql_bit">
	where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cfquery name="Application.adminAllLabels" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,0,0,1)#">
	select *
    from labels
    order by sort, name
</cfquery>
<cfif form.editItem NEQ 0>
	<cflocation url="catalogEdit.cfm?ID=#form.editItem#">
<cfelseif form.delete NEQ "">
	<cflocation url="listsLabelsEdit.cfm?ID=#form.ID#&find=#form.find#">
<cfelse>
	<cflocation url="listsLabels.cfm?letter=#form.letter#&find=#form.find#">
</cfif>