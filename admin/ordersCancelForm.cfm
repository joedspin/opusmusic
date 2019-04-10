<cfparam name="url.access" default="">
<cfif url.access NEQ "jtdmwh"><cfabort></cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304</title>
<style type="text/css">
<!--
body,td,th {
	color: #FFFFFF;
}
body {
	background-color: #FF9900;
}
-->
</style></head>

<body>
<form action="ordersCancel.cfm" method="post" name="theform">
	<div align="center">
	  &nbsp;&nbsp;
	  <p>&nbsp;</p>
	  <p>
	    <input type="text" name="cancelID" size="10" maxlength="10" />
	    <br />
	    <input type="submit" name="submit" value="Cancel" /><cfoutput><input type="hidden" name="access" value="#url.access#" /></cfoutput>
        </p>
  </div>
</form>
</body>
</html>
