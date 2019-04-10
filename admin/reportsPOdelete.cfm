<cfparam name="url.ID" default="0">
<cfparam name="url.vendorID" default="0">
<cfquery name="delfrompo" datasource="#DSN#">
	delete from
    purchaseOrderDetails
    where POItem_ID=#url.ID#
</cfquery>
<cflocation url="reportsPO.cfm?vendorID=#url.vendorID#">