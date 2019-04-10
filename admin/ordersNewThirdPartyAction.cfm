<cfparam name="url.pageBack" default="orders.cfm">
<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<!--- ACCOUNT VARIABLES //--->
<cfparam name="form.firstName" default="">
<cfparam name="form.lastName" default="">
<cfparam name="form.email" default="">
<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cfparam name="form.conpass" default="#form.password#">
<cfparam name="form.otherSiteID" default="0">
<cfparam name="form.otherSiteOrderNum" default="">
<cfparam name="form.sendNotice" default="no">
<!--- <cfparam name="countryID" default="0"> REMOVED THIS REDUNANDANT countryID; we'll use the same country as the shipping address //--->
<!--- ADDRESS VARIABLES //--->
<!---<cfparam name="form.addName" default="">//--->
<!---<cfparam name="form.firstName" default="">
<cfparam name="form.lastName" default=""> SAME AS countryID above//--->
<cfparam name="form.add1" default="">
<cfparam name="form.add2" default="">
<cfparam name="form.add3" default="">
<cfparam name="form.city" default="">
<cfparam name="form.stateID" default="0">
<cfparam name="form.stateprov" default="">
<cfparam name="form.postcode" default="">
<cfparam name="form.countryID" default="0">
<cfparam name="form.phone" default="">
<cfparam name="form.shipOptionID" default="0">
<cfparam name="form.comments" default="">
<cfif form.shipOptionID EQ 0 OR form.countryID EQ 0><h1><font color="red">ERROR</font></h1>
	<cfif shipOptionID EQ 0><p>You must select a shipping option</p></cfif>
	<cfif countryID EQ 0><p>You must select a country</p></cfif>
	<p><font color="red">Click BACK to try again.</font></p><cfabort>
</cfif>
<cfif otherSiteID EQ 0><p><font color="yellow">(note: you did not select an "other site". This order will be set up as a Downtown 304 order. If you want it to be a 3rd party order instead, click back to change the selection.)</font></p></cfif>
<!--- BEGINNING NEW ACCOUNT SECTION //--->
<cfquery name="existingUser" datasource="#DSN#">
	select *
	from custAccounts
	where username=<cfqueryparam value="#form.username#" cfsqltype="cf_sql_char">
</cfquery>
<cfset thisEmail=existingUser.email>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">New Account</font></b></h1>
<cfif existingUser.recordCount GT 0>
	<p><font color="red">ERROR</font><br />
		The username you selected is already in use. Click BACK in your browser to try a different username OR click below to shop using the existing account.</p>
		<cfoutput query="existingUser">
			<cfform name="shopOrder" action="ordersShopStart.cfm" method="post">
			<table>
				<tr><td>username:</td><td>#username#</td></tr>
				<tr><td>#firstName# #lastName#</td></tr>
				<tr><td><cfinput type="submit" name="submit" value=" Shop "><cfinput type="hidden" name="username" value="#username#"></td></tr></table></cfform>
		</cfoutput>
<cfelse>
	<cfif form.conPass EQ form.password>
		<cfquery name="newAccount" datasource="#DSN#">
			insert into custAccounts (firstName, lastName, email, username, password, countryID, dateAdded)
			values (
				<cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#form.email#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#form.username#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#form.password#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
			)
		</cfquery>
		<cfquery name="checkML" datasource="#DSN#">
			select *
			from GEMMCustomers
			where email=<cfqueryparam value="#form.email#" cfsqltype="cf_sql_char">
		</cfquery>
		<cfif checkML.recordCount EQ 0>
			<cfquery name="addML" datasource="#DSN#">
				insert into GEMMCustomers (name, email, subscribe)
				values (<cfqueryparam value="#form.firstName# #form.lastName#" cfsqltype="cf_sql_char">,<cfqueryparam value="#form.email#" cfsqltype="cf_sql_char">,1)
			</cfquery>
		</cfif>
		<cfif form.sendNotice EQ "yes">
		<cfquery name="thisCountry" datasource="#DSN#">
			select name
			from countries
			where ID=<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">
		</cfquery>
		<cfmail to="#form.email#" bcc="order@downtown304.com" from="order@downtown304.com" subject="Downtown 304 . new account">
Thank you for creating a user account on http://www.downtown304.com

Your account information is reviewed below:

     username:   #form.username#
     password:   #form.password#
	 
     First Name: #form.firstName#
     Last Name:  #form.lastName#
     Country:    #thisCountry.name#
	 
     email:      #form.email#
	 
     Date Added: #DateFormat(varDateODBC,"mm/dd/yyyy")#
	 
Your email address will only be used to send order confirmations. You may optionally subscribe for site update notices by visiting the "My Account" page of the site.

Send comments or suggestions to order@downtown304.com
</cfmail>
</cfif>
</cfif>
</blockquote>

<cfquery name="thisUserAccount" datasource="#DSN#">
	select *
	from custAccounts
	where username=<cfqueryparam value="#form.username#" cfsqltype="cf_sql_char"> AND password=<cfqueryparam value="#form.password#" cfsqltype="cf_sql_char">
</cfquery>
<!---<cflock scope="session" timeout="20" type="exclusive">
	<cfset Session.userID=thisUserAccount.ID>
</cflock>//--->
<cfset thisCustID=thisUserAccount.ID>
<!--- END OF NEW ACCOUNT SECTION //--->
<!--- BEGINNING OF NEW ADDRESS SECTION //--->
<cfquery name="addAddress" datasource="#DSN#">
	insert into custAddresses (custID, addName, firstName, lastName, add1, add2, add3, city, stateID, stateprov, postcode, countryID, phone1)
	values (
		<cfqueryparam value="#thisCustID#" cfsqltype="cf_sql_char">,
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
	where custID=<cfqueryparam value="#thisCustID#" cfsqltype="integer"> and addName=<cfqueryparam value="#form.add1#" cfsqltype="cf_sql_char">
</cfquery>
<cfset thisAddressID=newAddress.MaxID>
<!--- END OF NEW ADDRESS SECTION //--->
<cfquery name="addCustOrder" datasource="#DSN#">
	insert into orders (custID, dateStarted, dateUpdated, datePurchased, statusID, shipID, shipAddressID, otherSiteID, otherSiteOrderNum,specialInstructions,picklistPrinted,readyToPrint,paymentTypeID,userCardID)
	values (#thisCustID#,#varDateODBC#,#varDateODBC#,#varDateODBC#,2,#form.shipOptionID#,#thisAddressID#,#form.otherSiteID#,
    		<cfqueryparam value="#form.otherSiteOrderNum#" cfsqltype="cf_sql_char">,<cfqueryparam value="#form.comments#" cfsqltype="cf_sql_longvarchar">,0,0,5,0)
</cfquery>
<cfquery name="getNewOrderID" datasource="#DSN#">
	select Max(ID) As MaxID
	from orders
	where custID=#thisCustID# AND statusID=2
</cfquery>
<cfset thisOrderID=getNewOrderID.MaxID>
<cflocation url="ordersShop.cfm?orderID=#thisOrderID#">
</cfif>
<cfinclude template="pageFoot.cfm">