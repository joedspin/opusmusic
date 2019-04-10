<cfquery name="oops" datasource="#DSN#">
	update catItems
    set price=cost+3 where price<cost+1 AND countryID<>5
</cfquery>
<cfinclude template="../catalogLoadPrices.cfm">
<cfquery name="fixFrance" datasource="#DSN#">
	update catItems
    set price=price-1, priceSave=price
    where price<=cost AND countryID=5
</cfquery>
<cfquery name="fixFrance" datasource="#DSN#">
	update catItems
    set price=cost-1, priceSave=price
    where price>cost AND countryID=5
</cfquery>
<cfquery name="franceSale2012" datasource="#DSN#">
	select *
    from catItemsQuery
	where countryID=5
    order by label, artist
</cfquery>
<cfset count12=1>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="franceSale2012">
<tr>
	<td>#count12#</td>
	<td>#DollarFormat(cost)#</td>
	<td>#DollarFormat(price)#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
</tr>
<cfset count12=count12+1>
</cfoutput>

</table>