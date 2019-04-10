<cfquery name="fixPriceSave" datasource="#DSN#">
	update catItems
    set priceSave=0
    where priceSave=price
</cfquery>
<cfquery name="fixMetroSale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=5.99, wholeSalePrice=3.99, cost=2.50
    where vendorID=5650 AND albumStatusID<25 AND ONHAND>0 AND shelfID=11 AND NRECSINSET=1
</cfquery>
<cfquery name="fixMetroSale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=8.99, wholeSalePrice=5.99, cost=5.00
    where vendorID=5650 AND albumStatusID<25 AND ONHAND>0 AND shelfID=11 AND NRECSINSET=2
</cfquery>