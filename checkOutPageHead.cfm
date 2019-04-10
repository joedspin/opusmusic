<cfparam name="form.dsu" default="xxxxxxxxxx">
<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cfparam name="url.cart" default="checkout">
<cflock scope="session" timeout="20" type="exclusive">
	<cfparam name="Session.userID" default="0">
	<cfparam name="Session.username" default="">
	<cfparam name="Session.orderID" default="0">
    <cfparam name="Session.isStore" default="false">
</cflock>
<cfparam name="url.dsu" default="#form.dsu#">
<cfif url.dsu NEQ "xxxxxxxxxx"><cfset thisUserID=urlDecode(Decrypt(url.dsu,'y6DD3cxo86zHGO'))><cfelse><cfset thisUserID=0></cfif>
<cfif thisUserID NEQ 0 AND IsNumeric(thisUserID)>
	<cflock scope="session" timeout="20" type="exclusive">
		<cfset Session.userID=thisUserID>
    </cflock>
</cfif>
<cfif Session.userID NEQ 0>
    <cfquery name="lookupUser" datasource="#DSN#">
        select ID, username, isStore
        from custAccounts
        where ID=<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfquery name="openOrder" datasource="#DSN#">
        select *
        from orders
        where custID=<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer"> AND statusID=1
    </cfquery>
    <cflock scope="session" timeout="20" type="exclusive">
        <cfset Session.userID=lookupUser.ID>
        <cfset Session.username=lookupUser.username>
        <cfset Cookie.username=Session.username>
        <cfset Session.isStore=lookupUser.isStore>
        <cfset Cookie.isStore=lookupUser.isStore>
        <cfif openOrder.RecordCount GT 0>
            <cfset Session.orderID=openOrder.ID>
        <cfelse>
            <cfset Session.orderID=0>
        </cfif>
    </cflock>
</cfif>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304</title>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link rel="stylesheet" type="text/css" href="http://downtown304.com/styles/opusstyles.css" />
<style>
<cfif url.cart EQ "view">
body {margin-top: 20px; margin-bottom: 20px; margin-left: 20px; margin-right: 20px; background-color:#1F1A17;}
body, p, td {font-size: xx-small;}
input {font-size: x-small;}
<cfelse>
body {margin-top: 20px; margin-bottom: 20px; margin-left: 20px; margin-right: 20px; background-color:#1F1A17;}
body, p, td {font-size: small;}
input {font-size: small;}
</cfif>
</style>
<script language="javascript" src="http://downtown304.com/scripts/opusscript.js" type="text/javascript"></script>
</head>
<body>
<cfif url.cart NEQ "view"><p style="font-size: large; font-weight: bold; color:#336699; margin-bottom: 0px;"><img src="images/dt304Logo.jpg" alt="Downtown 304 Records" width="250" height="128"></p></cfif>
<cfif NumberFormat(Session.userID) EQ 0>
	<blockquote>
    <p>Your login to Downtown 304 has timed out. Please log in again.</p>
    <p>Note that if you were checking out using PayPal, your order has probably been placed. When you log back in, if your shopping cart is empty then we have received your order.<p><a href="http://www.downtown304.com/index.cfm?logout=true">Click here</a> to go back to the home page.</p>
    </blockquote><cfabort>
</cfif>


	
