<cfquery name="deletedShelf" datasource="#DSN#">
	delete
    from shelf
    where ID=2084
</cfquery>
<cfquery name="fixShelfAfterDelete" datasource="#DSN#">
    update catRcvd 
    set rcvdShelfID=24
    where rcvdShelfID=2084
</cfquery>
<cfquery name="fixShelfCatItems" datasource="#DSN#">
	update catItems
    set shelfID=24
    where shelfID=2084
</cfquery>