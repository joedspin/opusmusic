<cfparam name="url.email" default="">
<cfparam name="form.email" default="">
<cfparam name="userMessage" default="">
<cfset thisEmail=url.email & form.email>
<style type="text/css">
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
</style><title>Downtown 304: Forgotten Login</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" /><br />
<blockquote>
<p>&nbsp;</p>
<h1>Account Lookup</h1>
<cfquery name="userLookup" datasource="#DSN#">
	select *
	from custAccounts
	where email=<cfqueryparam value="#thisEmail#" cfsqltype="cf_sql_char"> AND email<>''
</cfquery>
<cfif thisEmail NEQ "" AND userLookup.recordCount EQ 0>
	<p><font color="red">Email address not found. Please try again.</font></p>
<cfelseif userLookup.recordCount EQ 0>
	<cfform name="getEmail" action="profileForgotPass.cfm" method="post">
		<p>What is your email address? <cfinput name="email" type="text" size="35" maxlength="100"><cfinput name="submit" type="submit" value="Submit"></p>
	</cfform>
<cfelseif thisEmail NEQ "">
<cfmail query="userLookup" to="#thisEmail#" from="order@downtown304.com" subject="Downtown 304 Account Reminder">
Your account login information is below. If you have further questions, please contact Joe D'Espinosa at order@downtown304.com

Username: #username#
Password: #password#

http://www.downtown304.com
</cfmail>
<cfset userMessage="Your login information has been sent to the email address on file.">
</cfif>
<p align="center"><cfoutput><font size="2" color="red">#userMessage#</font></cfoutput></p>
</blockquote>

