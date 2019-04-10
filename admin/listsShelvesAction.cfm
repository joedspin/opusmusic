<cfparam name="form.code" default="">
<cfparam name="form.partner" default="">
<cfparam name="form.isVendor" default="no">
<cfquery name="addShelf" datasource="#DSN#">
	insert into shelf (code, partner, isVendor)
    values ('#form.code#','#form.partner#',<cfqueryparam value="#form.isVendor#" cfsqltype="cf_sql_bit">)
</cfquery>
<cflocation url="listsShelves.cfm?added=#form.code#">