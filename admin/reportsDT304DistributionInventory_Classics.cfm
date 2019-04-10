<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 18px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 12px; line-height: 100%; vertical-align:top;}
//-->
</style>
<!---<cfquery name="imports" datasource="#DSN#">
	SELECT * from catItemsQuery
	where shelfCode='DT' AND albumStatusID<25 AND ONHAND>0 AND mediaID NOT IN (6,19,20,21,22,23,24)
	order by artist, title
</cfquery>
<h1>Downtown 161 - Inventory</h1>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="imports">
	<tr>
		<!---<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>//--->
        <td>#UCase(artist)#</td>
		<td><a href="http://www.downtown304.com/index.cfm?sID=#ID#">#UCase(title)#</a></td>
        <td>#UCase(media)#<cfif NRECSINSET GT 1>x#NRECSINSET#</cfif></td>
		<td>#UCase(label)#</td>
        <td>#UCase(catnum)#</td>
		<td>#UCase(genre)#</td>
		<td align="right">#DollarFormat(wholesalePrice)#</td>
	</tr>
</cfoutput>
</table>//--->
<cfquery name="inventory" datasource="#DSN#">
	SELECT * from catItemsQuery
	where albumStatusID<25 AND ONHAND>0 AND mediaID NOT IN (6,19,20,21,22,23,24) AND ONSIDE<>999 AND (vendorID IN (5650,6978,5726,5439,7848,5697,2811) OR shelfID IN (1059,1066,2075,34,40) OR reissue=1)
	order by label, catnum
</cfquery>
<h1>Downtown 304 - Inventory</h1>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="inventory">
	<tr>
		<!---<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>//--->
        <td>#UCase(label)#</td>
        <td>#UCase(catnum)#</td>
		<td>#UCase(artist)#</td>
		<td><a href="http://www.downtown304.com/index.cfm?sID=#ID#">#UCase(title)#</a></td>
        <td>#UCase(media)#<cfif NRECSINSET GT 1>x#NRECSINSET#</cfif></td>
		<td>#UCase(genre)#</td>
        <td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
		<td align="right">#DollarFormat(wholesalePrice)#</td>
	</tr>
</cfoutput>
</table>
