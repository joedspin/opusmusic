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
<cfquery name="orderToDelete" datasource="#DSN#">
	select *
	from GEMMBatchProcessing
	where ID=#url.ID#
</cfquery>
<cfset lastCust="0">
<table>
	<cfoutput query="orderToDelete">
			<cfset thisItemDescrip=Replace(Replace(ItemDescrip,"Your item number: ","","all"),"GEMM item number: ","","all")>
			<cfif CustomerGMU EQ lastCust>
				<br /> #thisItemDescrip#
			<cfelse>
			<cfif lastCust NEQ 0>
				</td></tr>
			</cfif>
			<tr>
				<td valign="top">#ShiptoAttn#<br />
				#ShiptoStreet#<br />
				<cfif ShiptoStreet2 NEQ "">#ShiptoStreet2#<br /></cfif>
				<cfif ShiptoStreet3 NEQ "">#ShiptoStreet3#<br /></cfif>
				#ShiptoCity#, #ShiptoState# #ShiptoZip#<br />
				#ShiptoCountry#</td>
				<td valign="top"> #thisItemDescrip#
			</cfif>
			<cfset lastCust=CustomerGMU>
	</cfoutput>
	</td></tr>
</table>
<p><b>Are you sure you want to permanently delete this item? Note that other items in the same order from this customer will NOT be deleted.</b><br />
THIS ACTION CANNOT BE UNDONE!</p>
<cfoutput><p><a href="ordersGEMMItemDeleteAction.cfm?ID=#url.ID#">YES</a> | <a href="orders.cfm">NO</a></p></cfoutput>
<cfinclude template="pageFoot.cfm">