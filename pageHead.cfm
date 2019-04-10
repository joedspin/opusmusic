<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cflock scope="session" timeout="20" type="exclusive">
	<cfparam name="Session.userID" default="0">
	<cfparam name="Session.username" default="">
	<cfparam name="Session.orderID" default="0">
</cflock>
<cfparam name="Cookie.searchstring" default="">
<cfparam name="Cookie.radiobutton" default="all">
<cfparam name="Cookie.sortOrder" default="DESC">
<cfparam name="Cookie.orderBy" default="releaseDate">
<cfparam name="Cookie.group" default="new">
<cfparam name="url.cartReset" default="false">
<cfparam name="url.userReset" default="false">
<cfif url.userReset>
	<cflock scope="session" timeout="20" type="exclusive">
		<cfset Session.userID=0>
		<cfset Session.username="">
	</cflock>
</cfif>
<cfif form.username NEQ "">
	<cfquery name="lookupUser" datasource="#DSN#">
		select *
		from custAccounts
		where username=<cfqueryparam value="#form.username#" cfsqltype="cf_sql_char">
			AND password=<cfqueryparam value="#form.password#" cfsqltype="cf_sql_char">
	</cfquery>
	<cfif lookupUser.recordCount NEQ 0>
		<cfquery name="openOrder" datasource="#DSN#">
			select *
			from orders
			where custID=#lookupUser.ID# AND statusID=1
		</cfquery>
		<cflock scope="session" timeout="20" type="exclusive">
			<cfset Session.userID=lookupUser.ID>
			<cfset Session.username=lookupUser.username>
			<cfif openOrder.RecordCount GT 0>
				<cfset Session.orderID=openOrder.ID>
			<cfelse>
				<cfset Session.orderID=0>
			</cfif>
		</cflock>
	</cfif>
</cfif>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304 Records. House, Techno, Deep House, Disco, Tech House, R&amp;B, Soul, Indie, 12" Singles, LPs, 7" Singles, CDs</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
</head>
<body onload="MM_preloadImages('images/shopButton01_f2.jpg','images/shopButton01_f3.jpg')">


	
