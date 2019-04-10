<cfquery name="opusInventory" datasource="#DSN#">
	select *
	from catItemsQuery
	where shelfCode='OP' AND CONDITION_MEDIA='NEW' AND ONHAND >0
	order by artist
</cfquery>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="opusInventory">
<tr style="font-family:Arial, Helvetica, sans-serif; font-size: 10px;">
	<td>#ONHAND#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
</tr>
</cfoutput>
</table>