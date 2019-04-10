<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Prerelease Not Received</title>
</head>
<cfquery name="prereleasenotreceived" datasource="#DSN#">
	select *
	from catItemsQuery where albumStatusID=148 and ONHAND>0
	</cfquery>
<body>
	<cfoutput query="prereleasenotreceived">
		<a href="catalogEdit.cfm?ID=#ID#" target="prereleasefix">#catnum#</a> - #label# - #artist# - #title# - <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#<br>
	</cfoutput>
</body>
</html>
