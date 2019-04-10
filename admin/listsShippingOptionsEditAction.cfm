<cfparam name="ID" default="0">
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
<cfquery name="updateOption" datasource="#DSN#">
	update shippingRates
	set
		countryID=<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
		name=<cfqueryparam value="#form.name#" cfsqltype="cf_sql_char">,
		shippingTime=<cfqueryparam value="#form.shippingTime#" cfsqltype="cf_sql_char">,
		cost1Record=<cfqueryparam value="#form.cost1Record#" cfsqltype="cf_sql_money">,
		costplusRecord=<cfqueryparam value="#form.costplusRecord#" cfsqltype="cf_sql_money">,
		cost1CD=<cfqueryparam value="#form.cost1CD#" cfsqltype="cf_sql_money">,
		costplusCD=<cfqueryparam value="#form.costplusCD#" cfsqltype="cf_sql_money">,
		minimumItems=<cfqueryparam value="#form.minimumItems#" cfsqltype="cf_sql_char">,
		maximumItems=<cfqueryparam value="#form.maximumItems#" cfsqltype="cf_sql_char">,
		minimumWeight=<cfqueryparam value="#form.minimumWeight#" cfsqltype="cf_sql_char">,
		maximumWeight=<cfqueryparam value="#form.maximumWeight#" cfsqltype="cf_sql_char">
	where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cflocation url="listsShippingOptions.cfm">