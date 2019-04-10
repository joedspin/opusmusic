<cfquery name="fixemergency" datasource="#DSN#">
	update catItems
    set price=priceSave
    where priceSave>0
</cfquery>
<cfquery name="fixemergency" datasource="#DSN#">
	update catItems
    set cost=costSave
    where costSave>0
</cfquery>