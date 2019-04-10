<cfparam name="url.whichq=classics" default="full">
<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 18px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 12px; line-height: 100%; vertical-align:top;}
//-->
</style>
<cfif url.whichQ EQ "classics">
    <cfquery name="inventory" datasource="#DSN#">
        SELECT * from catItemsQuery
        where albumStatusID<25 AND ONHAND>0 AND mediaID NOT IN (6,19,20,21,22,23,24) AND (vendorID IN (5650,6978,5726,5439,7848,5697,2811) OR shelfID IN (1059,1066,2075,34,40) OR reissue=1)
        order by label, catnum
    </cfquery>
<cfelse>
<cfquery name="imports" datasource="#DSN#">
	SELECT * from catItemsQuery
	where (shelfCode='DT' OR (countryID=1 AND shelfCode<>'GR') AND NOT (labelID=4158 AND catnum LIKE '%GC%')) AND albumStatusID<25 AND ONHAND>0
	order by genre, label, catnum
</cfquery>
<h1>Downtown 161 - Inventory</h1>
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
        <td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
		<td align="right">#DollarFormat(wholesalePrice)#</td>
	</tr>
</cfoutput>
</table>
