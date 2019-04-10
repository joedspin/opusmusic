<cfparam name="form.countryID" default="1">
<cfparam name="form.name" default="">
<cfparam name="form.shippingTime" default="">
<cfparam name="form.cost1Record" default="0.00">
<cfparam name="form.costplusRecord" default="0.00">
<cfparam name="form.cost1CD" default="0.00">
<cfparam name="form.costplusCD" default="0.00">
<cfparam name="form.minimumItems" default="1">
<cfparam name="form.maximumItems" default="0">
<cfparam name="form.minimumWeight" default="1">
<cfparam name="form.maximumWeight" default="0">
<cfquery name="addShippingOption" datasource="#DSN#">
	insert into shippingRates (countryID, name, shippingTime, cost1Record, costplusRecord, cost1CD, costplusCD, minimumItems, maximumItems, minimumWeight, maximumWeight)
	values (<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.shippingTime#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.cost1Record#" cfsqltype="cf_sql_money">,
		<cfqueryparam value="#form.costplusRecord#" cfsqltype="cf_sql_money">,
		<cfqueryparam value="#form.cost1CD#" cfsqltype="cf_sql_money">,
		<cfqueryparam value="#form.costplusCD#" cfsqltype="cf_sql_money">,
		<cfqueryparam value="#form.minimumItems#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.maximumItems#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.minimumWeight#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.maximumWeight#" cfsqltype="cf_sql_char">)
</cfquery>
<cflocation url="listsShippingOptions.cfm">