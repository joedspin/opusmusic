<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 18px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 12px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="imports" datasource="#DSN#">
	SELECT * from catItemsQuery
	where LEFT(shelfCode,1)<>'D' AND (albumStatusID<25 AND ONHAND>0) AND mediaID IN (9,11)
	order by mediaID, artist, title
</cfquery>
<h1>Downtown 304 Imports</h1>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="imports">
	<tr>
		
        <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
		<!---<td>#shelfCode#</td>//--->		
		<td>#artist#</td>
		<td>#label#</td>
        <td>#catnum#</td>
		<td>#title#</td>
        <td align="right">#ONHAND#</td>
		<td align="right">#DollarFormat(price)#</td>
        <td>#DateFormat(releaseDate,"mm/dd/yy")#</td>
	</tr>
</cfoutput>
</table>
