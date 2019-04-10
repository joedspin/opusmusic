<cfquery name="fixCosts" datasource="#DSN#">
	update catItems
    set cost=<cfqueryparam value="7.99" cfsqltype="money">
    where cost<<cfqueryparam value="7.99" cfsqltype="money"> AND shelfID IN (22,16,21)
</cfquery>
<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
    set price=cost+2.50
    where shelfID IN (22,16,21)
</cfquery>