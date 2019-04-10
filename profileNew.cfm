<cfinclude template="pageHead.cfm">
<cfparam name="url.co" default="false">
<cfquery name="countries" datasource="#DSN#">
	select *
	from countries
	order by name
</cfquery>
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">New Account</font></b></h1>
	<cfform name="passwordform" id="passwordform" method="post" action="profileNewAction.cfm">
		<table border="0">
		<tr>
			<td>First Name</td>
			<td>
			  <cfinput type="text" name="firstName" size="40" maxlength="50" required="yes" message="First Name is required.">
			</td>
		  </tr>
		  <tr>
			<td>Last Name</td>
			<td>
			  <cfinput type="text" name="lastName" size="40" maxlength="50" required="yes" message="Last Name is required.">
			</td>
		  </tr>
		  <tr>
				<td>email address</td>
				<td>
				  <cfinput type="text" name="email" size="40" maxlength="150" required="yes" message="error in email address.\nnote that it cannot contain spaces\nand must contain an @ symbol" validate="email">
				</td>
			  </tr>
		<tr>
		  	<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		<tr>
			<td>country</td>
			<td><cfselect query="countries" name="countryID" display="name" value="ID" selected="1"></cfselect></td>
		  </tr>
		   <tr>
		  	<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		<tr>
			<td>username (used to log in to your account)</td>
			<td>
			  <cfinput type="text" name="username" size="20" maxlength="15" required="yes" message="username is required.">
			</td>
		  </tr>
		  <tr>
			<td>password</td>
			<td>
			  <cfinput type="password" name="password" size="20" maxlength="15" required="yes" message="password is required.">
			</td>
		  </tr>
		  <tr>
			<td>comfirm password</td>
			<td>
			  <cfinput type="password" name="conPass" size="20" maxlength="15" required="yes" message="confirm password is required.">
			</td>
		  </tr>
		  <tr>
		  	<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td>&nbsp;</td>
			<td><input type="submit" name="submit" value=" Create Account  " /></td>
		  </tr>
		</table>
		<cfoutput><input type="hidden" name="co" value="#url.co#" /></cfoutput>
	</cfform>
	<p><font size="1">**Note: The information you provide will not be shared or sold to anyone.</font></p>
</blockquote>
<cfinclude template="pageFoot.cfm">