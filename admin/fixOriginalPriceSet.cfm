<cfquery name="setOriginalPrice" datasource="#DSN#">
	update catItems
    set originalPrice=priceSave where priceSave>0 AND albumStatusID<25 AND ONHAND>0
</cfquery>
<cfquery name="setOriginalPrice" datasource="#DSN#">
	update catItems
    set originalPrice=price where priceSave=0 AND albumStatusID<25 AND ONHAND>0
</cfquery>
<cfquery name="setOriginalPrice" datasource="#DSN#">
	update catItems
	set originalPrice=cost+3 where originalPrice<cost AND albumStatusID<25 AND ONHAND>0
</cfquery>