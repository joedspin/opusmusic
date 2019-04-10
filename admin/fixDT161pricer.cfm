<cfquery name="dtpricer" datasource="#DSN#">
	select *
    from catItemsQuery
    where shelfID=11 AND albumStatusID<25 AND ONHAND>0
    order by label, catnum
</cfquery>
<cfoutput query="dtpricer">
#catnum# #label# #price# #wholesaleprice# #dtbuy# #cost#<br>
</cfoutput>