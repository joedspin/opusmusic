<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<cfquery name="countries" datasource="#DSN#">
	select *
	from countries
	order by name
</cfquery>
<h1>Orders</h1>
<cfquery name="custOrders" datasource="#DSN#">
	select *, orders.ID As orderID
	from orders LEFT JOIN orderStatus ON orders.statusID=orderStatus.ID
	where orders.ID>45500
	order by orders.ID
</cfquery>
<cfif custOrders.RecordCount EQ 0>
	<p><font color="gray">No orders</font></p>
<cfelse>
		<cfoutput query="custOrders">
			<cfquery name="thisItems" datasource="#DSN#">
				SELECT *
				FROM orderItemsQuery
				where orderID=#ID#
			</cfquery>
			<cfif thisItems.recordCount GT 0>
				<cfquery name="thisShipAddress" datasource="#DSN#">
					select *
					from custAddressesQuery
					where ID=#shipAddressID#
				</cfquery>
			<table cellpadding="2" border="1" style="border-collapse:collapse; margin-top: 15px;" width="1000">
            <tr>
            <td colspan="3">#orderID#</td>
            </tr>
					<tr>
						<td valign="top" width="60" align="center"><cfif statusID EQ 1><a href="ordersDelete.cfm?ID=#custOrders.ID#">DELETE</a></cfif><br />
						#statusName#</td>
						<td valign="top" width="100">
						<b>Started</b><br />
						#DateFormat(dateStarted,"mm/dd/yy")#<cfif datePurchased NEQ ""><br />
						<b>Checked Out</b><br />
						#DateFormat(datePurchased,"mm/dd/yy")#</cfif><cfif dateShipped NEQ ""><br />
						<b>Complete</b><br />
						#DateFormat(dateShipped,"mm/dd/yy")#</cfif>
						</td>
						<td valign="top" width="840"><cfloop query="thisShipAddress">#thisShipAddress.firstName# #thisShipAddress.lastName#<br />
						#add1#<br />
						<cfif add2 NEQ "">#add2#<br /></cfif>
						<cfif add3 NEQ "">#add3#<br /></cfif>
						#city#, #state##stateprov# #postcode#<br />
						#country#</cfloop></td>
						</tr>
				<cfloop query="thisItems">
				<tr><td nowrap align="right">#DollarFormat(Price)#&nbsp;&nbsp;</td>
				<td nowrap><cfquery name="itemStat" datasource="#DSN#">
					select *
					from orderItemStatus
					where ID=#adminAvailID#
				</cfquery>#itemStat.name#</td>
				<td valign="top">
					#qtyOrdered# X #artist# / #title# [#label#] [#catnum##shelfCode#]</td>
					
		</tr></cfloop>
		<tr>
		<td colspan="3">
		<cfquery name="thisShipName" datasource="#DSN#">
			select *
			from shippingRates
			where ID=#shipID#
		</cfquery>Shipping Method: #thisShipName.name#</td></tr>
		<tr>
		<td colspan="3">Subtotal: #DollarFormat(orderSub)#<br />
		Shipping: #DollarFormat(orderShipping)#<br />
		Tax: #DollarFormat(orderTax)#<br />
		<b>Total: #DollarFormat(orderTotal)#</b></td>
		</tr>
		</table>
		</cfif>
		</cfoutput>
</cfif>
<cfinclude template="pageFoot.cfm">