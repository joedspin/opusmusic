<cfset searchString="(price>10.99 AND price<11.99) AND shelfID NOT IN (7,11,13)">
<cfquery name="whattofix" datasource="#DSN#">
	select *
    from catItemsQuery
    where #searchString# AND ONHAND>0
    order by price
</cfquery>
<table>
<cfoutput query="whattofix">
<tr><td>#shelfCode# #catnum#</td><td>#label#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td><td>#DollarFormat(price)#</td><td>#cost#</td><td>#buy#</td></tr>
</cfoutput>
</table>

<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
	set price=11.99
	where #searchString# AND ONHAND>0
</cfquery>
<!---<cfquery name="fixPrices" datasource="#DSN#">
	update catItems
    set price=price+.30
    where price>9.99 AND price<14.99
</cfquery>//--->