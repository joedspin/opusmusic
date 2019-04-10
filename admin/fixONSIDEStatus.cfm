<cfquery name="fixONSIDEStatus" datasource="#DSN#">
	update catItems
	set albumStatusID=24
	where albumStatusID>24 AND ONSIDE>0
</cfquery>
