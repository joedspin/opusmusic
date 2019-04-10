<cfparam name="url.ID" default="0">
<cfparam name="url.start" default="">
<cfparam name="url.express" default="">
<cfif url.ID NEQ "0">
<cfif url.start EQ "161">
    <cfquery name="markAvail" datasource="#DSN#">
        update orderItems
        set adminAvailID=4, price=cost+.50
        from (orderItems LEFT JOIN catItems ON catItems.ID=orderItems.catItemID)
        where orderID=#url.ID# AND (ONSIDE<1 OR ONSIDE=999) AND adminAvailID=2
    </cfquery>
    <cfquery name="markAvail" datasource="#DSN#">
        update orderItems
        set adminAvailID=5, price=cost+.50
        from (orderItems LEFT JOIN catItems ON catItems.ID=orderItems.catItemID)
        where orderID=#url.ID# AND ONSIDE>0 AND ONSIDE<>999 AND adminAvailID=2
    </cfquery>
<cfelseif express EQ "express">
	<cfquery name="markAvail" datasource="#DSN#">
        update orderItems
        set adminAvailID=4
        from (orderItems LEFT JOIN catItems ON catItems.ID=orderItems.catItemID)
        where orderID=#url.ID# AND (ONSIDE<1 OR ONSIDE=999) AND adminAvailID=2
    </cfquery>
    <cfquery name="markAvail" datasource="#DSN#">
        update orderItems
        set adminAvailID=5
        from (orderItems LEFT JOIN catItems ON catItems.ID=orderItems.catItemID)
        where orderID=#url.ID# AND ONSIDE>0 AND ONSIDE<>999 AND adminAvailID=2
    </cfquery>
<cfelse>
	<cfquery name="markAvail" datasource="#DSN#">
        update orderItems
        set adminAvailID=4
        from (orderItems LEFT JOIN catItems ON catItems.ID=orderItems.catItemID)
        where orderID=#url.ID# AND ONSIDE<1 AND adminAvailID=2
    </cfquery>
    <cfquery name="markAvail" datasource="#DSN#">
        update orderItems
        set adminAvailID=5
        from (orderItems LEFT JOIN catItems ON catItems.ID=orderItems.catItemID)
        where orderID=#url.ID# AND ONSIDE>0  AND adminAvailID=2
    </cfquery>

</cfif>
<cfquery name="updateOrder" datasource="#DSN#">
	update orders
	set issueRaised=<cfqueryparam value="Yes" cfsqltype="cf_sql_bit">, statusID=3, dateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
	where ID=#url.ID#
</cfquery>
</cfif>
<cflocation url="ordersEdit.cfm?ID=#url.ID#&express=#url.express#&start=#url.start#">