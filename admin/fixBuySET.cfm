<cfquery name="setBuy" datasource="#DSN#">
	update catItems
    set buy=cost
</cfquery>