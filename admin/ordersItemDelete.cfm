<cfparam name="url.ID" default="0">
<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<p>Downtown 304 online admin tool</p>
<p>Orders</p>
<p><a href="ordersGEMMLoad.cfm">GEMM Import</a><br />
<a href="ordersGEMMPrint.cfr">GEMM Print</a><br />
<a href="ordersGEMMAddresses.cfm" target="_blank">GEMM Addresses</a><br>
<a href="ordersGEMMFinalize.cfm">GEMM Finalize</a><br /></p>
<!---<p><a href="ordersKillBogus.cfm">Erase Orders</a> (Cannot be undone)</p>//--->
<cfquery name="itemToDelete" datasource="#DSN#">
	SELECT orderItems.*, catItemsQuery.*
	FROM orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID
	where orderItems.ID=#url.ID#
</cfquery>
<table>
	<cfoutput query="itemToDelete">
			<tr>
				<td valign="top">Order Number: #NumberFormat(orderID,"00000")#</td>
                <cfset thisOrderID=orderID>
			</tr>
			<tr>
				<td valign="top"> #artist# #title# [#catnum##shelfCode#]</td>
			</tr>
	</cfoutput>
</table>
<p><b>Are you sure you want to permanently delete this item? Note that other items in the same order from this customer will NOT be deleted.</b><br />
THIS ACTION CANNOT BE UNDONE!</p>
<cfparam name="url.pageBack" default="ordersEdit.cfm?ID=#thisOrderID#">
<cfoutput><p><a href="ordersItemDeleteAction.cfm?ID=#url.ID#&pageBack=ordersEdit.cfm?ID=#thisOrderID#">YES</a> | <a href="orders.cfm">NO</a></p></cfoutput>
<cfinclude template="pageFoot.cfm">
<cflocation url="ordersItemDeleteAction.cfm?ID=#url.ID#&pageBack=#url.pageBack#">