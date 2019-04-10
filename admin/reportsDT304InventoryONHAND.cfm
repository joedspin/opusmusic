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
<cfquery name="imports" datasource="#DSN#">
	SELECT * from catItemsQuery
	where albumStatusID<25 AND ONHAND>0 AND shelfID<>11
	order by label, catnum
</cfquery>
<h1>Downtown 304 - Inventory</h1>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfset catCount=0>
<cfset catCost=0>
<cfset catValue=0>
<cfoutput query="imports">
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
    <cfset catCount=catCount+ONHAND>
    <cfset catCost=catCost+(ONHAND*cost)>   
    <cfset catValue=catValue+(ONHAND*price)>
</cfoutput>

</table>
<cfoutput>Count: #catCount#; Cost: #DollarFormat(catCost)#; Value; #DollarFormat(catValue)#</cfoutput>
