<cfquery name="restoreprices" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=0 where priceSave>0
</cfquery>
<cfquery name="clearSpecial" datasource="#DSN#">
	update catItems
    set specialItem=0
</cfquery>
<cfquery name="setprices" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost+1.00, specialItem=1 where price>cost+1.0 AND (((ONHAND>0 AND albumStatusID<25) OR ONSIDE >0 OR (albumStatusID=26 AND ONHAND>0)) AND ONSIDE<>999 and (vendorID<>5650 OR labelID=3895 OR ID IN (38517,38993,39293,41223,41917,41938,42305,48537,51111,53295)) AND ID NOT IN (select catItemID from orderItemsQuery where statusID=6))
</cfquery>
<cfquery name="importsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost, specialItem=1 where price>cost AND releaseDate<<cfqueryparam cfsqltype="cf_sql_date" value="2011-06-01"> AND shelfID<>11 AND ONHAND>0 AND albumStatusID<25
</cfquery>
<cfquery name="saleidea" datasource="#DSN#">
	select *
    from catItemsQuery where specialItem=1
    order by label, catnum
</cfquery>
<cfoutput><p>#saleidea.recordCount#</p></cfoutput>
<cfoutput query="saleidea">
#catnum# #label# #artist# #title# <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media# #price# (#pricesave#) #cost#<br>
</cfoutput>
