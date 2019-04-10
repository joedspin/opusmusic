<cfparam name="form.ID" default="0">
<cfparam name="form.name" default="">
<cfparam name="form.abbrev" default="">
<cfparam name="form.delete" default="No">
<cfparam name="form.convertID" default="0">
<cfif form.delete EQ "Yes">
	<cfif form.convertID NEQ 0>
		<cfquery name="convertAccounts" datasource="#DSN#">
			update custAccounts
			set countryID=<cfqueryparam value="#form.convertID#" cfsqltype="cf_sql_char">
			where countryID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
		</cfquery>
		<cfquery name="convertAddresses" datasource="#DSN#">
			update custAddresses
			set countryID=<cfqueryparam value="#form.convertID#" cfsqltype="cf_sql_char">
			where countryID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
		</cfquery>
	</cfif>
	<cfquery name="deleteCountry" datasource="#DSN#">
		delete
		from countries
		where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
	</cfquery>
</cfif>
<cflocation url="listsCountries.cfm">