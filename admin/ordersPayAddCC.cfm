<cfparam name="url.ID" default="0">
<cfparam name="url.orderTotal" default="0">
<cfquery name="removeExistingFeeIfAny" datasource="#DSN#">
	delete 
    from orderItems
    where catItemID=71972 AND orderID=#url.ID#
</cfquery>
<cfquery name="addCCFee" datasource="#DSN#">
	insert into orderItemsQuery (orderID,catItemID,qtyOrdered,price,priceOverride,adminAvailID)
    values (#url.ID#,71972,1,#NumberFormat(url.orderTotal*.03,"0.00")#,0,4)
</cfquery>
<cflocation url="ordersPay.cfm?ID=#url.ID#">