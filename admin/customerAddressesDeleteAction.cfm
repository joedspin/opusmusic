<cfparam name="url.ID" default="0">
<cfif url.ID NEQ 0>
	<cfquery name="deleteAddres" datasource="#DSN#">
		delete
		from custAddresses
		where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_char">
	</cfquery>
</cfif>
<cflocation url="customerAddresses.cfm">