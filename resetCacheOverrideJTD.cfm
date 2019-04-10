<!---<cfquery name="Application.dt304items" datasource="#DSN#">
	select *, Left(shelfCode,1) As shelfLetter, catItemsQuery.ID As catItemID
	from catItemsQuery
	where ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0 OR albumStatusID=30 OR (albumStatusID=26 AND ONHAND>0)) AND ONSIDE<>999
</cfquery>
<cfquery name="Application.allTracks" datasource="#DSN#">
	select *
	from catTracksQuery
    where albumStatusID=148 OR ((ONHAND>0 and albumStatusID<25) OR albumStatusID=30 OR (ONSIDE>0 AND ONSIDE<>999) OR (albumStatusID=26 AND ONHAND>0)) OR (ONHAND=0 AND ONSIDE=0 AND albumStatusID>25  AND left(shelfCode,1)<>'D' AND
			dtDateUpdated>'#DateFormat(DateAdd('d',-30,varDateODBC),"yyyy-mm-dd")#' AND itemID IN (select catItemID from purchaseOrderDetails where completed=0 AND qtyRequested>qtyReceived))
</cfquery>
<!---where ((ONHAND>0 AND albumStatusID<25 AND albumStatusID>20) OR ONSIDE >0 OR (ONHAND=0 AND ONSIDE=0 AND albumStatusID=44  AND left(shelfCode,1)<>'D' AND ID IN (select catItemID from purchaseOrderDetails where completed=0 AND qtyRequested>qtyReceived))) AND ONSIDE<>999//--->
<cfquery name="artists" datasource="#DSN#">
	SELECT DISTINCT artists.ID, artists.sort, artists.name, Left([shelfCode],1) AS shelfCodeLetter, Left(sort,1) As artistLetter
	FROM artists INNER JOIN catItemsQuery ON artists.ID = catItemsQuery.artistID
	WHERE (((Left([shelfCode],1))='D') OR isVendor=1) AND (((ONHAND>0 And albumStatusID<25) OR albumStatusID=30 OR ONSIDE>0)) AND ONSIDE<>999
	ORDER BY artists.sort
</cfquery>
<cfquery name="labels" datasource="#DSN#">
	SELECT DISTINCT labels.ID, labels.sort, labels.name, Left([shelfCode],1) AS shelfCodeLetter, Left(sort,1) As labelLetter, labels.logofile
	FROM labels INNER JOIN catItemsQuery ON labels.ID = catItemsQuery.labelID
	WHERE (((Left([shelfCode],1))='D') OR isVendor=1) AND (((ONHAND>0 And albumStatusID<25) OR albumStatusID=30 OR ONSIDE>0)) AND ONSIDE<>999
	ORDER BY labels.sort
</cfquery>
<cfquery name="Application.dt161Items" datasource="#DSN#">
		select *
		from catItemsQuery
		where (Left(shelfCode,'1')='D' AND shelfCode<>'DS') AND ONHAND>0 AND albumStatusID<25 AND dtID<>0
	</cfquery>
<cfquery name="dt161Tracks" datasource="#DSN#">
	select *
	from catTracksQuery
    where (Left(shelfCode,'1')='D' AND shelfCode<>'DS') AND ONHAND>0 AND albumStatusID<25 AND dtID<>0
</cfquery>
<cfquery name="dt161artists" datasource="#DSN#">
	SELECT DISTINCT artists.ID, artists.sort, artists.name, Left([shelfCode],1) AS shelfCodeLetter, Left(sort,1) As artistLetter
	FROM artists INNER JOIN catItemsQuery ON artists.ID = catItemsQuery.artistID
	WHERE (Left(shelfCode,'1')='D' AND shelfCode<>'DS') AND ONHAND>0 AND albumStatusID<25 AND dtID<>0 
	ORDER BY artists.sort
</cfquery>
<cfquery name="dt161labels" datasource="#DSN#">
	SELECT DISTINCT labels.ID, labels.sort, labels.name, Left([shelfCode],1) AS shelfCodeLetter, Left(sort,1) As labelLetter, labels.logofile
	FROM labels INNER JOIN catItemsQuery ON labels.ID = catItemsQuery.labelID
	WHERE (Left(shelfCode,'1')='D' AND shelfCode<>'DS') AND ONHAND>0 AND albumStatusID<25 AND dtID<>0
	ORDER BY labels.sort
</cfquery>//--->
<cfobjectcache 
    action = "clear" />
<!--- Special Query to put old IMPORTS Back in stock //--->
<cfset AYearAgo=DateAdd('d',-365,varDateODBC)>
<cfquery name="oldImportsBackIn" datasource="#DSN#">
	update catItems
    set albumStatusID=23, dtDateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
    where dtDateUpdated<<cfqueryparam value="#AYearAgo#" cfsqltype="cf_sql_date"> AND albumStatusID<25 AND ONHAND>0
</cfquery>
<html>
<body><p align="center">Cache Reset Complete</p>
</body>
</html>
<cflocation url="index.cfm">