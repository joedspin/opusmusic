<cfquery name="fix7" datasource="#DSN#">
	update catItems
    set cost=cost-.6 where mediaID=11 AND shelfID NOT IN (7,11)
</cfquery>
<cfquery name="fix7" datasource="#DSN#">
	update catItems
    set price=cost+1.00
    where price>cost+1.00 AND mediaID=11 AND NRECSINSET=1
</cfquery>
<cfquery name="fix7" datasource="#DSN#">
	update catItems
    set price=cost+2.00
    where price>cost+2.00 AND mediaID=11 AND NRECSINSET=2
</cfquery>
<cfquery name="fix7" datasource="#DSN#">
	update catItems
    set price=5.99 where
    price=6.09 AND mediaID=7
</cfquery>
<cfquery name="get7" datasource="#DSN#">
	select *
    from catItemsQuery
    where mediaID=11 AND ((albumStatusID<25 AND ONHAND>0) OR ONSIDE>0) AND ONSIDE<>999
</cfquery>
<cfoutput query="get7">
#catnum# #label# #artist# #title# #DollarFormat(price)# #DollarFormat(cost)# <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#<BR>
</cfoutput>