<cfquery name="fixStatus" datasource="#DSN#">
	update catItems
    set albumStatusID=24 where albumStatusID IN (21,23) AND dtDateUpdated<<cfqueryparam value="#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#"> and ONHAND>0
</cfquery>
<cfquery name="fixStatus" datasource="#DSN#">
	update catItems
    set albumStatusID=24 where albumStatusID IN (22) AND ONHAND>0
</cfquery>
<cflocation url="reports.cfm">