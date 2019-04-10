<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 14px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 10px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="op" datasource="#DSN#">
	SELECT * from catItemsQuery
	where shelfCode='OP' AND (ONHAND>0 OR ONSIDE>0) AND albumStatusID<25
	order by CONDITION_MEDIA, artist DESC
</cfquery>
<h1>Downtown 304 OP Inventory</h1>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="op">
	<tr>
		<td align="right">#ONHAND#/#ONSIDE#</td>
		<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
		<td>#catnum#</td>
		<td>#label#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td>#CONDITION_MEDIA#</td>
		<td align="right">#DollarFormat(price)#</td>
	</tr>
</cfoutput>
</table>
