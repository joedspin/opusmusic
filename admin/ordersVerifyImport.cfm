<style>
td {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size:9px;}
</style><cfparam name="url.ID" default="0">
<cfquery name="thisOrderVerify" datasource="#DSN#">
	select *
    from orderItemsQuery
    where orderID=#url.ID#
    order by orderItemID
</cfquery>
<h1><cfoutput>#url.ID#</cfoutput></h1>
<table>
<cfoutput query="thisOrderVerify">
<tr>
<td>#qtyOrdered#</td>
<td>#UCase(catnum)#</td>
<td>#Left(UCase(label),20)#</td>
<td>#Left(UCase(artist),20)#</td>
<td>#Left(UCase(title),20)#</td>
<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
</tr>
</cfoutput>
</table>