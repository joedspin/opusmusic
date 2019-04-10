<cfparam name="url.ID" default="0">
<cfquery name="updateOrder" datasource="#DSN#">
	update orders
	set statusID=1, datePurchased='', oFlag2=0, pickupReady=0, picklistPrinted=0, readytoPrint=1, issueRaised=0, issueResolved=0
	where ID=#url.ID#
</cfquery>
<cfquery name="updateItems" datasource="#DSN#">
	update orderItems
	set adminAvailID=2
	where orderID=#url.ID#
</cfquery>
<cfmail to="order@downtown304.com" from="info@downtown304.com" subject="CART RESET: Order ###url.ID#">
The cart was reset for Order ###url.ID#.

When the customer resubmits his order, it will look like a new order. Be sure to recheck every item on the new order against what was previously picked.
</cfmail>
<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<cfoutput>Order Num #url.ID#: Cart Reset complete.</cfoutput>
<cfinclude template="pageFoot.cfm">