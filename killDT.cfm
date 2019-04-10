<cfquery name="killDT" datasource="#DSN#">
	update catItems
	set albumStatusID=25, ONHAND=0, ONSIDE=0 where albumStatusID<25 AND shelfID=11
</cfquery>