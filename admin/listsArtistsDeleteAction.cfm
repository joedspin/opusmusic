<cfparam name="form.ID" default="0">
<cfparam name="form.name" default="">
<cfparam name="form.sort" default="">
<cfparam name="form.delete" default="No">
<cfparam name="form.letter" default="a">
<cfparam name="form.convertID" default="0">
<cfparam name="form.editItem" default="0">
<cfparam name="form.find" default="">
<cfif form.delete EQ "Yes">
	<cfif form.convertID NEQ 0>
		<cfquery name="convertItems" datasource="#DSN#">
			update catItems
			set artistID=<cfqueryparam value="#form.convertID#" cfsqltype="cf_sql_char">
			where artistID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
		</cfquery>
		<cfquery name="convertLists" datasource="#DSN#">
			update artistLists
			set artistID=<cfqueryparam value="#form.convertID#" cfsqltype="cf_sql_char">
			where artistID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
		</cfquery>
	</cfif>
	<cfquery name="deleteArtist" datasource="#DSN#">
		delete
		from artists
		where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
	</cfquery>
</cfif>
<cfif form.editItem NEQ 0>
	<cflocation url="catalogEdit.cfm?ID=#form.editItem#">
<cfelse>
	<cflocation url="listsArtists.cfm?letter=#form.letter#&find=#form.find#">
</cfif>