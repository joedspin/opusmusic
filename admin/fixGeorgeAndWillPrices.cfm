<cfquery name="upthegeorge" datasource="#DSN#">
	update catItemsQuery
    set price=9.49 where price<9.49 AND shelfID IN (1059,1064,2080) and albumStatusID<25 AND ONHAND>0
</cfquery>