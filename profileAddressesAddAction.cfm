<cfparam name="form.addName" default="">
<cfparam name="form.firstName" default="">
<cfparam name="form.lastName" default="">
<cfparam name="form.add1" default="">
<cfparam name="form.add2" default="">
<cfparam name="form.add3" default="">
<cfparam name="form.city" default="">
<cfparam name="form.stateID" default="0">
<cfparam name="form.stateprov" default="">
<cfparam name="form.postcode" default="">
<cfparam name="form.countryID" default="0">
<cfparam name="form.phone" default="">
<cfparam name="form.ret" default="">
<cfparam name="form.shipID" default="0">
<cfparam name="form.shipOptionID" default="0">
<cfquery name="addAddress" datasource="#DSN#">
	insert into custAddresses (custID, addName, firstName, lastName, add1, add2, add3, city, stateID, stateprov, postcode, countryID, phone1)
	values (
		<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.add1#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.add1#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.add2#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.add3#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.city#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.stateID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.stateprov#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.postcode#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.phone#" cfsqltype="cf_sql_char">
	)
</cfquery>
<cfquery name="newAddress" datasource="#DSN#">
	select Max(ID) as MaxID
	from custAddresses
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> and addName=<cfqueryparam value="#form.addName#" cfsqltype="cf_sql_char">
</cfquery>
<cfif form.ret EQ "cos">
	<cflocation url="checkoutShip.cfm?shipID=#newAddress.MaxID#">
<cfelseif form.ret EQ "prb">
	<cflocation url="profileBilling.cfm?billID=#newAddress.MaxID#">
<cfelseif form.ret EQ "cob">
	<cflocation url="checkoutBill.cfm?billID=#newAddress.MaxID#&shipID=#form.shipID#&shipOptionID=#form.shipOptionID#">
<cfelseif form.ret EQ "cobco">
	<cflocation url="checkoutBillCardOnly.cfm?billID=#newAddress.MaxID#&shipID=#form.shipID#&shipOptionID=#form.shipOptionID#">
<cfelse>
	<cflocation url="profileAddresses.cfm">
</cfif>