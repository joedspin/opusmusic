<cfparam name="url.ID" default="0">
<cfparam name="url.mergeID" default="0">
<cfparam name="url.pageBack" default="catalog.cfm">
<cfquery name="getTracks" datasource="#DSN#">
	select *
	from catTracks
	where catID=#url.ID# AND mp3Alt=0
</cfquery>
<cfloop query="getTracks">
	<cfdirectory name="checkTrack" directory="#serverPath#/media/" filter="oT#ID#.mp3" action="list">
	<cfif checkTrack.recordCount NEQ 0>
		<cffile action="delete" file="#serverPath#/media/oT#ID#.mp3">
	</cfif>
</cfloop>
<cfquery name="killTracks" datasource="#DSN#">
	delete
	from catTracks
	where catID=#url.ID#
</cfquery>
<cfquery name="updateOrderItems" datasource="#DSN#">
	update orderItems
	set catItemID=#url.mergeID#
	where catItemID=#url.ID#
</cfquery>
<cfquery name="updateOrderItems" datasource="#DSN#">
	update notifyMe
	set catItemID=#url.mergeID#
	where catItemID=#url.ID#
</cfquery>
<cfquery name="killItem" datasource="#DSN#">
	delete
	from catItems
	where ID=#url.ID#
</cfquery>
<cflocation url="catalogEdit.cfm?ID=#url.mergeID#">
