<cfinclude template="pageHead.cfm">
<cfquery name="thisUser" datasource="#DSN#">
	select email
	from custAccounts
	where ID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
</cfquery>
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">My Account</font></b> Change Email</h1>
	<cfform name="emailform" id="emailform" method="post" action="profileEmailAction.cfm">
		<table border="0">
			<tr>
			<td>confirm your password</td>
			<td>
			  <cfinput type="password" name="conPass" size="20" maxlength="15" required="yes" message="password is required.">
			</td>
		  </tr>
		  <tr>
		  	<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		  <cfoutput query="thisUser">
			  <tr>
				<td>email address</td>
				<td>
				  <cfinput type="text" name="email" size="40" maxlength="150" required="yes" value="#email#" message="error in email address.\nnote that it cannot contain spaces\nand must contain an @ symbol" validate="email">
				</td>
			  </tr>
			</cfoutput>
		  <tr>
			<td>&nbsp;</td>
			<td><input type="submit" name="submit" value=" Save " /></td>
		  </tr>
		</table>
	</cfform>
	<p><a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">