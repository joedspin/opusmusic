<cfquery name="fixOutOfStock" datasource="#DSN#">
	update catItems
    set albumStatusID=25
    where albumStatusID<25 AND shelfID<>11 AND ONHAND<1
</cfquery>
<cfquery name="backtoreg" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID=23 AND DateDiff(day,releaseDate,#varDateODBC#)>60 AND DateDiff(day,dtDateUpdated,#varDateODBC#)>60 AND shelfID<>11
</cfquery>
<cfoutput query="backtoreg">
#catnum# #artist# #title# #releaseDate# #dtDateUpdated#<br />
</cfoutput>
<cfquery name="backtoregDo" datasource="#DSN#">
	update catItems
    set albumStatusID=24, dtDateUpdated=releaseDate
    where albumStatusID=23 AND DateDiff(day,releaseDate,#varDateODBC#)>60 AND DateDiff(day,dtDateUpdated,#varDateODBC#)>60
</cfquery>
<cflocation url="catalog.cfm?backtoreg=#backtoreg.recordCount#"><!---//--->