<cfquery name="priceUpdate" datasource="#DSN#">
	select *
	from catItemsQuery
	where (shelfCode='RC' OR shelfCode='JG' OR shelfCode='SM' OR shelfCode='HB') AND price>3.99 AND ID<44000
</cfquery>
<cfoutput query="priceUpdate">
#price# #shelfCode# #catnum# #artist# #title# #NRECSINSET# x #media#<br>
</cfoutput>
<cfquery name="priceUpdate" datasource="#DSN#">
	update catItems
	set price=<cfqueryparam value="3.00" cfsqltype="cf_sql_money">
	where (shelfID=2 OR shelfID=5 OR shelfID=6 OR shelfID=4 OR shelfID=12) AND price>3.99 AND ID<44000
</cfquery>