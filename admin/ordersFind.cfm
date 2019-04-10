<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<cfparam name="form.ID" default="0">
<cfparam name="form.discogsID" default="0">
<cfparam name="form.lastName" default="">
<cfparam name="form.email" default="">
<cfparam name="form.username" default="">
<cfset sString="">
<cfset thisLastName="not provided">
<cfset thisEmail="not provided">
<cfset thisUsername="not provided">
<cfif form.ID NEQ ""><cfset sString="orders.ID=" & form.ID & " OR"></cfif>
<cfif form.lastName NEQ ""><cfset thisLastName=form.lastName></cfif>
<cfif form.email NEQ ""><cfset thisEmail=form.email></cfif>
<cfif form.username NEQ ""><cfset thisUsername=form.username></cfif>
<cfif form.discogsID NEQ "" AND IsNumeric(form.discogsID)>
    <cfquery name="thisOrder" datasource="#DSN#" maxrows="20">
        select *, [orders].[ID] As orderID
        from ((orders LEFT JOIN orderStatus ON orders.statusID=orderStatus.ID) LEFT JOIN custAccounts ON orders.custID=custAccounts.ID)
        where orders.otherSiteOrderNum LIKE '%#form.discogsID#%' OR #sString# lastName LIKE '%#thisLastName#%' OR email LIKE '%#thisEmail#%' OR username LIKE '%#thisUsername#%' order by orderID DESC
    </cfquery>
<cfelse>
    <cfquery name="thisOrder" datasource="#DSN#" maxrows="20">
        select *, [orders].[ID] As orderID
        from ((orders LEFT JOIN orderStatus ON orders.statusID=orderStatus.ID) LEFT JOIN custAccounts ON orders.custID=custAccounts.ID)
        where #sString# lastName LIKE '%#thisLastName#%' OR email LIKE '%#thisEmail#%' OR username LIKE '%#thisUsername#%' order by orderID DESC
    </cfquery>
</cfif>
<cfif thisOrder.RecordCount EQ 0>
	<cflocation url="orders.cfm?notFound=true&findID=#form.ID#&findDiscogsID=#form.discogsID#&findLastName=#form.lastName#&findEmail=#form.email#&findUsername=#form.Username#">
<cfelseif thisOrder.RecordCount EQ 1>
	<cflocation url="ordersEdit.cfm?ID=#thisOrder.ID#">
<cfelse>
<p><font color="red"><b>NOTE:</b></font> Showing 20 most recent matching orders only. See the customer account to view all orders.</p>
<cfoutput query="thisOrder">
<cfset thisOrderID=orderID>
<h2>Order Number: #NumberFormat(thisOrderID,"00000")# <cfif otherSiteID EQ 2>[Discogs Order ###otherSiteOrderNum#]</cfif></h2>
			<cfquery name="thisItems" datasource="#DSN#">
				SELECT orderItemID As ID, catnum, artist, title, label, albumStatusID, albumStatusName, ONHAND, ONSIDE, adminAvailID, qtyOrdered, shelfCode, price As itemPrice, orderItemID
				FROM orderItemsQuery
				where orderID=#thisOrderID#
			</cfquery>
			<cfif thisItems.recordCount GT 0>
				<cfquery name="thisShipAddress" datasource="#DSN#">
					select *
					from custAddressesQuery
					where ID=#shipAddressID#
				</cfquery>
			<table cellpadding="2" border="1" style="border-collapse:collapse; margin-top: 15px;" width="1000">
					<tr>
						<td valign="top" nowrap align="left"><a href="ordersEdit.cfm?ID=#thisOrderID#">EDIT</a><br />
						<!---<cfif statusID NEQ 2>
							<a href="ordersPaid.cfm?ID=#thisOrder.orderID#&paid=2">NOT PAID</a><br />
						<cfelseif statusID NEQ 4>
							<a href="ordersPaid.cfm?ID=#thisOrder.orderID#&paid=4">PAID</a><br />
						</cfif>//--->
						<a href="customersOpusEdit.cfm?ID=#custID#">CUSTOMER PROFILE</a><br />
                        <a href="ordersShopStart.cfm?username=#username#">START NEW ORDER</a></br>
                        <a href="ordersViewOpen.cfm?ID=#thisOrderID#" target="_blank">PRINT SUMMARY</a><br />
						#statusName#</td>
						<td valign="top" width="100">
						<b>Started</b><br />
						#DateFormat(dateStarted,"mm/dd/yy")#<cfif datePurchased NEQ ""><br />
						<b>Checked Out</b><br />
						#DateFormat(datePurchased,"mm/dd/yy")#</cfif>
						</td>
						<td valign="top" width="840" colspan="2">#firstName# #lastName#<br />
						<cfloop query="thisShipAddress">#add1#<br />
						<cfif add2 NEQ "">#add2#<br /></cfif>
						<cfif add3 NEQ "">#add3#<br /></cfif>
						#city#, #state##stateprov# #postcode#<br />
						#country#</cfloop><br />
						#comments#</td>
						</tr>
				<cfloop query="thisItems">
				<tr><td nowrap align="right">#DollarFormat(itemPrice)#&nbsp;&nbsp;</td>
				<td nowrap><cfquery name="itemStat" datasource="#DSN#">
					select *
					from orderItemStatus
					where ID=#adminAvailID#
				</cfquery>#itemStat.name#</td>
				<td valign="top">
                	<cfset thisItemID=orderItemID>
					#qtyOrdered# X #artist# / #title# [#label#] [#catnum##shelfCode#] <a href="ordersItemDelete.cfm?ID=#thisItemID#">DELETE</a></td>
                    <td><cfif ONHAND+ONSIDE LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>[#NumberFormat(ONHAND,"000")#/#NumberFormat(ONSIDE,"000")#]</font></td>
					
		</tr></cfloop>
		<tr>
		<td colspan="4">
		<cfquery name="thisShipName" datasource="#DSN#">
			select *
			from shippingRates
			where ID=#shipID#
		</cfquery>Shipping Method: #thisShipName.name#</td></tr>
		<tr>
		<td colspan="4">Subtotal: #DollarFormat(orderSub)#<br />
		Shipping: #DollarFormat(orderShipping)#<br />
		Tax: #DollarFormat(orderTax)#<br />
		<b>Total: #DollarFormat(orderTotal)#</b></td>
		</tr>
		</table>
		</cfif>
	</cfoutput>
</cfif>
<cfinclude template="pageFoot.cfm">