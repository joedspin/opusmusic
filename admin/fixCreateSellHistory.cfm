<cfquery name="createSellHist" datasource="#DSN#">
    SELECT qtyOrdered, catItemID, orderID, dateShipped
    
    FROM orderItemsQuery
    where adminAvailID=6
</cfquery>