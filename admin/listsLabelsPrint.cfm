<cfquery name="letterList" datasource="#DSN#">
	select DISTINCT Left(sort,1) As labelLetter
	FROM labels INNER JOIN catItemsQuery ON labels.ID = catItemsQuery.labelID
	WHERE (((Left([shelfCode],1))='D'))
	order by Left(sort,1)
</cfquery><style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #000000;
}
body {
	background-color: #FFFFFF;
}
-->
</style>
<cfloop query="letterList">
<cfquery name="allLabels" datasource="#DSN#">
	SELECT DISTINCT labels.ID, labels.sort, labels.name, Left([shelfCode],1) AS shelfCodeLetter
	FROM labels INNER JOIN catItemsQuery ON labels.ID = catItemsQuery.labelID
	WHERE Left(sort,1)='#letterList.labelLetter#' AND albumStatusID<25 AND ONHAND>0
	ORDER BY labels.sort
</cfquery>
<cfif allLabels.RecordCount GT 0>
	<h1><cfif labelLetter NEQ ""><cfoutput>#UCase(labelLetter)#</cfoutput><cfelse>[no sort]</cfif></h1>
	<p><cfoutput query="allLabels">
		#name#<br>
	</cfoutput></p>
</cfif>
</cfloop>