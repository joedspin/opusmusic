<!---<cfquery name="fixPriceSave" datasource="#DSN#">
	update catItems
    set priceSave=0, costSave=0
    where blue99=0
</cfquery>
<cfquery name="fixPriceSave" datasource="#DSN#">
	update catItems
    set specialItem=0
</cfquery>
<cfquery name="dosalefixer" datasource="#DSN#">
	update catItems
    set cost=price/2
    where cost>price/2 AND shelfID=11 AND costSave<>0
</cfquery>
<cfquery name="dosaleflagItems" datasource="#DSN#">
	update catItems
    set specialItem=1
    where blue99=0 AND priceSave>0
</cfquery>
<h1>Imports</h1>
<cfquery name="dosale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=price/2, specialItem=1
     where albumStatusID NOT IN (21,23) AND albumStatusID<25 AND ONHAND>0 AND shelfID<>11 AND countryID<>1 AND priceSave=0 AND specialItem=0
</cfquery>
<cfquery name="saleprospects" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID IN (22,24) AND ONHAND>0 AND shelfID<>11 AND countryID<>1 AND blue99=0 AND specialItem=1
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<h1>Domestics 304</h1>
<cfquery name="dosale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=price/2, specialItem=1
    where albumStatusID IN (22,24) AND ONHAND>0 AND shelfID<>11 AND countryID=1 AND blue99=0 AND priceSave=0 AND specialItem=0
</cfquery>
<cfquery name="saleprospects" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID IN (22,24) AND ONHAND>0 AND shelfID<>11 AND countryID=1 AND blue99=0 AND specialItem=1
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<h1>Domestics 161</h1>
<cfquery name="dosale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=price/2, costSave=cost, cost=cost/2, specialItem=1
    where albumStatusID IN (22,24) AND ONHAND>0 AND shelfID=11 AND NRECSINSET<4 AND blue99=0 AND price>4.98 AND labelID NOT IN (1586) AND ID NOT IN (67360,42800) AND priceSave=0 AND specialItem=0
</cfquery>
<cfquery name="saleprospects" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID IN (22,24) AND ONHAND>0 AND shelfID=11 AND NRECSINSET<4 AND blue99=0 AND priceSave>4.98 AND specialItem=1
    order by artist, label, catnum 
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">

<cfquery name="undoFallWarehouseSale" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=0
    where specialItem=1 AND blue99=0 AND priceSave>0
</cfquery>
<cfquery name="undoFallWarehouseSale" datasource="#DSN#">
	update catItems
    set cost=costSave, costSave=0
    where specialItem=1 AND blue99=0 AND costSave>0
</cfquery>
<cfquery name="undoFallWarehouseSale" datasource="#DSN#">
	update catItems
    set specialItem=0
    where specialItem=1 AND blue99=0 
</cfquery>//--->




<!---<cfquery name="clearSpecialItem" datasource="#DSN#">
	update catItems
    set specialItem=0
</cfquery>
<cfquery name="dothesale" datasource="#DSN#">
	update catItems
    set price=priceSave/2, priceSave=price, specialItem=1
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-10' AND ONHAND>0 AND blue99=1 AND specialItem=0
</cfquery>
<cfquery name="dothesale" datasource="#DSN#">
	update catItems
    set price=price/2, priceSave=price, specialItem=1
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-10' AND ONHAND>0 AND blue99=0
</cfquery>
 UNDO THE SALE
<cfquery name="dothesale" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=price*2, specialItem=0
    where specialItem=1 AND blue99=1
</cfquery>
<cfquery name="dothesale" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=0, specialItem=0
	where specialItem=1 AND blue99=0
</cfquery>


<p>New Releases 50% Off</p>
<cfquery name="saleProspects" datasource="#DSN#">
	select *
    from catItemsQuery 
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID=21 AND releaseDate<'2015-10-01' AND ONHAND>0 
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<p>12" Imports 50% Off</p>
<cfquery name="saleProspects" datasource="#DSN#">
	select *
    from catItemsQuery 
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-10' AND ONHAND>0 AND mediaID IN (1,12) AND countryID<>1
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<p>12" Domestics 50% Off</p>
<cfquery name="saleProspects" datasource="#DSN#">
	select *
    from catItemsQuery 
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-10' AND ONHAND>0 AND mediaID IN (1,12) AND countryID=1
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<p>7"s 50% Off</p>
<cfquery name="saleProspects" datasource="#DSN#">
	select *
    from catItemsQuery 
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-10' AND ONHAND>0 AND mediaID=11
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<p>CDs 50% Off</p>
<cfquery name="saleProspects" datasource="#DSN#">
	select *
    from catItemsQuery 
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-10' AND ONHAND>0 AND mediaID=2
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<p>10"s 50% Off</p>
<cfquery name="saleProspects" datasource="#DSN#">
	select *
    from catItemsQuery 
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-01' AND ONHAND>0 AND mediaID=9
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<p>LPs 50% Off</p>
<cfquery name="saleProspects" datasource="#DSN#">
	select *
    from catItemsQuery 
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-01' AND ONHAND>0 AND mediaID=5
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">
<p>Merch 50% Off</p>
<cfquery name="saleProspects" datasource="#DSN#">
	select *
    from catItemsQuery 
    where ID NOT IN (select catItemID from orderItemsQuery where dateShipped>'2015-02-20') AND albumStatusID<25 AND releaseDate<'2015-10-10' AND ONHAND>0 AND mediaID IN (19,20,22,23)
    order by artist, label, catnum
</cfquery>
<cfinclude template="fixResultsDisplayModule.cfm">//--->