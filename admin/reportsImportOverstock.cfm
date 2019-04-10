<cfquery name="importOverstock" datasource="#DSN#" maxrows="200">
	select *
    from catItemsQuery
    where ONHAND>4 and releaseDate<<cfqueryParam value="2009-04-15" cfsqltype="cf_sql_date"> AND left(shelfCode,1)<>'D' and mediaID=1 AND albumStatusID<>23
    order by ONHAND DESC
</cfquery>
<table>
<cfoutput query="importOverstock">
<tr>
	<td>#ONHAND#</td>
    <td>#catnum#</td>
    <td>#label#</td>
    <td>#artist#</td>
    <td>#title#</td>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
    <td>#albumStatusName#</td>
</tr>
</cfoutput>
</table>