<cfquery name="importOverstock" datasource="#DSN#">
	select *
    from catItemsQuery
    where ONHAND>0 AND albumStatusID<25 AND specialItem=1
    order by label, catnum
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
    <td>#DollarFormat(price)#</td>
</tr>
</cfoutput>
</table>
<cfquery name="volcanoEnd" datasource="#DSN#">
	update catItems
    set price=(cost*1.4), specialItem=0
     where specialItem=1 AND shelfID<>11 AND price<cost
</cfquery>
<cfquery name="volcanoFixPrice" datasource="#DSN#">
	update catItems
    set price=((9-Right(price,1))/100)+price
    where Right(price,1)<>9 AND catnum='XLT439'
</cfquery>