<cfquery name="priceIncreaseFeb09" datasource="#DSN#">
	update catItems
    set price=price+.20
    where price>6.99 AND price<7.70
</cfquery>