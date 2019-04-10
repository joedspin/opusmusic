<cfparam name="form.OOSList" default=""><br />
<cfquery name="finalizeOOS" datasource="#DSN#">
	update catItems
	set ONHAND=0
	where ID IN (#form.OOSList#)
</cfquery>
<cflocation url="catalog.cfm">