<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 18px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 12px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="imports" datasource="#DSN#">
	SELECT * from catItemsQuery
	where albumStatusID<25 AND ONHAND>0 AND ONSIDE<>999 AND mp3Loaded=0
	order by vendorID, label, catnum
</cfquery>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="imports">
	<tr>
    	<td>#vendorID#</td>
		<td>#DateFormat(releaseDate,"yyyy-mm-dd")#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
		<!---<td>#shelfCode#</td>//--->
		<!---<td align="right">#ONHAND#</td>
		<td align="right">#DollarFormat(price)#</td>//--->
		<td>#catnum#</td>
		<td>#label#</td>
		<td>#artist#</td>
		<td>#title#</td>
        <td>#ONHAND#</td>
        <td>#discogsID#</td>
        <td>#shelfCode#</td>
	</tr>
</cfoutput>
</table>
