<cfquery name="inventoryReport" datasource="#DSN#">
	select *
	from catItemsQuery
	where (dtID <> 0 AND Album_Status_ID < 25) OR ONHAND > 0
</cfquery>
<cfoutput query="inventoryReport">
#ID##shelfCode##chr(9)##chr(9)##artist##chr(9)##title##chr(9)##CONDITION_MEDIA##chr(9)##CONDITION_COVER##chr(9)##DollarFormat(PRICE)##chr(9)##label##chr(9)##catnum##chr(9)##countryAbbrev##chr(9)##DateFormat(releaseDate,"yyyy")##chr(9)##NRECSINSET##chr(9)##ONHAND##chr(9)##media##chr(9)##genre#<br />
</cfoutput>