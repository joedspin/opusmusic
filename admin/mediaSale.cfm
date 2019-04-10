<style>td {font-family: Arial, Helvetica, sans-serif; font-size: 9px;}
</style>
<cfquery name="mediasale" datasource="#DSN#">
	select *
    from catItemsQuery
    where ONHAND>1 AND albumStatusID<25 AND mediaID IN (2,3,9,11) AND albumStatusID<>21 AND shelfID=11 AND vendorID<>7561 AND labelID NOT IN (6131,2538,3911,4014,7839,8537,8515,8889,1641,8171,1777)
    order by mediaID DESC, label, catnum
</cfquery>
<table border="1" bordercolor="black" style="border-collapse:collapse;">
<tr>
	<td>MEDIA</td>
    <td>LABEL</td>
    <td>CATNUM</td>
    <td>ARTIST</td>
    <td>TITLE</td>
    <td>DT304 SELL</td>
    <td>DT304 BUY</td>
    <td>DT161 SELL</td>
    <td>DT161 BUY</td>
</tr>
<cfoutput query="mediasale">
<tr>
	<td>#media#</td>
    <td>#UCase(label)#</td>
    <td>#UCase(catnum)#</td>
    <td>#UCase(artist)#</td>
    <td>#UCase(title)#</td>
    <td><cfif price NEQ 0>#DollarFormat(price)#</cfif></td>
    <td><cfif cost NEQ 0>#DollarFormat(cost)#</cfif></td>
    <td><cfif buy NEQ 0>#DollarFormat(buy)#</cfif></td>
    <td><cfif dtBuy NEQ 0>#DollarFormat(dtBuy)#</cfif></td>
</tr>
</cfoutput>
</table>