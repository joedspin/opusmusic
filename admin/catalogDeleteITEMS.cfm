<cfquery name="killItems" datasource="#DSN#">
	delete *
	from catItems
	where mediaID Is Null OR mediaID=0
</cfquery>
Done.