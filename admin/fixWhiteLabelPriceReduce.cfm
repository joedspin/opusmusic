<cfquery name="reduceWhiteLabel" datasource="#DSN#">
	update catItems
    set wholesalePrice=wholesalePrice-1, cost=1
    where shelfID=11 AND labelID=796 AND ID NOT IN (21216,21217) AND albumStatusID<25 AND ONHAND>0
</cfquery>