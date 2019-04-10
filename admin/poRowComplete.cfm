<cfparam name="url.ID" default="0">
<cfparam name="url.itemID" default="0">
<cfquery name="deletePORow" datasource="#DSN#">
	update purchaseOrderDetails
    set completed=1
    where POItem_ID=#url.ID#
</cfquery>
<cflocation url="catalogEdit.cfm?ID=#url.itemID#">