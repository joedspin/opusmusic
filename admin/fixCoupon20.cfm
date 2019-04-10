<cfquery name="coupon20fix" datasource="#DSN#">
	select *
    from ((orderItems LEFT JOIN orders ON orderItems.orderID=orders.ID) LEFT JOIN custAccounts ON orders.custID=custAccounts.ID) where
    orders.specialInstructions LIKE '%20[%]%' AND catItemID=74648
    order by orderID
</cfquery>
<cfoutput query="coupon20fix">
	#catItemID# #firstName# #LastName# #orderID# #DateFormat(dateShipped,"mm-dd-yyyy")# [Order Sub: #DollarFormat(orderSub)#] [Discount given: #DollarFormat(price)#] [20% Discount: #DollarFormat(orderSub*.2)#] [Discount owed: #DollarFormat((orderSub*.2)+price)#] #paymentTypeID#<br>
</cfoutput>