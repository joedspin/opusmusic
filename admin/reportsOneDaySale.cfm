<cfquery name="oneDaySale" datasource="#DSN#">
	select *
    from catItemsQuery
    where releaseDate<'2010-07-19' AND ONHAND>3 AND price>cost AND albumStatusID<>23 AND shelfID<>11
</cfquery>
<cfoutput query="oneDaySale">
#catnum# #artist# #title# #releaseDate# #dtDateUpdated#<br />
</cfoutput>