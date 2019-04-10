<cfinclude template="pageHead.cfm">
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">New Account</font></b> Change Password</h1>
	<cfform name="passwordform" id="passwordform" method="post" action="profilePasswordAction.cfm">
		<table border="0">
			<tr>
			<td>old password</td>
			<td>
			  <cfinput type="password" name="oldPass" size="20" maxlength="15" required="yes" message="old password is required.">
			</td>
		  </tr>
		  <tr>
		  	<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td>new password</td>
			<td>
			  <cfinput type="password" name="newPass" size="20" maxlength="15" required="yes" message="new password is required.">
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
			<td><input type="submit" name="submit" value=" Save  " /></td>
		  </tr>
		</table>
	</cfform>
	<p><a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">