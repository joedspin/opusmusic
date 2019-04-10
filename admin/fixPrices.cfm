<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
	set dtBuy=3.90, buy=5.99 where mediaID=1 AND vendorID=5439
</cfquery>
<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
    set dtBuy=4.05, buy=5.99 where mediaID=1 AND vendorID=5650
</cfquery>