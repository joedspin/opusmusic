<cfinclude template="pageHead.cfm">
<cfparam name="form.conPass" default="">
<cfparam name="form.email" default="">
<cfquery name="thisUser" datasource="#DSN#">
	select email, password
	from custAccounts
	where ID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
</cfquery>
<cfif form.conPass EQ thisUser.password>
	<cfquery name="changeEmail" datasource="#DSN#">
		update custAccounts
		set email=<cfqueryparam value="#form.email#" cfsqltype="cf_sql_char">
		where ID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
	</cfquery>
	<blockquote>
		<h1>Change Email</h1>
		<p>Email successfully changed.</p>
		<p><a href="profile.cfm">Back to My Account</a></p>
	</blockquote>
<cfelse>
	<blockquote>
		<h1>Change Email</h1>
		<p><font color="red">ERROR - email not changed</font></p>
		<p>password did not match. <a href="profileEmail.cfm">Try again</a></p>
		<p><a href="profile.cfm">Back to My Account</a></p>
	</blockquote>
</cfif>
<cfinclude template="pageFoot.cfm">