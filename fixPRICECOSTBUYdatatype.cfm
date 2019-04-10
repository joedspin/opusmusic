<cfsetting requesttimeout="900">
<cfquery name="allItems" datasource="#DSN#">
	select ID, price, cost, buy
    from catItems
</cfquery>
<cfloop query="allItems">
	<cfquery name="priceit" datasource="#DSN#">
    	update catItems
        set priceNEW=#NumberFormat(price,"0000.00")#, costNEW=#NumberFormat(cost,"0000.00")#, buyNEW=#NumberFormat(buy,"0000.00")#
        where ID=#ID#
    </cfquery>
</cfloop>