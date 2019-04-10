<cfquery name="fixNRTP" datasource="#DSN#">
	update orders
    set readyToPrint=1
</cfquery>