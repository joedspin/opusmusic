<style>
body {font-family:Arial, Helvetica, sans-serif;}
</style>
<cfquery name="topSellers" datasource="#DSN#" maxrows="200">
	SELECT DISTINCT catItemsQuery.labelID, Sum(orderItems.qtyOrdered) AS SumOfQuantity, catItemsQuery.label AS label, logofile
	FROM (((orderItems LEFT JOIN orders ON orderItems.orderID=orders.ID) LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID) LEFT JOIN catItems ON catItems.ID=catItemsQuery.ID)
	where ((catItemsQuery.ONHAND>0 and catItemsQuery.albumStatusID<25)or catItemsQuery.ONSIDE>0) AND orderItems.adminAvailID=6 AND DateDiff(day,orders.dateUpdated,#varDateODBC#)<181 AND orders.custID<>445 AND Left(catItemsQuery.shelfCode,1)='D' AND catItemsQuery.labelID<>796
	GROUP BY catItemsQuery.labelID, catItemsQuery.label, logofile
	ORDER BY Sum(orderItems.qtyOrdered) DESC
</cfquery>
<cfoutput query="topSellers">
<img src="../images/labels/#logofile#"> #label# - #SumOfQuantity#<br />
</cfoutput>