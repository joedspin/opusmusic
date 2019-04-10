<cfparam name="form.ID" default="0">
<cfparam name="form.cost" default="0">
<cfparam name="form.price" default="0">
<cfif form.ID NEQ 0>
	<cfquery name="setpriceandcost" datasource="#DSN#">
    	update catItems
        set cost=<cfqueryparam value="#form.cost#" cfsqltype="cf_sql_money">, 
        	price=<cfqueryparam value="#form.price#" cfsqltype="cf_sql_money">
        where ID=#form.ID#
    </cfquery>
</cfif>
<cflocation url="catalog.cfm">
