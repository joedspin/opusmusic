<cfparam name="printableOrdersList" default="">
<table border="0" cellpadding="5" cellspacing="0">
<tr>
<td><img src="images/spacer.gif" width="1" height="10"></td>
<td><a href="orders.cfm?closed=recent">Recently Completed</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>
<!---<td><a href="ordersPending.cfm">Pending Orders</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>--->
<td><a href="ordersGEMMLoad.cfm">GEMM Import</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>
<td><a href="ordersMusicStackLoad.cfm">MusicStack Import</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>
<!---<td><a href="ordersViewAll.cfm">Picklists</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>//--->
<cfoutput><td><a href="ordersViewAll.cfm?IDlist=#printableOrdersList#">Print Orders</a></td></cfoutput>
<td><img src="images/spacer.gif" width="10" height="10"></td>
<!---<td><a href="ordersViewAll.cfm?pGEMMonly=true">Print GEMM Orders Only</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>//--->
<td><a href="ordersPrintPicklists.pdf" target="_blank">Print Orders PDF</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>
<td><a href="ordersBackOrders.cfm">Backorders</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>
<td><a href="ordersAggregateStart.cfm">Aggregator</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>
<td><a href="ordersOpenCarts.cfm">Open Carts</a></td>
<td><img src="images/spacer.gif" width="10" height="10"></td>
<cfoutput><td><a href="ordersVinylmaniaReport.cfm?vmdate=#DateFormat(varDateODBC,"mm-dd-yyyy")#&showdetails=false">Vinylmania Register</a></td></cfoutput>

</tr>
</table><!---
<td><a href="ordersAddresses.cfm">Addresses</a></td>
<td><a href="ordersGEMMPrint.cfr">GEMM Print Orders</a></td>
<td><a href="ordersGEMMAddresses.cfm" target="_blank">GEMM Addresses</a></td>
<td><a href="ordersGEMMConvert.cfm">GEMM Convert</a></td>
<td><a href="ordersGEMMFinalize.cfm">GEMM Finalize Orders</a></td>
<td><a href="ordersKillBogus.cfm?pstatus=0">GEMM Delete Open Orders</a></td>//--->