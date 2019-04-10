<cfparam name="url.ID" default="0">
<cfparam name="url.custID" default="0">
<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<cfquery name="allCustOrders" datasource="#DSN#">
	select *
	from orders
	where statusID<6 AND statusID>1 AND custID=#url.custID# AND ID<>#url.ID# AND paymentTypeID<>7
</cfquery>
<cfquery name="masterCustOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfif allCustOrders.recordCount EQ 0>
	<p>This order can't be merged: there are no other open orders for this customer.<br />
	Note that orders with payment type PayPal can't be merged.<br />
	<a href="orders.cfm">Continue</a></p>
<cfelse>
	<cfset alreadyOutputOne=false>
    <p>Merge these orders: 
	<cfset mergedInstrux=Trim(masterCustOrder.specialInstructions)>
    <cfloop query="allCustOrders">
    	<cfset mergedInstrux=Trim(mergedInstrux)&" "&Trim(specialInstructions)>
		<cfset thisID=ID>
        <cfoutput><cfif alreadyOutputOne>, </cfif>#thisID#</cfoutput>
        <cfset alreadyOutputOne=true>
		<cfquery name="mergeOrders" datasource="#DSN#">
			update orderItems
			set orderID=#url.ID# where orderID=#thisID#
		</cfquery>
		<cfquery name="closeOrder" datasource="#DSN#">
			update orders
			set statusID=7
			where ID=#thisID#
		</cfquery>
	</cfloop>
    <cfquery name="mergeOrders" datasource="#DSN#">
        update orders
        set orderSub=0, orderTax=0, orderShipping=0, orderTotal=0, issueResolved=0, specialInstructions='#mergedInstrux#'
        where ID=#url.ID#
    </cfquery>
    </p>
</cfif>
<p><font color="yellow">Merge Completed</font></p>
<p><a href="orders.cfm">Continue</a></p>
<p>&nbsp;</p>
<cfinclude template="pageFoot.cfm">
<cflocation url="orders.cfm">