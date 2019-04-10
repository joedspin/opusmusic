<cfparam name="form.ID" default="0">
<cfparam name="form.custID" default="0">
<cfparam name="form.CCTypeID" default="1">
<cfparam name="form.CCFirstName" default="">
<cfparam name="form.CCName" default="">
<cfparam name="form.CCExpMo" default="01">
<cfparam name="form.CCExpYr" default="10">
<cfparam name="form.CCNum" default="">
<cfparam name="form.CCccv" default="">
<cfparam name="form.submit" default="">
<cfif form.submit EQ "Cancel">
	<cflocation url="customersOpusEdit.cfm?ID=#form.custID#">
<cfelse>
	<cfquery name="updateCard" datasource="#DSN#">
		update userCards
		set CCTypeID=<cfqueryparam value="#form.CCTypeID#" cfsqltype="cf_sql_char">,
			CCNum=<cfqueryparam value="#encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">,
			CCFirstName=<cfqueryparam value="#form.CCFirstName#" cfsqltype="cf_sql_char">,
			CCName=<cfqueryparam value="#form.CCName#" cfsqltype="cf_sql_char">,
			CCExpMo=<cfqueryparam value="#encrypt(form.CCExpMo,encryKey71xu)#" cfsqltype="cf_sql_char">,
			CCExpYr=<cfqueryparam value="#encrypt(form.CCExpYr,encryKey71xu)#" cfsqltype="cf_sql_char">,
			CCccv=<cfqueryparam value="#encrypt(form.CCccv,encryKey71xu)#" cfsqltype="cf_sql_char">
		where ID=#form.ID#
	</cfquery>
	<cflocation url="customersOpusEdit.cfm?ID=#form.custID#">
</cfif>