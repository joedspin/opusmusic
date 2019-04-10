<!---<cfquery name="fixBlue" datasource="#DSN#">
	update catItems
    set price=price-.30 where right(price,2)<30 and blue99=1
</cfquery>
<cfquery name="fixBlue" datasource="#DSN#">
	update catItems
    set price=price+29.70 where price<0 and blue99=1
</cfquery>//--->
<cfquery name="fixBlue" datasource="#DSN#">
	update catItems
    set price=price-1 where price>9 and blue99=1
</cfquery>