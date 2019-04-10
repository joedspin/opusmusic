<cfparam name="url.makeclassic" default="0">
<cfif url.makeclassic NEQ 0>
	<cfquery name="makeclassic" datasource="#DSN#">
    	update catItems
        set labelID=6277
        where ID=#url.makeclassic#
    </cfquery>
</cfif>
<cfquery name="catalogFind" datasource="#DSN#">
    select *
    from catItemsQuery
    where vendorID=5439 AND labelID IN (796,1666) AND albumStatusID<44
    order by catnum
</cfquery>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse;"  align="center">
<cfoutput query="catalogFind">
    <tr>
    	<td><a href="catalogEdit.cfm?ID=#ID#&white=edit">EDIT</a></td>
        <td>#catnum#</td>
    	<td>#artist#</td>
        <td>#title#</td>
        <td><a href="reportsGeorgeTWhiteLabels.cfm?makeclassic=#ID#">Make Label Classics</a></td>
        
    </tr>
    </cfoutput>
</table>

