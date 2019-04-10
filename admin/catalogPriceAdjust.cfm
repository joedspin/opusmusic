<cfquery name="PriceAdjust" datasource="#DSN#">
	select *
	from catItemsQuery
	where price><cfqueryparam value="4.00" cfsqltype="cf_sql_money"> AND 
	(shelfID=1 OR shelfID=2 OR shelfID=4 OR shelfID=5 OR shelfID=6)
</cfquery>
<cfoutput query="PriceAdjust">
#artist# | #title# | #DollarFormat(price)# | #media#<br />
</cfoutput>
<cfquery name="PriceAdjust" datasource="#DSN#">
	update catItems
	set price=<cfqueryparam value="4.00" cfsqltype="cf_sql_money">
	where price><cfqueryparam value="4.00" cfsqltype="cf_sql_money"> AND 
	(shelfID=1 OR shelfID=2 OR shelfID=4 OR shelfID=5 OR shelfID=6)
</cfquery>
