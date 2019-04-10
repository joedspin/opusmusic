<cfquery name="oohlala" datasource="#DSN#">
	update catItems
    set priceSave=price, price=price*.5
    where albumStatusID<25 AND ONHAND>0 AND countryID=5

</cfquery>