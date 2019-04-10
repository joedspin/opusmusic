<cfquery name="whattofix" datasource="#DSN#">
	select *
    from catItemsQuery
    where NRECSINSET=1 AND vendorID=5650 AND mediaID=1 AND cost=4.90
    order by label, artist, title
    </cfquery>
<table>
<cfoutput query="whattofix">
<tr><td>#catnum#</td><td>#label#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td><td>#DollarFormat(price)#</td><td>#cost#</td><td>#buy#</td></tr>
</cfoutput>
</table>
<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
	set price=8.99, cost=5.05, buy=5.99, dtBuy=4.05
	where NRECSINSET=1 AND vendorID=5650 AND mediaID=1 AND cost=4.90
</cfquery>
<cfabort>
<!---<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
    set price=price+.30
    where price>9.99 AND price<14.99
</cfquery>//--->