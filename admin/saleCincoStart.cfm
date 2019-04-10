<!---START SALE - DO NOT RUN MORE THAN ONCE!!
<cfquery name="clearpricesave" datasource="#DSN#">
	update catItems
    set priceSave=0
</cfquery>
<cfquery name="setSale" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0, 1, 0, 0)#">
    update catItems
    set priceSave=price, price=5
    where (shelfID<>11 AND countryID<>1) AND ((albumStatusID<25 AND ONHAND>0 AND price>5.00 AND price<9.00) OR (ONHAND>3 AND releaseDate<'2011-01-01'))
</cfquery>//--->
<!--- END //--->
<cfquery name="resetpricesave" datasource="#DSN#">
	update catItems
    set price=priceSave
    where priceSave>0
</cfquery>
<cfquery name="cincosale" datasource="#DSN#">
	update catItems
    set cost=dtBuy, price=dtBuy*1.5
	where shelfID=11 AND albumStatusID<25 AND ONHAND>0 AND ((dtBuy<2.51 AND mediaID IN (1,11)) OR (vendorID IN (6897,63190) AND mediaID IN (1,11)) OR (vendorID IN (4071,5320,6623,5786,6243)))
</cfquery>