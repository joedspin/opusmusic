<cfquery name="priceZeroes" datasource="#DSN#">
	select *
    from catItemsQuery
    where price=0 and ONHAND>0 AND albumStatusID<25
</cfquery>
<table><cfoutput query="priceZeroes">
<tr><td>#catnum#</td></tr>
</cfoutput>
</table>