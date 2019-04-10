<cfparam name="form.ID" default="0">
<cfparam name="form.find" default="">
<cfparam name="form.findField" default="">
<cfif form.delete EQ "Yes">
	<cfquery name="deleteCust" datasource="#DSN#">
		delete 
		from custAccounts
		where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
	</cfquery>
</cfif>
<cflocation url="customersOpus.cfm?find=#form.find#&findField=#form.findField#">