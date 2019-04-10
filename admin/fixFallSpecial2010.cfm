<cfquery name="fallsale" datasource="#DSN#">
	select *
    from catItemsQuery
    where NRECSINSET=1 AND ((PRICE>9.99 AND COST <9.00) OR PRICE<10) AND albumStatusID<>21 AND albumStatusID<>23 and shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND countryID<>1
    order by label, catnum
</cfquery>
<cfoutput>#fallsale.recordCount#<br /></cfoutput>
<cfoutput query="fallsale">
#catnum# #label# #artist# #title# #price#<br />
</cfoutput>
<cfquery name="fallsalesetprice" datasource="#DSN#">
	update catItems
    set priceSave=price, price=9.99 
    where NRECSINSET=1 AND PRICE>9.99 AND COST <9.00 AND albumStatusID<>21 AND albumStatusID<>23 and shelfID<>11 AND ONHAND>0 AND albumStatusID<25 AND countryID<>1
</cfquery>