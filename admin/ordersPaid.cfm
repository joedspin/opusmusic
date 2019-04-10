<cfparam name="url.ID" default="0">
<cfparam name="url.paid" default="4">
<cfparam name="url.pageBack" default="orders.cfm">
<cfparam name="url.express" default="">
<cfquery name="markPaid" datasource="#DSN#">
	update orders
	set statusID=#url.paid#,
        datePaid=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
        transactionID='Cash/Paypal/Money Order',
        dateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
	where ID=#url.ID#
</cfquery>
<cfif url.express NEQ "">
	<cflocation url="ordersUpdateStatus.cfm?ID=#url.ID#&dateShipped=#DateFormat(varDateODBC,"mm/dd/yy")#&notice=readypaid">
<cfelse>
	<cflocation url="#url.pageBack#?editedID=#url.ID#&editedPaid=#YesNoFormat(url.paid EQ 4)#">
</cfif>