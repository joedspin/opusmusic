<cfquery name="warehouseclearance" datasource="#DSN#">
	update catItems
    set price=priceSave, cost=costSave, dtOLDID=0, priceSave=0, costSave=0
    where priceSave>0
</cfquery>
