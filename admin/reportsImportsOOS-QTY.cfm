<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 18px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 12px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="imports" datasource="#DSN#">
	SELECT * from catItemsQuery
	where isVendor=1 AND shelfID<>11 AND albumStatusID>24 AND ONHAND>0
	order by label, catnum
</cfquery>
<h1>Downtown 304</h1>
<h2>Out of Stock, Inactive, or Pre-Release / Quantity ONHAND>0</h2>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<tr style="font-weight: bold; background-color:#CCCCCC;">
		<td align="center">QTY</td>
		<td>STATUS</td>
		<td>CATNUM</td>
		<td>LABEL</td>
		<td>ARTIST</td>
		<td>TITLE</td>
		<td>RELEASE DATE</td>
        <td>MEDIA</td>
		<td align="center">VENDOR</td><!---
		<td align="right">PRICE</td>//--->
	</tr>
<cfoutput query="imports">
	<tr>
		<td align="right">#ONHAND#</td>
		<td>#Album_Status_Name#</td>
		<td>#catnum#</td>
		<td>#label#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
		<td align="center">#shelfCode#</td><!---
		<td align="right">#DollarFormat(price)#</td>//--->
	</tr>
</cfoutput>
</table>
<p><a href="reports.cfm">Back to Reports</a></p>
