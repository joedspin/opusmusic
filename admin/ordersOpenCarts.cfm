<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<cfparam name="url.maxrows" default="60">
<cfquery name="ordersWaiting" datasource="#DSN#" maxrows="#url.maxrows#">
	select *, statusName, firstName, lastName
	from ((orders LEFT JOIN orderStatus ON orderStatus.ID=statusID) LEFT JOIN custAccounts ON custAccounts.ID=custID)
	where statusID=1
	order by dateUpdated DESC
</cfquery>
<cfif ordersWaiting.RecordCount EQ 0>
	<p><font color="gray">No open carts</font></p>
<cfelse>
<cfif url.maxrows NEQ "-1">
	<p>Currently showing <cfoutput>#url.maxrows#</cfoutput> most recently started carts<br />
	<a href="ordersOpenCarts.cfm?maxrows=-1">Show all open carts</a></p>
<cfelse>
	<p>Currently showing all open carts<br />
	<a href="ordersOpenCarts.cfm?maxrows=<cfoutput>#url.maxrows#</cfoutput>">Show only <cfoutput>#url.maxrows#</cfoutput> carts</a></p>
</cfif>
<!---<p>Currently displaying <cfif url.maxrows EQ -1>ALL open carts<cfelse><cfoutput>#url.maxrows# most recently started carts</cfoutput></cfif>
<cfif url.maxrows NEQ 10><br /><a href="ordersOpenCarts.cfm?maxrows=10">Click here to show 10 open carts</a></cfif>
<cfif url.maxrows NEQ 20><br /><a href="ordersOpenCarts.cfm?maxrows=20">Click here to show 20 open carts</a></cfif>
<cfif url.maxrows NEQ 30><br /><a href="ordersOpenCarts.cfm?maxrows=30">Click here to show 30 open carts</a></cfif>
<cfif url.maxrows NEQ 0><br /><a href="ordersOpenCarts.cfm?maxrows=-1">Click here to show ALL open carts</a></cfif></p>//--->
		<cfoutput query="ordersWaiting">
			<cfquery name="thisItems" datasource="#DSN#">
				SELECT orderItemID As ID, catItemID, catnum, artist, title, label, albumStatusID, albumStatusName, ONHAND, ONSIDE, adminAvailID, qtyOrdered, shelfCode, itemStatus
				FROM orderItemsQuery
				where orderID=#ID#
			</cfquery>
			<cfif thisItems.recordCount GT 0>
				<!---<cfquery name="thisCust" datasource="#DSN#">
					select *
					from custAccounts
					where ID=#custID#
				</cfquery>//--->
				<!---<cfquery name="thisShipAddress" datasource="#DSN#">
					select *
					from custAddressesQuery
					where ID=#shipAddressID#
				</cfquery>//--->
			<table cellpadding="2" border="1" style="border-collapse:collapse; margin-top: 15px;" width="1000">
					<tr>
						<td valign="top" width="60" align="center" colspan="2"><a href="ordersDelete.cfm?ID=#ordersWaiting.ID#">DELETE</a><br /><a href="ordersViewOpen.cfm?ID=#ordersWaiting.ID#" target="_blank">PRINT</a></td>
						<td valign="top" width="100">
						<b>Started</b><br />
						#DateFormat(dateStarted,"mm/dd/yy")#<br />
						<b>Updated</b><br />
						#DateFormat(ordersWaiting.dateUpdated,"mm/dd/yy")#
						</td>
						<td valign="top" width="840" colspan="6"><a href="customersEdit.cfm?ID=#custID#">#firstName# #lastName#</a><!---<br>
						<cfloop query="thisShipAddress">#add1#<br />
						<cfif add2 NEQ "">#add2#<br /></cfif>
						<cfif add3 NEQ "">#add3#<br /></cfif>
						#city#, #state##stateprov# #postcode#<br />
						#country#</cfloop>//---></td>
						</tr>
				<cfloop query="thisItems">
				<!---<cfquery name="itemStatus" datasource="#DSN#">
					select *
					from orderItemStatus
					where ID=#adminAvailID#
				</cfquery>//--->
				<tr><td nowrap align="center">[<cfif ONHAND LT 20><font color="red">#NumberFormat(ONHAND,"000")#</font><cfelse>#NumberFormat(ONHAND,"000")#</cfif>/#NumberFormat(ONSIDE,"000")#]</td>
                <td align="center"><cfif left(shelfCode,1) NEQ 'D'><font color="##FFFF00">#shelfCode#</font><cfelse>#shelfCode#</cfif></td>
				<td nowrap><cfif albumStatusID GT 24 AND ONSIDE LT 1><font color="##FF0000"><b>#albumStatusName#</b></font><cfelseif albumStatusID GT 24 AND ONSIDE GT 0><font color="##FFFF00">#albumStatusName#</font><cfelse>#albumStatusName#</cfif></td>
				<td valign="top">#qtyOrdered#</td>
                <td valign="top">#catnum#</td>
                <td valign="top">#label#</td>
                <td valign="top">#artist#</td>
                <td valign="top">#title# </td>
                <td valign="top"><a href="ordersItemDelete.cfm?ID=#thisItems.ID#">DELETE</a> <cfif ONSIDE GT 0><font color="cyan">ONSIDE</font></cfif> <!---#itemStatus#//---> <a href="catalogEdit.cfm?ID=#catItemID#">item</a></td>
		</tr></cfloop>				
		</table>
		</cfif>
		</cfoutput>
</cfif>
<!---<p>Currently displaying <cfif url.maxrows EQ -1>ALL open carts<cfelse><cfoutput>#url.maxrows# most recently started carts</cfoutput></cfif>
<cfif url.maxrows NEQ 10><br /><a href="ordersOpenCarts.cfm?maxrows=10">Click here to show 10 open carts</a></cfif>
<cfif url.maxrows NEQ 20><br /><a href="ordersOpenCarts.cfm?maxrows=20">Click here to show 20 open carts</a></cfif>
<cfif url.maxrows NEQ 30><br /><a href="ordersOpenCarts.cfm?maxrows=30">Click here to show 30 open carts</a></cfif>
<cfif url.maxrows NEQ 0><br /><a href="ordersOpenCarts.cfm?maxrows=-1">Click here to show ALL open carts</a></cfif></p>//--->
<cfinclude template="pageFoot.cfm">