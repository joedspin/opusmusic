<!---<cfquery name="sale999" datasource="#DSN#">
	update catItems
    set priceSave=price, price=9.99, wholesalePrice=7.99
    where shelfID<>11 AND albumStatusID<25 AND price>10.99 AND price<12 AND NRECSINSET=1 AND mediaID=1
</cfquery>
<cfquery name="sale899" datasource="#DSN#">
	update catItems
    set priceSave=price, price=8.99, wholesalePrice=6.99
    where shelfID<>11 AND albumStatusID<25 AND price>9.99 AND price<11 AND NRECSINSET=1 AND mediaID=1
</cfquery>
<cfquery name="sale99" datasource="#DSN#">
	update catItems
    set priceSave=price, price=0.99, wholesalePrice=0.99
    where shelfID=29
</cfquery>
<cfquery name="fixwhitelabel" datasource="#DSN#">
	update catItems
    set price=priceSave, cost=priceSave-3, wholesalePrice=priceSave-2 where labelID=796 AND shelfID<>11 AND price<priceSave
</cfquery>//--->