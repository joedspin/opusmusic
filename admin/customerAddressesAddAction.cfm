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
<cfparam name="form.retOrderID" default="0">
<cfparam name="form.custID" default="0">
<cfparam name="form.ret" default="orderedit">
<cfquery name="addAddress" datasource="#DSN#">
	insert into custAddresses (custID, addName, firstName, lastName, add1, add2, add3, city, stateID, stateprov, postcode, countryID, phone1)
	values (
		<cfqueryparam value="#form.custID#" cfsqltype="cf_sql_char">,
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
	where custID=<cfqueryparam value="#form.custID#" cfsqltype="integer"> and addName=<cfqueryparam value="#form.add1#" cfsqltype="cf_sql_char">
</cfquery>
<cfif form.ret EQ "pay">
	<cfquery name="changeOrder" datasource="#DSN#">
		update orders
		set billingAddressID=#newAddress.MaxID#
		where ID=#form.retOrderID#
	</cfquery>
	<cflocation url="ordersPay.cfm?ID=#form.retOrderID#">
<cfelse>
	<cfquery name="changeOrder" datasource="#DSN#">
		update orders
		set shipAddressID=#newAddress.MaxID#
		where ID=#form.retOrderID#
	</cfquery>
	<cflocation url="ordersEdit.cfm?ID=#form.retOrderID#">
</cfif>