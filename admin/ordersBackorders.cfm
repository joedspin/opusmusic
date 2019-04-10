<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<h1>Backorders</h1>
<cfquery name="backorders" datasource="#DSN#">
	select *
	from orderItemsQuery
	where adminAvailID=3
</cfquery>
<cfif backorders.recordCount EQ 0>
<p>No items backordered</p>
<cfelse>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="backorders">
	<tr>
		<td><a href="ordersBackordersDelete.cfm">DELETE</a><br />
			<a href="ordersBackordersNotify.cfm">NOTIFY</a></td>
		<td>#catnum#</td>
		<td>#label#
		<td>#artist#</td>
		<td>#title#</td>
		<td>#NRECSINSET# x #media#</td>
		<td>#ONHAND# / #ONSIDE#</td>
		<td><cfif ONHAND+ONSIDE GT 0><font color="red">AVAILABLE</font><cfelse>NOT AVAIL</cfif></td>
	</tr>
</cfoutput>
</table>
</cfif>
<cfinclude template="pageFoot.cfm">