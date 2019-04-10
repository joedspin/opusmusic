<!---<cfquery name="undoSale" datasource="#DSN#">
	update catItems
    set price=priceSave where priceSave>0 AND priceSave>price
</cfquery>
<cfquery name="undoSale" datasource="#DSN#">
	update catItems
    set cost=costSave where costSave>0 AND shelfID=11
</cfquery>//--->
<cfquery name="undoSale" datasource="#DSN#">
	update catItems
    set cost=costSave, costSave=0 where shelfID=11 AND costSave>0
</cfquery>