<cfquery name="fixkeywords" datasource="#DSN#">
	update catItems
	set keywords=LTRIM(RTRIM(keywords))
</cfquery>