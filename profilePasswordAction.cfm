<cfinclude template="pageHead.cfm">
<cfparam name="form.oldPass" default="">
<cfparam name="form.newPass" default="">
<cfparam name="form.conPass" default="">
<cfquery name="thisUser" datasource="#DSN#">
	select *
	from custAccounts
	where ID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
</cfquery>
<cfif form.oldPass EQ thisUser.password>
	<cfif form.newPass EQ form.conPass>
		<cfquery name="changePassword" datasource="#DSN#">
			update custAccounts
			set password=<cfqueryparam value="#form.newPass#" cfsqltype="cf_sql_char">
			where ID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
		</cfquery>
		<blockquote>
			<h1>Change Password</h1>
			<p>Password successfully changed.</p>
			<p><a href="profile.cfm">Back to My Account</a></p>
		</blockquote>
	<cfelse>
		<blockquote>
			<h1>Change Password</h1>
			<p><font color="red">ERROR</font></p>
			<p>'new password' and 'confirm password' did not match. <a href="profilePassword.cfm">Try again</a></p>
			<p><a href="profile.cfm">Back to My Account</a></p>
		</blockquote>
	</cfif>
<cfelse>
	<blockquote>
			<h1>Change Password</h1>
			<p><font color="red">ERROR</font></p>
			<p>'old password' did not match password on file. <a href="profilePassword.cfm">Try again</a></p>
			<p><a href="profile.cfm">Back to My Account</a></p>
		</blockquote>
</cfif>
<cfinclude template="pageFoot.cfm">