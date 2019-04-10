<cfquery name="fixLowPrices" datasource="#DSN#">
	select * 
	from catItemsQuery
	where price<cost+2.49 AND ((albumStatusID<25 AND ONHAND>0 AND ONSIDE<>999) OR ONSIDE>0)
</cfquery>
<cfoutput query="fixLowPrices">
#catnum# #shelfCode# #label# #artist# #title#<br>
</cfoutput>
<cfquery name="fixLowPrices" datasource="#DSN#">
	update catItems
	set price=cost+2.49
	where price<cost+2.49 AND ((albumStatusID<25 AND ONHAND>0 AND ONSIDE<>999) OR ONSIDE>0) AND cost>0
</cfquery>
<cfquery name="fixcost249" datasource="#DSN#">
	update catItems
	set price=0 where cost=0 and price=2.49
</cfquery>