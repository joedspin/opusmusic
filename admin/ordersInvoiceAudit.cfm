<!--- and dateShipped>'2011-09-01'//---><cfquery name="auditItems" datasource="#DSN#">
	select *
    from orderItemsQuery
    where statusID=6 AND issueResolved<>1 AND shelfID=11
    order by label, catnum, dateShipped
</cfquery>
<table>
<cfoutput query="auditItems">
	<tr>
    	<td>#DateFormat(dateShipped,"yyyy-mm-dd")#</td>
        <td>#qtyOrdered#</td>
        <td>#label#</td>
        <td>#catnum#</td>
        <td>#artist#</td>
        <td>#title#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	</tr>
</cfoutput>
</table>