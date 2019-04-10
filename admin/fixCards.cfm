<cfquery name="fixCards" datasource="#DSN#">
	update userCards
    set accountID=4848
    where ID=9222
</cfquery>