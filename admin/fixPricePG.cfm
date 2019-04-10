<cfquery name="fixSpecialPG" datasource="#DSN#">
	update catItems
    set cost=3.99, price=6.49, dtDateUpdated=<cfqueryparam value="5/1/2009" cfsqltype="cf_sql_date">
    where specialItem=1
</cfquery>

