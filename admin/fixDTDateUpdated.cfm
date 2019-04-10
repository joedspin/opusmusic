<cfquery name="checkDateUpdated" datasource="#DSN#">
	update catItems
    set dtDateUpdated=<cfqueryparam value="3/13/09" cfsqltype="cf_sql_date">
    where dtDateUpdated='' or dtDateUpdated IS Null
</cfquery>
