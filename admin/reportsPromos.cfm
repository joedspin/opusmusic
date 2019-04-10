<cfquery name="promos" datasource="#DSN#">
	select *
	from catItemsQuery
	where title LIKE '%(Promo)%' AND (ONHAND>0 OR ONSIDE>0)
	order by catnum
</cfquery>
<table>
<cfoutput query="promos">
	<tr>
		<td>#catnum#</td>
		<td>#label#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td>#DollarFormat(price)#</td>
		<td>#ONHAND#/#ONSIDE#</td>
	</tr>
</cfoutput>
</table>