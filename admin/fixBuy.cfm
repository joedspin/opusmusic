<cfquery name="fixBuy" datasource="#DSN#">
	select *
	from catItemsQuery
	where cost=4.99 AND buy>4.99 AND left(shelfCode,1)='D'
    order by label, catnum
</cfquery>
<cfset itemCt=0>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size:x-small;}
</style>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
<tr>
<td>&nbsp;</td>
<td>CATNUM</td>
<td>LABEL</td>
<td>ARTIST</td>
<td>TITLE</td>
<td>304 SELL</td>
<td>304 BUY</td>
<td>161 SELL</td></tr>
<cfoutput query="fixBuy">
<cfset itemCt=itemCt+1>
<tr>
<td>#itemCt#</td>
<td>#catnum#</td>
<td>#label#</td>
<td>#artist#</td>
<td>#title#</td>
<td>#DollarFormat(price)#</td>
<td>#DollarFormat(cost)#</td>
<td>#DollarFormat(buy)#</td></tr>
</cfoutput></table><cfabort>
<cfquery name="fixBuy" datasource="#DSN#">
	update catItems
	set buy=5.49 where ID IN (select ID
	from catItemsQuery
	where buy<4 AND left(shelfCode,1)='D')
</cfquery>