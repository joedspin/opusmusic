<cfparam name="url.ID" default="">
<cfquery name="BSitem" datasource="#DSN#">
	update catItems
    set price=4.99, shelfID=29, dtDateUpdated=#varDateODBC#, albumStatusID=23
    where ID=#url.ID#
</cfquery>
<cflocation url="#url.pageBack#">
