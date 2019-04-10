<cfquery name="clearPO" datasource="#DSN#">
	update purchaseOrderDetails
    set completed=1
    where vendorID=21
</cfquery>