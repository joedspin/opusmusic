<cfparam name="form.newcustuserrname" default="">
<cfparam name="form.orderID" default="0">
<cfif form.newcustusername EQ "">ERROR: Username is required<cfabort></cfif>
"<cfquery name="findCustomer" datasource="#DSN#">
	select *
    from custAccounts
    where username='#form.newcustusername#'
</cfquery>
<cfif findCustomer.recordCount EQ 0>ERROR: Username not found.<cfabort></cfif>
<cfquery name="changeCust" datasource="#DSN#">
	update orders
    set custID=#findCustomer.ID#
    where ID=#form.orderID#
</cfquery>
<cflocation url="ordersEdit.cfm?ID=#form.orderID#">