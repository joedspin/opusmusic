<cfquery name="fixBSStatus" datasource="#DSN#">
	update catItems
	set albumStatusID=24 where shelfID=29
</cfquery>