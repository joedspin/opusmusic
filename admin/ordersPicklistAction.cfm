<cfparam name="form.availList" default="">
<cfif form.availList NEQ "">
<cfquery name="markAvail" datasource="#DSN#">
	update orderItems
	set adminAvailID=4
	where ID in (#form.availList#)
</cfquery>
</cfif>
<cflocation url="orders.cfm">