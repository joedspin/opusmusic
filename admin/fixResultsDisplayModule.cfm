<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="saleprospects">
<tr>	
		<td>#artist#</td>
		<td>#title#</td>
        <td>#label#</td>
		<td>#catnum#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
		<td align="right">#DollarFormat(price)#</td>
        <td align="right">#DollarFormat(priceSave)#</td>
        <td align="right">#DollarFormat(cost)#</td>
        <td align="right">#DollarFormat(costSave)#</td>
	</tr>
</cfoutput>
</table>