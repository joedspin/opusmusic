<cfquery name="salesSummary" datasource="#DSN#">
	select Sum(qtyOrdered) As NumSold, catnum
    from orderItemsQuery
    where shelfID=1059 AND statusID=6 AND adminAvailID=6 AND dateShipped>'2014-02-01'
    group by catnum
    order by catnum
</cfquery>
<table>
<cfoutput query="salesSummary">
<tr><td>#catnum#</td><td>#NumSold#</td></tr>
</cfoutput>
</table>