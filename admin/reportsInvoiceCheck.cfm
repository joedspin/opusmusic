<cfquery name="thisItems" datasource="#DSN#">
	SELECT DISTINCT catnum, Sum(qtyOrdered) As totalOrdered, orderItemID, dateShipped
	FROM orderItemsQuery
	where dateShipped>'2011-09-01' AND adminAvailID=6 AND shelfID=11 AND statusID=6 AND dt161invoiceConfirm=0
    GROUP BY catnum, orderItemID, dateShipped  order by catnum
</cfquery>
<table>
<cfoutput query="thisItems">
<tr><td>#catnum#</td><td>#totalOrdered#</td><td>#DateFormat(dateShipped,"yyyy-mm-dd")#</td></tr>
</cfoutput>
</table>
