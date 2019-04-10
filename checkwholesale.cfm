<cfquery name="fixWholesale" datasource="#DSN#">
	 update catItems	
    set wholesalePrice=cost+1.30
    where wholesalePrice<cost and albumStatusID<25 AND ONHAND>0 AND shelfID<>11
</cfquery>
<cfquery name="checkwholesale" datasource="#DSN#">
	select *
    from catItemsQuery
    where wholesalePrice<cost and albumStatusID<25 AND ONHAND>0
    order by catnum
</cfquery>
<cfoutput query="checkwholesale">
#catnum# #wholesalePrice#<br>
</cfoutput>

