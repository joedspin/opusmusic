<cfparam name="form.email" default=""><style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #CCCCCC;
}
body {
	background-color: #000000;
}
a:link {
	color: FFCC66;
}
a:visited {
	color: FFCC66;
}
a:hover {
	color: FFCC66;
}
a:active {
	color: FFCC66;
}
-->
</style><title>Downtown 304: Forgotten Login</title><br>
<cfquery name="userLookup" datasource="#DSN#">
	select *
	from wagamamaUsersHHG
	where email=<cfqueryparam value="#form.email#" cfsqltype="cf_sql_char">
</cfquery>
<cfif userLookup.recordCount EQ 0>
	<cfset userMessage="Email address not found. Please try again.">
<cfelse>
<cfmail query="userLookup" to="#form.email#" from="info@downtown304.com" subject="Downtown 304 Admin Account Reminder">
Your account login information is below. If you have further questions, please contact Joe D'Espinosa at order@downtown304.com

Username: #username#
Password: #password#

www.downtown304.com/admin
</cfmail>
<cfset userMessage="Your login information has been sent to the email address you provided.">
</cfif>
<p align="center"><cfoutput><font size="2" color="red">#userMessage#</font></cfoutput></p>
<div align="center"><a href="admin">Click here to login</a></div>
