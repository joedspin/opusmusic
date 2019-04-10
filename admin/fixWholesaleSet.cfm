<!---<cfquery name="setWholesale" datasource="#DSN#">
	update catItems
    set wholesalePrice=cost+1.00+((NRECSINSET-1)*1)
    where shelfID<>11 AND cost<price
</cfquery>
<cfquery name="setWholesale" datasource="#DSN#">
	update catItems
    set wholesalePrice=price 
    where shelfID<>11 AND cost>=price OR wholesalePrice>price
</cfquery>
<cfquery name="setWholesale" datasource="#DSN#">
	update catItems
    set wholesalePrice=cost+1+((NRECSINSET-1)*1)
    where shelfID=11
</cfquery>
//--->