<cfset pageName="CUSTOMERS">
<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<cfparam name="url.find" default="">
<cfparam name="url.findField" default="">
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#url.ID#
</cfquery>
<cfquery name="countries" datasource="#DSN#">
	select *
	from countries
	order by name
</cfquery>
<cfoutput><p><a href="customersOpusStatement.cfm?ID=#url.ID#">Customer Statement</a> <a href="customerBackorders.cfm?custID=#ID#">BACKORDERS</a></p></cfoutput>
<cfoutput query="thisCust">
<cfform name="cust" method="post" action="customersOpusEditAction.cfm">
	<input type="hidden" name="find" value="#url.find#">
	<input type="hidden" name="findField" value="#url.findField#">
<table border="1" cellpadding="2" cellspacing="0">
	<tr>
		<td>First Name</td>
		<td><cfinput type="text" name="firstName" value="#firstName#" size="20" maxlength="50"></td>
	</tr>
	<tr>
		<td>Last Name</td>
		<td><cfinput type="text" name="lastName" value="#lastName#" size="20" maxlength="50"></td>
	</tr>
    <tr>
    	<td>Billing Name</td>
		<td><cfinput type="text" name="billingName" value="#billingName#" size="20" maxlength="50"></td>
    </tr>
	<tr>
		<td>Country</td>
		<td><cfselect name="countryID" query="countries" value="ID" display="name" selected="#countryID#" class="inputBox"></cfselect></td>
	</tr>
	<tr>
		<td>username</td>
		<td><cfinput type="text" name="username" value="#username#" size="20" maxlength="25"></td>
	</tr>
	<tr>
		<td>password</td>
		<td><cfinput type="text" name="password" value="#password#" size="20" maxlength="15"></td>
	</tr>
	<tr>
		<td>Email</td>
		<td><cfinput type="text" name="email" value="#email#" size="40" maxlength="150"></td>
	</tr>
	<tr>
		<td>Date Added</td>
		<td>#DateFormat(dateAdded,"mm/dd/yy")#</td>
	</tr>
     <tr>
    	<td>Store</td>
        <td><cfinput type="checkbox" name="isStore" value="1" checked="#YesNoFormat(isStore)#"/>
    </tr>
    <tr>
    	<td>Ignore Sales</td>
        <td><cfinput type="checkbox" name="ignoreSales" value="1" checked="#YesNoFormat(ignoreSales)#"/>
    </tr>
    <tr>
    	<td>Bad Customer</td>
        <td><cfinput type="checkbox" name="badCustomer" value="1" checked="#YesNoFormat(badCustomer)#"/>
    </tr>
    <tr>
    	<td valign="top">Customer Notes:</td>
        <td><cftextarea name="custNotes" value="#custNotes#" rows="6" cols="40"></cftextarea>
    </tr>
</table>
<p><input type="submit" name="submit" value="Save Changes" /><input type="hidden" name="ID" value="#url.ID#" /><input type="hidden" name="letter" value="#Left(lastName,1)#" /></p>
</cfform>
</cfoutput>
<h1>Cards</h1>
<cfquery name="myCards" datasource="#DSN#">
	select *
	from userCardsQuery
	where accountID=#url.ID#
</cfquery>
<p><cfoutput query="myCards"><a href="customersOpusCardEdit.cfm?ID=#myCards.ID#&custID=#url.ID#">#PayName# ending in #Right(Decrypt(ccNum,encryKey71xu),"4")#</a><br /></cfoutput></p>
<h1>Addresses</h1>
<cfquery name="myAddresses" datasource="#DSN#">
	select *
	from custAddressesQuery
	where custID=#url.ID#
</cfquery>
<cfoutput query="myAddresses">
		<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<tr>
		<td><b>#addName#</b><br />
		#firstName# #LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# <br />
		&nbsp;<br />
		Phone: #phone1#</td>
		</tr>
		</table>
	</cfoutput>
<h1>Orders</h1>
<cfquery name="custOrders" datasource="#DSN#" maxrows="20">
	select *
	from orders LEFT JOIN orderStatus ON orders.statusID=orderStatus.ID
	where custID=#url.ID#
	order by dateStarted DESC
</cfquery>
<cfif custOrders.RecordCount EQ 0>
	<p><font color="gray">No orders</font></p>
<cfelse>
	<p>NOTE: Showing only 20 most recent orders</p>
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
                <h1><a href="ordersEdit.cfm?ID=#ID#">#ID#</a></h1>
			<table cellpadding="2" border="1" style="border-collapse:collapse; margin-top: 15px;" width="1000">
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