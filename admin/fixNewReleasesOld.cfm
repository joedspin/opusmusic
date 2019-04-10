<cfquery name="fixStatus" datasource="#DSN#">
	update catItems
    set albumStatusID=24 
    where albumStatusID IN (21,22) AND releaseDate<<cfqueryparam value="2016-04-01"> and ONHAND>0
</cfquery>
