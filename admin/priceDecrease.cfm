<style>body {font-family:Arial, Helvetica, sans-serif; font-size: xx-small;}
</style>
<cfquery name="priceAdjust" datasource="#DSN#">
	select *
    from catItemsQuery
    where ((albumStatusID<25 AND ONSIDE>0) OR ONSIDE>0) AND ONSIDE<>999 AND left(shelfCode,1)='D'
    AND price>(cost+2) AND NRECSINSET=1
</cfquery>
<cfoutput query="priceAdjust">
#DollarFormat(price)# - #DollarFormat(cost)# - #DollarFormat(cost+2)# - #catnum# - #label# - #artist# #title#<br />
</cfoutput>
<cfquery name="doPriceAdjust" datasource="#DSN#">
	update catItems
    set price=cost+2 where ID IN (select ID
    from catItemsQuery
    where ((albumStatusID<25 AND ONSIDE>0) OR ONSIDE>0) AND ONSIDE<>999 AND left(shelfCode,1)='D'
    AND price>(cost+2) AND NRECSINSET=1)
</cfquery>
