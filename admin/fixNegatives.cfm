<cfquery name="fixNegatives" datasource="#DSN#">
	update catItems
    set ONHAND=0 where ONHAND<0
</cfquery>