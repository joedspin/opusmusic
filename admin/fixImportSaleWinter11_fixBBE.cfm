<cfquery name="ONsale" datasource="#DSN#">
	update catItems
    set price=priceSave
    where shelfID=27 and labelID IN (273,1541,8100,1274,2405)
</cfquery>