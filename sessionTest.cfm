
<cfparam name="url.reload" default="no">
<cfparam name="Session.testVariable1" default="spaghetti straps">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<cfapplication name="downtown304" sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,2,0,0)#">
<cfif url.reload EQ "no"><cfset Session.testVariable1="test value 1"></cfif>
<p><cfoutput>Session.testVariable1=#Session.testVariable1#</cfoutput></p>
<p><a href="sessionTest.cfm?reload=yes">Reload</a></p>
<body>
</body>
</html>