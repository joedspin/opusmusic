<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304 .:. Player Builder</title>
<style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #CCCCCC;
}
body {
	background-color: #6A7F92;
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 20px;
}
-->
</style></head>

<body>
<div align="center"><a href="opusviewlists.cfm"><img src="new/images/pageHead.jpg" alt="Home" width="800" height="140" border="0" /></a>
<form name="pBuilder" action="dt304playerBuilderStep2.cfm" method="post">
  Choose the type of player:
    <select name="playerType">
      <option value="artistID">Artist</option>
      <option value="labelID">Label</option>
      <option value="chartID">Chart</option>
    </select>
    <input type="submit" name="submit" value="Next --&gt;" />
</form>
</div>
</body>
</html>
