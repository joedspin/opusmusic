<cfquery name="lpsale" datasource="#DSN#">
	select *
    from catItemsQuery
    where ONHAND>0 AND albumStatusID<25 AND mediaID=5 AND countryID>1
</cfquery>
<cfset itemcounter=0>
<table>
<cfoutput query="lpsale">
<cfset itemCounter=itemCounter+1>
<tr>
<td>#DateFormat(realReleaseDate,"mm-dd-yyyy")#</td>
<td>#itemCounter#</td>
<td>#catnum#</td>
<td>#label#</td>
<td>#artist#</td>
<td>#title#</td>
<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>LP</td>
<td>#DollarFormat(price)#</td>
<td>#ONHAND#</td>
</tr>
</cfoutput>
</table>