<cfparam name="url.ID" default="0">
<cfparam name="url.itemID" default="0">
<cfquery name="deletePORow" datasource="#DSN#">
	delete from
    purchaseOrderDetails
    where POItem_ID=#url.ID#
</cfquery>
<cflocation url="catalogEdit.cfm?ID=#url.itemID#">