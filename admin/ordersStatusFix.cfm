<cfparam name="url.ID" default="0">
<cfquery name="updateStatus" datasource="#DSN#">
	update orders
    set statusID=2
    where ID=#url.ID#
</cfquery>
<cfquery name="updateItemsStatus" datasource="#DSN#">
	update orderItems
    set adminAvailID=2
    where orderID=#url.ID#
</cfquery>
<cfoutput>#url.ID# status changed to 2</cfoutput>