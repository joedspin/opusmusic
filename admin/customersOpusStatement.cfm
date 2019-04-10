<cfparam name="url.ID" default="0">
<cfquery name="custOrders" datasource="#DSN#">
	select *
	from orders 
	where custID=#url.ID# AND statusID=6
	order by dateStarted
</cfquery>
<table cellpadding="5" cellspacing="0" style="border-collapse:collapse;" border="0">
<cfoutput query="custOrders">
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#custOrders.userCardID#
</cfquery>
<cfquery name="thisCust" datasource="#DSN#">
	select *
    from custAccounts
    where ID=#custOrders.custID#
</cfquery>
<cfset payMethod="">
<cfif thisCard.RecordCount GT 0>
			<cfloop query="thisCard">
				<cfset payMethod=PayAbbrev&" ending in "&Right(ccNum,4)>
			</cfloop>
		 <cfelseif custOrders.paymentTypeID EQ 6><cfif thisCust.isStore><cfset payMethod="Wire / Bank Transfer / PayPal"><cfelse><cfset payMethod="Money Order"></cfif>
		 <cfelseif custOrders.paymentTypeID EQ 7><cfset payMethod="PayPal">
         <cfelse><cfset payMethod="Cash">
		</cfif>
		<cfif orderTotal EQ 0><a href="ordersPay.cfm?ID=#ID#&statement=#url.ID#">#ID#</a> <cfelse>#ID# </cfif>
<cfif orderTotal NEQ 0><tr><td><cfif orderTotal GT 0>Invoice<cfelse>Credit Note</cfif> ###ID#</td><td>#DateFormat(dateShipped,"yyyy-mm-dd")#</td><td align="right">#DollarFormat(orderTotal)#</td><td>#payMethod#</td></tr></cfif>
</cfoutput>
</table>