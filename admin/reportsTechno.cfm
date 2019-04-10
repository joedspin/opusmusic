<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 18px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 12px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfquery name="imports" datasource="#DSN#">
	SELECT * from catItemsQuery
	where shelfCode<>'DT' AND albumStatusID<25 AND ONHAND>0 AND genreID IN (3,18)
	order by releaseDate DESC
</cfquery>
<h1>Techno / TechHouse Imports</h1>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="imports">
	<tr>
		<!---<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>//--->
        <td>#UCase(genre)#</td>
		<td>#UCase(catnum)#</td>
		<td>#UCase(label)#</td>
		<td>#UCase(artist)#</td>
		<td>#UCase(title)#</td>
        <td>#UCase(media)#</td>
		<!---<td align="right">#DollarFormat(buy)#</td>//--->
	</tr>
</cfoutput>
</table>
