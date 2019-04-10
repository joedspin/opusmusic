<cfquery name="fixOOS" datasource="#DSN#">
	update catItems
    set albumStatusID=25 where albumStatusID=23 AND ONHAND=0
</cfquery>
<cfquery name="fixOOS" datasource="#DSN#">
	update catItems
    set ONHAND=0 where albumStatusID>24 AND shelfID IN (7,11,13) AND ONHAND<>0
</cfquery>
