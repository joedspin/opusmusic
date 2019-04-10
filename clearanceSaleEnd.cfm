<!---<cfquery name="EndClearanceSale" datasource="#DSN#">
	update  catItems
    set price=priceSave, priceSave=0
    where priceSave>0
</cfquery>//--->
<cfquery name="EndWarehouseSale" datasource="#DSN#">
	update catItems
    set specialItem=0, price=cost+2.5, priceSave=0
    where countryID=5
</cfquery>
<!---<cfinclude template="catalogLoadPrices.cfm">//--->