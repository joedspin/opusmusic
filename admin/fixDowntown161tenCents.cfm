<cfquery name="TenCentsDowntown161" datasource="#DSN#">
	update catItems
    set cost=0.10, costSave=0
    where shelfID=11 AND labelID NOT IN (1586) AND ID NOT IN (67360,42800) 
</cfquery>