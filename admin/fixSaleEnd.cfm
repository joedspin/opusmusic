<cfquery name="endSale" datasource="#DSN#">
	update catItems
	set price=7.39, cost=5.49
	where price=3.99 and cost=2.99 and shelfID<>29 AND NRECSINSET=1
</cfquery>

<cfquery name="endSale" datasource="#DSN#">
	update catItems
	set price=12.59, cost=8.99
	where price=3.99 and cost=2.99 and shelfID<>29 AND NRECSINSET=2
</cfquery>
<cfquery name="endSale" datasource="#DSN#">
	update catItems
	set price=4.99, cost=7.99
	where price=3.99 and cost=2.99 and shelfID=29 AND NRECSINSET=1
</cfquery>
<cfquery name="otherSale"  datasource="#DSN#">
	select *
	from catItemsQuery where price=3.99 and cost=2.99
</cfquery>
<cfoutput query="otherSale">
#shelfID# #shelfCode# #catnum# #label# #artist# #title#<br>
</cfoutput>