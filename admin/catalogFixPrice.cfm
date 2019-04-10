<cfquery name="fixPrice" datasource="#DSN#">
	update catItems
    set price=cost+1.90
    where NRECSINSET=1 AND countryID=1 AND cost<>0 AND title NOT LIKE '%(Promo)%'
</cfquery>
<cfquery name="fixPrice" datasource="#DSN#">
	update catItems
    set price=cost*1.4
    where NRECSINSET>1 AND countryID=1 AND cost<>0 AND title NOT LIKE '%(Promo)%'
</cfquery>
<cfquery name="fixPrice" datasource="#DSN#">
	update catItems
    set price=5.99
    where NRECSINSET=1 AND countryID=1 AND price<5.99
</cfquery>