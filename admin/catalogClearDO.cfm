<cfquery name="clearDO" datasource="#DSN#">
	update catItems
    set ONHAND=0, ONSIDE=0, albumStatusID=44
    where shelfID=3
</cfquery>	
