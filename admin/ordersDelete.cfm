<cfparam name="url.ID" default="0">
<cfparam name="url.pageBack" default="orders.cfm">
<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<cfquery name="orderToDelete" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfset lastCust="0">
<style>td {font-fize: small;}</style>
<table>
	<cfloop query="orderToDelete">
			<cfquery name="thisCust" datasource="#DSN#">
				select *
				from custAccounts
				where ID=#orderToDelete.custID#
			</cfquery>
			<cfoutput query="thisCust">
				<p>Delete Order ###orderToDelete.ID# for #firstName# #lastName#</p>
			</cfoutput>
	</cfloop>
	</td></tr>
</table>
<p><b>Are you sure you want to permanently delete this order?</b><br />
THIS ACTION CANNOT BE UNDONE!</p>
<cfoutput><p><a href="ordersDeleteAction.cfm?ID=#url.ID#">YES</a> | <a href="orders.cfm">NO</a></p></cfoutput>
<cfinclude template="pageFoot.cfm">