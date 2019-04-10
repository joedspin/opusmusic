<cfparam name="url.labelID" default="0">
<cfquery name="salesByLabel" datasource="#DSN#">
	select sum(qtyOrdered) as totalSold, catnum, label, artist, title, NRECSINSET, media, ONHAND, ONSIDE
    from orderItemsQuery
    where adminAvailID=6 AND labelID=#url.labelID#
    group by catnum, label, artist, title, NRECSINSET, media, ONHAND, ONSIDE
</cfquery>
<!---<cfquery name="salesByLabel" datasource="#DSN#">
	select qtyOrdered as totalSold, catnum, label, artist, title, NRECSINSET, media, ONHAND, ONSIDE
    from orderItemsQuery
    where adminAvailID=6 AND labelID=#url.labelID#
    order by catnum
</cfquery>//--->
<style>td {font-size: 10px;}</style>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="salesByLabel">
<tr>
	<td align="right">#totalSold#</td>
    <td>#catnum#</td>
    <td>#left(label,15)#</td>
    <td>#left(artist,25)#</td>
    <td>#left(title,25)#<br />
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#Left(media,4)#</td>
    <td>#ONHAND#/#ONSIDE#</td>
</tr>
</cfoutput>
</table>