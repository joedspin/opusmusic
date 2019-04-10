<!---<cfparam name="Cookie.username" default="">
<cfparam name="Session.userID" default="0">
<cfparam name="Session.username" default="">
<cfparam name="url.loginfailed" default="no">//--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0014)about:internet -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Downtown 161 Users</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!---<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<style type="text/css">td img {display: block;}body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>
<!--Fireworks 8 Dreamweaver 8 target.  Created Mon Oct 16 13:48:54 GMT-0400 (Eastern Daylight Time) 2006-->//--->
</head>
<body bgcolor="#FFFFFF">
<!---<table border="0" cellpadding="0" cellspacing="0" width="207">
<!-- fwtable fwsrc="opussitelayout07user.png" fwbase="opussitelayout07users.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="17" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="178" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="12" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td colspan="3"><img name="opussitelayout07users_r1_c1" src="images/opussitelayout07users_r1_c1.jpg" width="207" height="41" border="0" id="opussitelayout07users_r1_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="41" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="2"><img name="opussitelayout07users_r2_c1" src="images/opussitelayout07users_r2_c1.jpg" width="17" height="96" border="0" id="opussitelayout07users_r2_c1" alt="" /></td>
   <td valign="top" bgcolor="#333333">
   
   <cfif Session.userID EQ 0>
   <cfif url.loginfailed EQ "yes"><p align="center" style="margin-top:0px; margin-bottom: 0px; color:red">Bad Login. Try again.</p>
   </cfif>
				<form id="loginform" name="loginform" method="post" action="index.cfm" target="_top">
					 <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
					 	<tr>
							<td colspan="3" align="right"><a href="profileNew.cfm" target="opusviewmain">new account</a> | <a href="profileForgotPass.cfm" target="opusviewmain">forgot password</a></td>
						</tr>
						<tr>
							<td align="right">username:</td>
							<td width="10">&nbsp;</td>
							<td align="right"><input name="username" type="text" id="username" size="12" maxlength="15" <cfif Cookie.username NEQ ""><cfoutput>value="#Cookie.username#"</cfoutput></cfif>/></td>
						</tr>
						<tr>
							<td align="right">password:</td>
							<td>&nbsp;</td>
							<td align="right"><input name="password" type="password" id="password" size="12" maxlength="15" /></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td align="right"><input name="login" type="submit" id="login" value="login" /></td>
						</tr>
					</table>
				</form>
			   <cfelse>
			   	<cfset Cookie.username=Session.username>
			   	<cfoutput><p style="margin-top: 12px;">#Session.username#</cfoutput><br />
				<a href="profile.cfm?custID=#custID#" target="opusviewmain">My Account</a><br />
				<a href="index.cfm?logout=true" target="_top">Logout</a></p>
	      </cfif>
   </td>
   <td rowspan="2"><img name="opussitelayout07users_r2_c3" src="images/opussitelayout07users_r2_c3.jpg" width="12" height="96" border="0" id="opussitelayout07users_r2_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="89" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07users_r3_c2" src="images/opussitelayout07users_r3_c2.jpg" width="178" height="7" border="0" id="opussitelayout07users_r3_c2" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="7" border="0" alt="" /></td>
  </tr>
</table>//--->
</body>
</html>
