<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 14px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 10px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="op" datasource="#DSN#">
	SELECT * from catItemsQuery
	where labelID IN (1695,1849,1969,2303,2506,3257,4952,5931) AND ONSIDE<>999
	order by label, catnum
</cfquery>
<h1>Wave Music Catalog (including sublabels)</h1>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="op">
	<tr>
		<td align="right">#ONHAND+ONSIDE#</td>
		<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
		<td>#catnum#</td>
		<td align="right">#ID#</td>
		<td>#label#</td>
		<td>#artist#</td>
		<td>#title#</td>
	</tr>
</cfoutput>
</table>
