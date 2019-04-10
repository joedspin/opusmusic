<cfquery name="fix567" datasource="#DSN#">
	update catItems
    set wholesalePrice=5.29 where wholesalePrice=5.67 AND vendorID=5650
</cfquery>