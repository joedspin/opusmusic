<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 14px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 10px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="op" datasource="#DSN#">
	SELECT * from catItemsQuery
	where shelfCode='DO' AND (ONHAND>0 OR ONSIDE>0)
	order by releaseDate DESC
</cfquery>
<h1>Downtown 304 DO Inventory</h1>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="op">
	<tr>
		<td align="right">#ONHAND#/#ONSIDE#</td>
		<td>#catnum#</td>
		<td>#label#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td>#countryAbbrev#</td>
		<td align="right">#DollarFormat(price)#</td>
	</tr>
</cfoutput>
</table>
