<cfquery name="fixFeatured" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID=19 and Left(shelfCode,1)='D' AND dtDateUpdated>'09/01/2010'
</cfquery>
<cfoutput query="fixFeatured">
#catnum# #DateFormat(releaseDate,"mm/dd/yy")# #DateFormat(dtDateUpdated,"mm/dd/yy")#<br>
</cfoutput>
<cfquery name="fixFeaturedAction" datasource="#DSN#">
	update catItems
    set notNew304=0, dtDateUpdated=<cfqueryparam value="9/23/10" cfsqltype="cf_sql_date">, releaseDate=<cfqueryparam value="9/23/10" cfsqltype="cf_sql_date">, releaseDateLock=1
    where albumStatusID=19 AND shelfID=11 AND dtDateUpdated>'09/01/2010'
</cfquery>