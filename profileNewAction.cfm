<cfinclude template="pageHead.cfm">
<cfparam name="form.firstName" default="">
<cfparam name="form.lastName" default="">
<cfparam name="form.email" default="">
<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cfparam name="form.conpass" default="">
<cfparam name="countryID" default="0">
<cfparam name="Session.cart" default="">
<cfquery name="existingUser" datasource="#DSN#">
	select *
	from custAccounts
	where username=<cfqueryparam value="#form.username#" cfsqltype="cf_sql_char">
</cfquery>
<cfset thisEmail=existingUser.email>
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">New Account</font></b></h1>
<cfif existingUser.recordCount GT 0>
	<p><font color="red">ERROR</font><br />
		The username you selected is already in use. Click back in your browser to try a different username.</p>
		<p>If you believe the existing account is yours, <a href="profileForgotPass.cfm?email=<cfoutput>#thisEmail#</cfoutput>">click here</a>
		to have a password reminder sent to the email address on file, or use the login form at
		the top right of this screen to login using your existing username and password.</p>
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
		<cfquery name="thisCountry" datasource="#DSN#">
			select name
			from countries
			where ID=<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">
		</cfquery>
		<cfmail to="#form.email#" bcc="order@downtown304.com" from="order@downtown304.com" subject="Downtown 304 . new account">
Thank you for creating a user account on http://www.downtown304.com
	 
Want to stay up-to-date on New Releases and Sales, as well as occasional Special Offers and Promotional Codes? Join our email list here: http://eepurl.com/bfUjIj

Your account information is reviewed below:

     username:   #form.username#
     password:   #form.password#
	 
     First Name: #form.firstName#
     Last Name:  #form.lastName#
     Country:    #thisCountry.name#
	 
     email:      #form.email#
	 
     Date Added: #DateFormat(varDateODBC,"mm/dd/yyyy")#

Send comments or suggestions to order@downtown304.com
</cfmail>
<cfquery name="thisUserAccount" datasource="#DSN#">
	select *
	from custAccounts
	where username=<cfqueryparam value="#form.username#" cfsqltype="cf_sql_char"> AND password=<cfqueryparam value="#form.password#" cfsqltype="cf_sql_char">
</cfquery>
<cflock scope="session" timeout="20" type="exclusive">
	<cfset Session.userID=thisUserAccount.ID>
</cflock>
<cfif Session.cart NEQ "">
	<cfquery name="openOrder" datasource="#DSN#">
		select *
		from orders
		where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND statusID=1
	</cfquery>
	<cflock scope="session" timeout="20" type="exclusive">
		<cfif openOrder.RecordCount GT 0>
			<cfset Session.orderID=openOrder.ID>
		<cfelse>
			<cfset Session.orderID=0>
		</cfif>
	</cflock>
		<cfif Session.orderID NEQ 0>
			<cfquery name="thisCustOrder" datasource="#DSN#">
				select *
				from orders
				where ID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
			</cfquery>
		<cfelse>
			<cfquery name="addCustOrder" datasource="#DSN#">
				insert into orders (custID, dateStarted, statusID)
				values (<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer">,#varDateODBC#,1)
			</cfquery>
			<cfquery name="getNewOrderID" datasource="#DSN#">
				select Max(ID) As MaxID
				from orders
				where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND statusID=1
			</cfquery>
			<cflock scope="session" timeout="20" type="exclusive"><cfset Session.orderID=getNewOrderID.MaxID></cflock>
		</cfif>
		<cfquery name="cartContents" datasource="#DSN#">
			select catnum, title, artist, 1 As qtyOrdered, ID, price, weight, weightException, label, NRECSINSET, media, mediaID
			from catItemsQuery
			where ID IN (#Session.cart#)
		</cfquery>
		<cfloop query="cartContents">
			<cfset thisItemAdd=cartContents.ID>
			<cfquery name="checkCart" datasource="#DSN#">
				select ID, qtyOrdered
				from orderItems
				where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer"> AND catItemID=<cfqueryparam value="#thisItemAdd#" cfsqltype="cf_sql_char">
			</cfquery>
			<cfif checkCart.recordCount GT 0>
				<cfquery name="addToQty" datasource="#DSN#">
					update orderItems
					set qtyOrdered=(#checkCart.qtyOrdered#+1)
					where ID=#checkCart.ID#
				</cfquery>
			<cfelse>
				<cfquery name="getPrice" datasource="#DSN#">
					select price
					from catItems
					where ID=<cfqueryparam value="#thisItemAdd#" cfsqltype="cf_sql_integer">
				</cfquery>
				<cfquery name="addToCart" datasource="#DSN#">
					insert into orderItems (orderID,catItemID,qtyOrdered,price)
					values (
						<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#thisItemAdd#" cfsqltype="cf_sql_char">,
						1,
						<cfqueryparam value="#getPrice.price#" cfsqltype="cf_sql_money">
					)
				</cfquery>
			</cfif>
		</cfloop>
		<cflock scope="session" timeout="20" type="exclusive">
			<cfset Session.cart="">
		</cflock>
</cfif>
			<p>Your account has been successfully created. An email confirmation will arrive shortly.</p>
            <p>Want to stay up-to-date on New Releases and Sales, as well as occasional Special Offers and Promotional Codes? <a href="http://eepurl.com/bfUjIj">Join our email list</a></p>
			<cfif form.co>
				<a href="checkOut.cfm">Continue Checkout</a>
			</cfif>
	<cfelse>
			<p><font color="red">ERROR - account not created</font></p>
			<p>password and confirm password did not match. Click back in your browser to try again.</p>
	</cfif>
</cfif>
</blockquote>
<cfinclude template="pageFoot.cfm">