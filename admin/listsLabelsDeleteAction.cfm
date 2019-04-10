<cfparam name="form.ID" default="0">
<cfparam name="form.name" default="">
<cfparam name="form.sort" default="">
<cfparam name="form.delete" default="No">
<cfparam name="form.letter" default="a">
<cfparam name="form.find" default="">
<cfparam name="form.convertID" default="0">
<cfif form.delete EQ "Yes">
	<cfif form.convertID NEQ 0>
		<cfquery name="convertItems" datasource="#DSN#">
			update catItems
			set labelID=<cfqueryparam value="#form.convertID#" cfsqltype="cf_sql_char">
			where labelID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
		</cfquery>
	</cfif>
	<cfquery name="deleteLabel" datasource="#DSN#">
		delete
		from labels
		where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
	</cfquery>
</cfif>
<cflocation url="listsLabels.cfm?letter=#form.letter#&find=#form.find#">