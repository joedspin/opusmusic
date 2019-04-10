<cfmail to="order@downtown304.com" from="info@downtown304.com" subject="User Error Encountered on downtown304.com" type="html">
<style>
body {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
</style>
<p>An error occurred when you requested this page.</p>
<p>Please send e-mail with the following information to #error.mailTo# to reportthis error.</p>

<table border=1>
<tr><td><b>Error Information</b> <br>
	Date and time: #error.DateTime# <br>
	Page: #error.template# <br>
	Remote Address: #error.remoteAddress# <br>
	HTTP Referer: #error.HTTPReferer#<br>
</td></tr></table>
</cfmail>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: x-small;
	color: #CCCCCC;
}
body {
	background-color: #333333;
	margin-left: 100px;
	margin-top: 100px;
	margin-right: 100px;
	margin-bottom: 100px;
}
a:link {
	color: #FFCC33;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #FFCC33;
}
a:hover {
	text-decoration: underline;
	color: #00FF33;
}
a:active {
	text-decoration: none;
	color: #00FF33;
}
-->
</style></head>

<body>
<p><img src="images/opusLogo06.jpg" width="236" height="47" /></p>
<p> &nbsp;<br />
<p>Thank you for notifying us about the error you encountered. Our technicians will work to fix the problem swiftly.</p>
<p><a href="http://www.downtown304.com" target="_top">Click here to return to the site</a></p>
</body>
</html>