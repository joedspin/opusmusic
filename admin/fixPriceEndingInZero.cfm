<cfquery name="fixpz" datasource="#DSN#">
	update catItems
    set price=price-0.30
    where right(price,2)=29 AND price<>0
</cfquery><!---
<cfquery name="fixpz" datasource="#DSN#">
	update catItems
    set priceSave=priceSave-0.01
    where right(priceSave,1)=0 AND priceSave<>0
</cfquery>//--->