<cfquery name="fixBS" datasource="#DSN#">
	update catItems
    set price=(cost+3.00)/2
    where shelfID=29
</cfquery>
<cfquery name="fixBStoolow" datasource="#DSN#">
	update catItems
    set price=0.99 where price<0.99 and shelfID=29
</cfquery>
<!---<cfquery name="fixBS" datasource="#DSN#">
	update catItems
    set price=cost+1.9
    where cost=3.49 and buy<>3.49
</cfquery>//--->