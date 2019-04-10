<cfquery name="clearSpecial" datasource="#DSN#">
	update catItems
    set specialItem=0
</cfquery>