<cfquery name="weeklymarkdowns" datasource="#DSN#">
	select *
    from catItemsQuery
    where blue99=1 AND ONHAND>0 AND albumStatusID<25
    order by artist, title
</cfquery>
<style>
td {vertical-align: top; font-family: Arial, Helvetica, sans-serif; font-size: 8pt;}
.regprice {text-decoration: line-through;}
</style>
<p align="center"><a href="http://www.downtown304.com/index.cfm?group=blue99"><img src="http://www.downtown304.com/images/DeepDiscountsWarehouse.png" alt="Special Warehouse Markdowns" width="600" height="92" title="Special Warehouse Markdowns" border="0" /></a></p>
<table border="1" padding="2" cellspacing="0" style="border-collapse;" width="800" align="center">
<cfoutput query="weeklymarkdowns">
<tr>
	<td>#artist#</td>
    <td>#title#</td>
    <td>#label# (#catnum#)</td>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
    <td align="right" class="regprice">#DollarFormat(priceSave)#</td>
    <td align="right">#DollarFormat(price)#</td>
</tr>
</cfoutput>
</table>