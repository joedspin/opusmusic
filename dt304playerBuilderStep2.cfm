<cfparam name="form.playerType" default="">
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
<div align="center">
<a href="opusviewlists.cfm"><img src="new/images/pageHead.jpg" alt="Home" width="800" height="140" border="0" /></a>
<cfswitch expression="#form.playerType#">
	<cfcase value="artistID">
		<cfquery name="pChoices" datasource="#DSN#">
			select ID, name
			from artists
			order by sort
		</cfquery>
	</cfcase>
	<cfcase value="labelID">
		<cfquery name="pChoices" datasource="#DSN#">
			select ID, name
			from labels
			order by sort
		</cfquery>
	</cfcase>
	<cfcase value="chartID">
		<cfquery name="pChoices" datasource="#DSN#">
			select ID, artist + ' - ' + listName As name
			from artistListsQuery where artistID<>15387 AND active=1
			order by artistSort ASC, listDate DESC
		</cfquery>
	</cfcase>
	<cfdefaultcase>
		Nothing Found <cfabort>
	</cfdefaultcase>
</cfswitch>
<cfform name="selectList" action="dt304playerBuilderStep3.cfm" method="post">
	Choose one: <cfselect query="pChoices" name="choiceID" display="name" value="ID"></cfselect>
	<input type="submit" name="submit" value="Next --&gt;" />
	<cfoutput><input type="hidden" name="playerType" value="#form.playerType#" /></cfoutput>
</cfform>
</body>
</html>
