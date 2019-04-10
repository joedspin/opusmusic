<cfquery name="kirkc" datasource="#DSN#">
	update orderItems
    set priceOverride=price where orderID=37220
</cfquery>