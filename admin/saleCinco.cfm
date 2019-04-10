<cfquery name="cincosale" datasource="#DSN#">
	select *
	from catItemsQuery
	where shelfID=11 AND albumStatusID<25 AND ONHAND>0 AND ((dtBuy<2.51 AND mediaID IN (1,11)) OR (vendorID IN (6897,63190) AND mediaID IN (1,11)) OR (vendorID IN (4071,5320,6623,5786,6243)))
	order by label, CATNUM
</cfquery>
<p><cfoutput>#cincosale.recordCount# Items</cfoutput></p>
<cfoutput query="cincosale">
#label# - #CATNUM# - #artist# - #title# - #NRECSINSET#x#media# (#dtBuy#) (#cost#) (#buy#)<br>
</cfoutput>
