



<cfparam name="url.ID" default="0">
<cfparam name="url.priceup" default="0">
<!--<cfquery name="fixGT" datasource="#DSN#">
	update catItems
    set price=5.99
    where price=0 AND shelfID IN (5650)
</cfquery>//-->
<cfif url.ID NEQ 0 AND url.priceup NEQ 0>
<cfquery name="fixPrice" datasource="#DSN#">
	update catItems
    set price=cost+#url.priceup#
    where ID=#url.ID#
</cfquery>
</cfif>
<cfquery name="zeroPrices" datasource="#DSN#">
	select *
    from catItemsQuery
    where price=0 AND cost<>0 AND albumStatusID=148
    order by realReleaseDate DESC
</cfquery>
<cfset itemCounter=0>
<table>
<cfoutput query="zeroPrices">
<cfset itemCounter=itemCounter+1>
<tr>
<td>#itemCounter#</td>
<td><a href="catalogEdit.cfm?ID=#ID#" target="catedit">#catnum#</td>
<td>#label#</td>
<td>#artist#</td>
<td>#title#</td>
<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
<td>#DollarFormat(price)#</td>
<td>#DollarFormat(cost)#</td>
<td><a href="fixPriceZero.cfm?ID=#ID#&priceup=3">+3</a></td>
<td><a href="fixPriceZero.cfm?ID=#ID#&priceup=2.7">+2.70</a></td>
<td>#ONHAND#</td>
</tr>
</cfoutput>
</table>