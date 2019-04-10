<cfquery name="fixGeorge" datasource="#DSN#">
	update catItems
    set shelfID=1064, price=8.99, cost=4, wholesalePrice=5.99
    where vendorID=5439 AND buy=5.99
</cfquery>
<cfquery name="fixGeorge" datasource="#DSN#">
	update catItems
    set shelfID=1064, price=9.99, cost=5, wholesalePrice=6.99
    where vendorID=5439 AND buy=6.99
</cfquery>
<cfquery name="fixGeorge" datasource="#DSN#">
	update catItems
    set shelfID=1064
    where vendorID=5439
</cfquery>
<cfquery name="getGeorge" datasource="#DSN#">
	select *
    from catItems
    where shelfID=1064 AND wholesalePrice<>5.99 AND wholesalePrice<>6.99
</cfquery>
<cfoutput query="getGeorge">
#catnum# #price# #cost# #wholesalePrice# #albumStatusID#<br>
</cfoutput>