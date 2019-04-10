<cfparam name="url.ID" default="0">
<cfquery name="makeCash" datasource="#DSN#">
	update orders
    set paymentTypeID=5
    where ID=#url.ID#
</cfquery>
  <cflocation url="orders.cfm">