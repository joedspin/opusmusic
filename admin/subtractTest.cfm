<cfquery name="marianne" datasource="#DSN#">
	update     catItems
    set ONHAND=ONHAND+1
    where ID=41980
</cfquery>
DONE.