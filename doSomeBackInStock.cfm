<!--- Special Query to put old IMPORTS Back in stock //--->
<cfset lastYear=DateFormat(varDateODBC,"yyyy")-1>
<cfset todaysDate=DateFormat(varDateODBC,"mm-dd")>
<cfquery name="oldImportsBackIn" datasource="#DSN#">
	update catItems
    set albumStatusID=23, dtDateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
    where shelfID NOT IN (7,11,13) AND dtDateUpdated<<cfqueryparam value="#lastYear#-#todaysDate#" cfsqltype="cf_sql_date"> AND albumStatusID<25 AND ONHAND>0
</cfquery>