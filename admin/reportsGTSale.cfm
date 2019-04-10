<cfquery name="gtsale" datasource="#DSN#">
	select * from catItemsquery where vendorID=5439 AND NRECSINSET=1 AND mediaID=1
</cfquery>
<cfoutput query="gtsale">
#catnum# - #NRECSINSET# - #price# - #cost#<br />
</cfoutput>
<cfquery name="gtSale" datasource="#DSN#">
	update catItems
    set price=5.99, cost=3.99
    where vendorID=5439 AND NRECSINSET=1 AND mediaID=1
</cfquery>