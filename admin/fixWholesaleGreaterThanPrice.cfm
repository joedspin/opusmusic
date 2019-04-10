<cfquery name="fixWholesale" datasource="#DSN#">
	update catItems
	set wholesalePrice=price-1
	where wholesalePrice>=price AND ONHAND>0 AND albumStatusID<25
</cfquery>
<cfquery name="fixWholesalezero" datasource="#DSN#">
	update catItems
	set wholesalePrice=0.49
	where wholesalePrice<0 AND ONHAND>0 AND albumStatusID<25
</cfquery>
	