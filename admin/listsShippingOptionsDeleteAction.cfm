<cfparam name="form.ID" default="0">
<cfif form.delete EQ "Yes">
	<cfquery name="deleteLabel" datasource="#DSN#">
		delete 
		from shippingRates
		where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
	</cfquery>
</cfif>
<cflocation url="listsShippingOptions.cfm">