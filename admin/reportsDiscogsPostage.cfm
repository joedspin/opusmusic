<cfparam name="url.getdate" default="">
<cfif url.getdate NEQ "">
<cfquery name="getDiscogsPostage" datasource="#DSN#">
	select *
    from orders
    where dateShipped>'#DateFormat(url.getdate,"yyyy-mm-dd")#' AND dateShipped<'#DateFormat(varDateODBC,"yyyy-mm-dd")#' AND otherSiteID=2
</cfquery>
<cfelse>
<cfquery name="getDiscogsPostage" datasource="#DSN#">
	select *
    from orders
    where dateShipped>'#DateFormat(DateAdd('d',-7,varDateODBC),"yyyy-mm-dd")#' AND otherSiteID=2
</cfquery>
</cfif>
<cfset shippingTotal=0><p>
<cfoutput query="getDiscogsPostage">
Order ###ID# - Shipped #DateFormat(dateShipped,"yyyy-mm-dd")# #DollarFormat(orderShipping)# <cfif orderShipping EQ 0><a href="ordersPay.cfm?ID=#ID#&printonly=true&calc=return&getDate=#url.getDate#">calculate shipping</a></cfif><br>
<cfset shippingTotal=shippingTotal+orderShipping>
</cfoutput></p>
<cfoutput><b>Shipping Total: #DollarFormat(shippingTotal)#</b></cfoutput>