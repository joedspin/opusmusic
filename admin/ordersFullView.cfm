<cfset pageName="ORDERS">
<cfparam name="url.findID" default="">
<cfparam name="url.findLastName" default="">
<cfparam name="url.findEmail" default="">
<cfparam name="url.notFound" default="false">
<cfinclude template="pageHead.cfm">
<cfquery name="ordersWaiting" datasource="#DSN#">
	select *, statusName, firstName, lastName
	from ((orders LEFT JOIN orderStatus ON orderStatus.ID=orders.statusID) LEFT JOIN custAccounts ON custAccounts.ID=orders.custID)
	where statusID<6 AND statusID>1
	order by statusID, datePurchased DESC
</cfquery>
<!---<cfquery name="thisStatus" datasource="#DSN#">
					select statusName
					from orderStatus
					where ID=#statusID#
				</cfquery>//--->
<h1>Opus</h1>
<p>Currently viewing FULL VIEW. <a href="orders.cfm">Click here for QUICK VIEW.</a></p>
<cfform name="findOrder" action="ordersFind.cfm" method="post">
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<tr>
			<td colspan="4"><h2>Find Order <cfif url.notFound><font color="red">Not Found</font></cfif></h2></td>
		</tr>
		<tr>
			<td>Order Number:</td>
			<td>Last Name:</td>
			<td>Email:</td>
			<td rowspan="2" valign="bottom"><cfinput type="submit" name="submit" value=" Find "></td>
		</tr>
		<tr>
			<td><cfinput type="text" name="ID" size="10" maxlength="6" value="#url.findID#"></td>
			<td><cfinput type="text" name="lastName" size="20" maxlength="50" value="#url.findLastName#"></td>
			<td><cfinput type="text" name="email" size="20" maxlength="50" value="#url.findEmail#"></td>
	</table>
</cfform>
<cfif ordersWaiting.RecordCount EQ 0>
	<p><font color="gray">No orders waiting</font></p>
<cfelse>
	<cfoutput><p>Number of orders waiting: #ordersWaiting.recordCount#</p></cfoutput>
		<cfset lastStatus="">
		<cfoutput query="ordersWaiting">
			<cfif statusID EQ 2>
				<cfquery name="thisItems" datasource="#DSN#">
					SELECT *, orderItemStatus.name As status
					FROM orderItemsQuery
					where orderID=#ID# AND adminAvailID=2
				</cfquery>
			<cfelse>
				<cfquery name="thisItems" datasource="#DSN#">
					SELECT *, orderItemStatus.name As status
					FROM orderItemsQuery
					where orderID=#ID#
				</cfquery>
			</cfif>
			<cfif thisItems.recordCount NEQ 0>
				<cfquery name="thisCust" datasource="#DSN#">
					select firstName, lastName
					from custAccounts
					where ID=#custID#
				</cfquery>
				<!---<cfquery name="fixStatus" datasource="#DSN#">
					UPDATE orderItems
					set adminAvailID=2
					where adminAvailID=0 AND orderID=#ID#
				</cfquery>//--->
				<!---<cfquery name="thisShipAddress" datasource="#DSN#">
					select *
					from custAddressesQuery
					where ID=#shipAddressID#
				</cfquery>//--->
				
				<cfif statusName NEQ lastStatus><h1><font color="##00CC33">#statusName#</font></h1></cfif>
				<cfset lastStatus=statusName>
				<table cellpadding="2" border="1" style="border-collapse:collapse; margin-top: 15px;" width="1000" >
					<tr>
						<td valign="top" width="100" nowrap>
						<a href="ordersEdit.cfm?ID=#ordersWaiting.ID#">EDIT</a><br />
						<a href="ordersDelete.cfm?ID=#ordersWaiting.ID#">DELETE</a><br />
						<a href="ordersEmailAdmin.cfm?ID=#ordersWaiting.ID#">EMAIL ADMIN</a><br />
						<a href="ordersView.cfm?ID=#ordersWaiting.ID#" target="_blank">VIEW</a><br />
						<cfif statusID EQ 4>
							<a href="ordersPaid.cfm?ID=#ordersWaiting.ID#&paid=2">NOT PAID</a><br />
						<cfelse>
							<a href="ordersPaid.cfm?ID=#ordersWaiting.ID#&paid=4">PAID</a><br />
						</cfif>
						<a href="ordersUpdateStatus.cfm?ID=#ordersWaiting.ID#&dateShipped=#DateFormat(varDateODBC,"mm/dd/yy")#">FINAL</a></td>
						<td valign="top" colspan="2">
						<b>Started</b><br />
						#DateFormat(dateStarted,"mm/dd/yy")#<cfif datePurchased NEQ ""><br>
						<b>Checked Out</b><br />
						#DateFormat(datePurchased,"mm/dd/yy")#<br /></cfif>
						<cfif statusID EQ 1>
							<font color="red">
						<cfelseif statusID EQ 2 OR statusID EQ 3>
							<font color="yellow">
						<cfelseif statusID EQ 4>
							<font color="green">
						</cfif>#statusName#</font>
						</td>
						<td valign="top" width="780">#thisCust.firstName# #thisCust.lastName#<!---<br />
						<cfloop query="thisShipAddress">#add1#<br />
						<cfif add2 NEQ "">#add2#<br /></cfif>
						<cfif add3 NEQ "">#add3#<br /></cfif>
						#city#, #state##stateprov# #postcode#<br />
						#country#</cfloop>//---></td>
						
					</tr>
							<cfloop query="thisItems">
							<tr>
							<td><cfif adminAvailID EQ 2><font color="red">Pending</font><cfelse>#status#</cfif></td>
							<td align="center" nowrap width="50">[#NumberFormat(ONHAND,"000")#/#NumberFormat(ONSIDE,"000")#]</td>
							<td nowrap width="100"><cfif albumStatusID GT 24 AND ONSIDE LT 1><font color="##FF0000"><b>#albumStatusName#</b></font><cfelseif albumStatusID GT 24 AND ONSIDE GT 0><font color="##FFFF00">#albumStatusName#</font><cfelse>#albumStatusName#</cfif></td>
							<td valign="top">
								<a href="catalogEdit.cfm?ID=#catItemID#&pageback=orders.cfm">item</a> #qtyOrdered# X #artist# / #title# [#label#] [#catnum##shelfCode#] <cfif ONSIDE GT 0><font color="cyan">ONSIDE</font></cfif></td>
					</tr></cfloop>	
					</table>
				</cfif>
		</cfoutput>
</cfif>
<!---<cfquery name="GEMMordersWaiting" datasource="#DSN#">
	select *
	from GEMMBatchProcessing
	where Processed=0
	order by CustomerGMU
</cfquery>
<cfset lastCust="0">
<h1>GEMM</h1>
<cfif GEMMordersWaiting.RecordCount EQ 0>
<p><font color="gray">No orders waiting</font></p>
<cfelse>
<cfoutput>Number of Items to Print: #GEMMordersWaiting.recordCount#</cfoutput>
	<table>
	<cfoutput query="GEMMordersWaiting">
			<cfset thisItemDescrip=Replace(Replace(ItemDescrip,"Your item number: ","","all"),"GEMM item number: ","","all")>
			<cfif CustomerGMU EQ lastCust>
				<br /><a href="ordersGEMMItemDelete.cfm?ID=#ID#">DELETE</a> #thisItemDescrip#
			<cfelse>
			<cfif lastCust NEQ 0>
				</td></tr>
			</cfif>
			<tr>
				<td valign="top"><a href="ordersEdit.cfm?ID=#OrderGMR#">EDIT</a></td>
				<td valign="top">#ShiptoAttn#<br />
				#ShiptoStreet#<br />
				<cfif ShiptoStreet2 NEQ "">#ShiptoStreet2#<br /></cfif>
				<cfif ShiptoStreet3 NEQ "">#ShiptoStreet3#<br /></cfif>
				#ShiptoCity#, #ShiptoState# #ShiptoZip#<br />
				#ShiptoCountry#</td>
				<td valign="top"><a href="ordersGEMMItemDelete.cfm?ID=#ID#">DELETE</a> #thisItemDescrip#
			</cfif>
			<cfset lastCust=CustomerGMU>
	</cfoutput>
	</td></tr>
</table>
</cfif>//--->
<cfinclude template="pageFoot.cfm">