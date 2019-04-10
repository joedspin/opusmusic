<cfquery name="allNewReleases" datasource="#DSN#">
 select *
 from catItemsQuery
 where albumStatusID=21
 AND ((ONHAND>0 OR ONSIDE>0) AND (albumStatusID<=22 AND albumStatusID>=21))
 order by releaseDate DESC
</cfquery>
<cfoutput query="allNewReleases">
	#catnum# #artist# #title#<br />
</cfoutput>