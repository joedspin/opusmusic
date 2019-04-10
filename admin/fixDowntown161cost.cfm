<cfquery name="fixMetroDT" datasource="#DSN#">
	update catItems
    set cost=2 
    where cost>2 AND albumStatusID<25 AND ONHAND>0 AND shelfID=11 AND vendorID=5650 AND NRECSINSET=1
</cfquery>
<cfquery name="fixOtherDTHalf" datasource="#DSN#">
	update catItems
    set cost=wholesalePrice/2
    where cost>(wholesalePrice+.01)/2 AND albumStatusID<25 AND ONHAND>0 AND shelfID=11 
</cfquery>