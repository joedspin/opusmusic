<cfquery name="thisItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where orderID=51470 AND adminAvailID=2
</cfquery>
<cfloop query="thisItems">
    <cfset thisID=orderItemID>
    <cfset thisWholesale=wholesaleprice>
    <cfquery name="fixbigorder" datasource="#DSN#">
        update orderItems 
        set adminAvailID=4, price=#thisWholesale#
        where adminAvailID=2 AND ID=#thisID#
    </cfquery>
</cfloop>
