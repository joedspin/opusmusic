<cfparam name="form.ID" default="0">
<cfparam name="form.ignoreSales" default="0">
<cfparam name="form.isStore" default="0">
<cfparam name="form.badCustomer" default="0">
<cfparam name="form.find" default="">
<cfparam name="form.findField" default="">
<cfquery name="updateCust" datasource="#DSN#">
	update custAccounts
    set firstName='#form.firstName#',
    	lastName='#form.lastName#',
        billingName='#form.billingName#',
        countryID=#form.countryID#,
        username='#form.username#',
        password='#form.password#',
        email='#form.email#',
        badCustomer=<cfqueryparam value="#form.badCustomer#" cfsqltype="cf_sql_bit">,
        ignoreSales=<cfqueryparam value="#form.ignoreSales#" cfsqltype="cf_sql_bit">,
        isStore=<cfqueryparam value="#form.isStore#" cfsqltype="cf_sql_bit">,
        custNotes=<cfqueryparam value="#form.custNotes#" cfsqltype="cf_sql_longvarchar">
    where ID=#form.ID#
</cfquery>
<cflocation url="customersOpus.cfm?letter=#form.letter#&find=#form.find#&findField=#form.findField#">
y