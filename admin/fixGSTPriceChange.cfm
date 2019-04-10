<!---<cfquery name="gstpricechange" datasource="#DSN#">
	update catItems
	set wholesalePrice=wholesalePrice+1.00, cost=cost+.50, price=price+1.00
	where (shelfID=2127 AND wholesalePrice=5.99) OR labelID IN (15426,15355,15507) OR (ID IN (69771,61854,86425,41816))
</cfquery>//--->

<cfquery name="gstpricechange" datasource="#DSN#">
	update catItems
	set wholesalePrice=6.99
	where labelID IN (15426,15355)
</cfquery>