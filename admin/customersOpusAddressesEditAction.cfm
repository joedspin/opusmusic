<cfparam name="form.addName" default="">
<cfparam name="form.firstName" default="">
<cfparam name="form.lastName" default="">
<cfparam name="form.add1" default="">
<cfparam name="form.add2" default="">
<cfparam name="form.add3" default="">
<cfparam name="form.city" default="">
<cfparam name="form.stateID" default="0">
<cfparam name="form.stateprov" default="">
<cfparam name="form.countryID" default="0">
<cfparam name="form.phone" default="">
<cfparam name="form.ret" default="">
<cfparam name="form.shipID" default="0">
<cfparam name="form.shipOptionID" default="0">
<cfquery name="updateAddress" datasource="#DSN#">
	update custAddresses 
	set
		custID=<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_char">,
		addName=<cfqueryparam value="#form.addName#" cfsqltype="cf_sql_char">,
		firstName=<cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_char">,
		lastName=<cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_char">,
		add1=<cfqueryparam value="#form.add1#" cfsqltype="cf_sql_char">,
		add2=<cfqueryparam value="#form.add2#" cfsqltype="cf_sql_char">,
		add3=<cfqueryparam value="#form.add3#" cfsqltype="cf_sql_char">,
		city=<cfqueryparam value="#form.city#" cfsqltype="cf_sql_char">,
		stateID=<cfqueryparam value="#form.stateID#" cfsqltype="cf_sql_char">,
		stateprov=<cfqueryparam value="#form.stateprov#" cfsqltype="cf_sql_char">,
		postcode=<cfqueryparam value="#form.postcode#" cfsqltype="cf_sql_char">,
		countryID=<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
		phone1=<cfqueryparam value="#form.phone#" cfsqltype="cf_sql_char">
	where ID=#form.ID#
</cfquery>
<cfquery name="newAddress" datasource="#DSN#">
	select Max(ID) as MaxID
	from custAddresses
	where custID=#Session.userID# and addName=<cfqueryparam value="#form.addName#" cfsqltype="cf_sql_char">
</cfquery>
<cfif form.ret EQ "cos">
	<cflocation url="checkoutShip.cfm?shipID=#newAddress.MaxID#">
<cfelseif form.ret EQ "cob">
	<cflocation url="checkoutBill.cfm?billID=#newAddress.MaxID#">
<cfelse>
	<cflocation url="profileAddresses.cfm">
</cfif>