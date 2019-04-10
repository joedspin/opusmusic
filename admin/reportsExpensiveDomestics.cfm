<cfparam name="url.doit" default="false">
<cfif url.doit>
	<cfquery name="doAdjust" datasource="#DSN#">
		update catItems
		set price=<cfqueryparam value="8.99" cfsqltype="cf_sql_money">
		where shelfID IN (7,9,11) AND (albumStatusID<>44 OR (ONSIDE>0 AND ONSIDE<>999)) AND price>cost+2 AND cost<7 AND price>9 AND NRECSINSET=1 AND title NOT LIKE '%promo%' AND countryID=1 AND labelID<>1641
	</cfquery>
</cfif>
<cfquery name="adjustExpensiveDomestics" datasource="#DSN#">
	select * from catItemsQuery
	where shelfID IN (7,9,11) AND (albumStatusID<>44 OR (ONSIDE>0 AND ONSIDE<>999)) AND price>cost+2 AND cost<7 AND price>9 AND NRECSINSET=1 AND title NOT LIKE '%promo%' AND countryID=1 AND labelID<>1641
	order by releaseDate DESC
</cfquery>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<cfoutput query="adjustExpensiveDomestics">
<tr>
	<td>#DollarFormat(cost)#</td>
	<td>#DollarFormat(price)#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
</tr>
</cfoutput>
</table>
<p><a href="reportsExpensiveDomestics.cfm?doit=true">Set all of the above to $8.99</a></p>