<cfquery name="allLabels" datasource="#DSN#">
	SELECT DISTINCT labels.ID, labels.sort, labels.name, Left([shelfCode],1) AS shelfCodeLetter, labels.logofile
	FROM labels INNER JOIN catItemsQuery ON labels.ID = catItemsQuery.labelID
	WHERE (((Left([shelfCode],1))='D')) AND catItems.active=yes AND ONHAND>0 AND labels.logofile=''
	ORDER BY labels.sort
</cfquery>
<cfset lastLetter="">
<style>
p {font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	}
	</style>
<p><b>Labels with No Images</b>
<cfoutput query="allLabels">
	<cfif left(name,"1") NEQ lastLetter></p><p></cfif>
	<cfset lastLetter=left(name,"1")>
	#name#<br>
</cfoutput></p>