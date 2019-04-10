<cfquery name="fixShippedFlag" datasource="#DSN#">
	update orderItems
    set shipped=1 where adminAvailID=6
</cfquery>