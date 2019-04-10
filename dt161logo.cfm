<cfparam name="url.label" default="">
<cfparam name="url.lf" default="">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0014)about:internet -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>opussitelayout07logo2014.jpg</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--Fireworks 8 Dreamweaver 8 target.  Created Mon Oct 16 13:46:28 GMT-0400 (Eastern Daylight Time) 2006-->
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 1px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body bgcolor="#FFFFFF">
<cfif url.label NEQ "" AND url.lf NEQ ""><cfset linkhome='dt161main.cfm?label='&url.label&'&lf='&url.lf><cfelse><cfset linkhome='dt161landing.cfm'></cfif>
<cfoutput><a href="#linkhome#" target="opusviewmain"><img src="images/dt161logo.jpg" alt="Home" name="Downtown 161" width="400" height="97" vspace="10" border="0" id="opussitelayout07logo" /></a></cfoutput>
</body>
</html>
