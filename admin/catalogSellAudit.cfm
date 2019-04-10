<cfparam name="url.ID" default="0">
<cfquery name="sellHistory" datasource="#DSN#">
	select *
	from orderItemsQuery
	where catItemID=#url.ID#
	order by datePurchased DESC
</cfquery><!---adminAvailID=6 AND statusID<>7 AND //--->
<cfif sellHistory.recordCount GT 0>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
		<cfset totalSold=0>
        <cfset vmtotal=0>
		<cfoutput query="sellHistory">
			<tr>
				<td width="60"><a href="ordersEdit.cfm?ID=#orderID#">#DateFormat(dateShipped,"yyyy-mm-dd")#&nbsp;</a></td>
				<td>#firstName# #lastName#</td>
                <td><cfquery name="auditSale" datasource="#DSN#">
                	select *
                    from catSold
                    where catItemID=#catItemID# AND qtyOrdered=#qtyOrdered# AND dateShipped=<cfqueryparam value="#dateShipped#" cfsqltype="cf_sql_date"> AND orderID=#orderID#
                </cfquery><cfif auditSale.recordCount NEQ 0>Confirmed<cfelse>Not Found</cfif></td>
				<td align="center" width="20">#qtyOrdered#</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="3">Total Sold:&nbsp;</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
<cfelse>
<p>None</p>
</cfif>
<cfquery name="auditSale" datasource="#DSN#">
                	select *
                    from catSold
                    where catSold.catItemID=#url.ID#
                </cfquery>
                <cfoutput query="auditSale">
                
				#qtyOrdered# | #DateFormat(dateShipped,"yyyy-mm-dd")# <br>
                </cfoutput>