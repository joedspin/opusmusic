<cfquery name="catItems" datasource="#DSN#">
	update catItems
	set albumStatusID=20
	where albumStatusID=0
</cfquery>
<cfquery name="catItems" datasource="#DSN#">
	update catItems
	set albumStatusID=25
	where albumStatusID<25 AND ONHAND<1
</cfquery>