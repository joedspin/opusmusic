<cfquery name="fixDOUBLEPAKS" datasource="#DSN#">
	update catItems
    set price=9.99, cost=6.99
    where labelID=8107 AND ID<>64866
</cfquery>
<cfquery name="fixDOUBLEPAKS" datasource="#DSN#">
	update catItems
    set price=12.99, cost=9.99
    where labelID=8107 AND ID=64866
</cfquery>