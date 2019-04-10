<cfquery name="priceErrors" datasource="#DSN#">
	update catItems
    set price=cost+2.20
    where price<cost+1.9 AND shelfID IN (7,11,13) AND NRECSINSET=1
</cfquery>
<cfquery name="priceErrors" datasource="#DSN#">
	update catItems
    set price=cost*1.5
    where price<cost+1.9 AND shelfID IN (7,11,13) AND NRECSINSET>1
</cfquery>
<cfquery name="priceErrors" datasource="#DSN#">
	update catItems
    set cost=buy
    where cost>buy AND buy<>0 AND shelfID IN (7,11,13)
</cfquery>
<style>
body, td {font-family:Arial, Helvetica, sans-serif; font-size: xx-small;}
</style>
<cfquery name="priceErrors" datasource="#DSN#">
	select *
    from catItemsQuery
    where price<cost+1.9 AND  ONSIDE<>999 AND shelfID IN (7,11,13) AND NOT (price=0 AND cost=0)
</cfquery>
<h1>Price less than $1.90 above cost</h1>
<h2>Showing PRICE and COST</h2>
<table border="1" cellpadding="3" cellspacing="0">
<cfoutput query="priceErrors">
<tr><td>#DollarFormat(price)#</td><td>#DollarFormat(cost)#</td><td>#catnum#</td><td>#label#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td></tr>
</cfoutput>
</table>

<cfquery name="priceErrors" datasource="#DSN#">
	select *
    from catItemsQuery
    where cost>buy AND buy<>0 AND ONSIDE<>999 AND shelfID IN (7,11,13)
</cfquery>
<h1>Cost greater than 161 Sell</h1>
<h2>Showing COST and DT 161 SELL</h2>
<table border="1" cellpadding="3" cellspacing="0">
<cfoutput query="priceErrors">
<tr><td>#DollarFormat(cost)#</td><td>#DollarFormat(buy)#</td><td>#catnum#</td><td>#label#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td></tr>
</cfoutput>
</table>