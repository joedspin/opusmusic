<cfparam name="form.playerType" default="">
<cfparam name="form.choiceID" default="0">
<cfset listName="#form.playerType#=#form.choiceID#">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304 .:. Player Builder</title>
<style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: x-small;
	color: #CCCCCC;
}
body {
	background-color: #6A7F92;
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 20px;
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
	color: #FFFFFF;
}
a:active {
	text-decoration: none;
	color: #FFFFFF;
}
-->
</style></head>

<body>
<div align="center"><a href="opusviewlists.cfm"><img src="new/images/pageHead.jpg" alt="Home" width="800" height="140" border="0" /></a></div>
<form action="#" method="post">
	<p align="center">
  <textarea cols="110" rows="8" name="playerCode" style="font-size: x-small;"><cfinclude template="player/dt304playerCode.cfm"><br />
	  </textarea>
      <br />
      <!---<input type="submit" name="submity" value="Send" />//--->
      Copy and paste the entire block of code above into your web page or myspace page to include the player there.
  </p>
</form>
<!---<cfoutput><p align="center">Preview Link: <a href="http://www.downtown304.com/player/dt304Player.cfm?#listName#">http://www.downtown304.com/player/dt304player.cfm?#listName#</a></p></cfoutput>//--->

<cfinclude template="player/dt304playerCode.cfm">
</body>
</html>
