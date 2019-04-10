<cfquery name="allLabels" datasource="#DSN#">
	SELECT DISTINCT labels.ID, labels.sort, labels.name, Left([shelfCode],1) AS shelfCodeLetter
	FROM labels INNER JOIN catItemsQuery ON labels.ID = catItemsQuery.labelID
	WHERE (((Left([shelfCode],1))='D')) AND catItems.active=yes AND ONHAND>0
	ORDER BY labels.sort
</cfquery>
<style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #CCCCCC;
}
body {
	background-color: #333333;
	margin-left: 40px;
	margin-top: 30px;
}
a:link {
	color: #66FF00;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #66FF00;
}
a:hover {
	text-decoration: none;
	color: #FFCC00;
}
a:active {
	text-decoration: none;
	color: #66FF00;
}
-->
</style>
<cfset lastLetter="">
<p>Labels with No Images
<cfoutput query="allLabels">
	<cfif left(name,"1") NEQ lastLetter></p><p></cfif>
	<cfset lastLetter=left(name,"1")>
	<a href="opussitelayout07main.cfm?lf=#ID#&group=all">#name#</a><br>
</cfoutput></p>