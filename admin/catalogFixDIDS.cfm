<cfquery name="DIInventory" datasource="#DSN#">
	select *
	from catItemsQuery
	where shelfID=11 or shelfID=8
</cfquery>
<cfloop query="DIInventory">
	<cfquery name="DTfind" datasource="#DSN#">
		select *
		from catItemsQuery
		where catnum='#DIInventory.catnum#' AND shelfID=7
	</cfquery>
	<cfif DTfind.RecordCount GT 0>
		<cfquery name="fixDI" datasource="#DSN#">
			update catItems
			set dtID=#DTfind.dtID#, 
				cost=<cfqueryparam value="#DTfind.cost#" cfsqltype="cf_sql_money">,
				price=<cfqueryparam value="#NumberFormat(((DTfind.cost*.38)+DTfind.cost),"0.00")#" cfsqltype="cf_sql_money">,
				ONHAND=#DTfind.ONHAND#
			where ID=#DIInventory.ID#
		</cfquery>
	</cfif>
</cfloop>