<cfquery name="clearanceSale" datasource="#DSN#">
	select *
    from catItemsQuery
    where releaseDate < '2012-06-15' AND ONHAND>2 AND albumstatusid<25 AND shelfID IN (42,15,22,16) AND price>cost order by catnum
</cfquery>
<cfoutput>#clearanceSale.recordCount# Items<br></cfoutput>
<cfoutput query="clearanceSale">
#catnum# #label# <b>#artist#</b> #title# #price#<br>
</cfoutput>
<cfquery name="checkSave" datasource="#DSN#">
	select *
    from catItems
    where priceSave<>0
</cfquery>
<cfoutput>#checkSave.recordCount# PRICES SAVED</cfoutput>
<cfquery name="clearanceSale" datasource="#DSN#">
	update  catItems
    set priceSave=price, price=cost, albumStatusID=24
    where releaseDate < '2012-06-15' AND ONHAND>2 AND albumstatusid<25 AND shelfID IN (42,15,22,16) AND price>cost
</cfquery>
<cfquery name="clearanceSale" datasource="#DSN#">
	update  catItems
    set priceSave=price, price=.99, albumStatusID=24
    where ONHAND>1 AND albumStatusID<25 AND shelfID=29
</cfquery>
<!---<cfquery name="fixWarehouseFind" datasource="#DSN#">
	select *
    from catItems
    where title LIKE '% \[Warehouse Find]%' ESCAPE '\'
</cfquery>
<cfoutput>#fixWarehouseFind.recordCount#</cfoutput>//--->