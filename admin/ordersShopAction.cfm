<cfparam name="url.orderID" default="0">
<cfparam name="url.itemID" default="0">
<cfparam name="form.orderID" default="#url.orderID#">
<cfparam name="form.itemID" default="#url.itemID#">
<cfparam name="form.itemIsDT" default="no">
<cfparam name="form.isVM" default="0">
<cfparam name="form.isStore" default="0">
<cfparam name="form.issueRaised" default="0">
<cfparam name="form.otherSiteID" default="0">
<cfparam name="form.addQty#form.itemID#" default="1">
<cfparam name="form.priceCheck" default="no">
<cfset cookie.priceCheck=form.priceCheck>
<cfquery name="checkOrder" datasource="#DSN#">
	select *
    from orderItemsQuery
    where orderID=#form.orderID# AND catItemID=#form.itemID#
</cfquery>
<cfquery name="getPrice" dbtype="query">
        select price, cost, buy, wholesalePrice, NRECSINSET
        from allItems
        where ID=#form.itemID#
    </cfquery>
	<cfset thisPriceOverride=0>
    <!---<cfif form.itemIsDT EQ "yes" AND form.isVM EQ "1">
    	<cfset thisUnitPrice=getPrice.buy*1.3>
		<cfset thisPriceOverride=thisUnitPrice>//--->
    <cfif form.isStore AND getPrice.wholeSalePrice LTE getPrice.price>
    	<cfset thisUnitPrice=getPrice.wholesalePrice>
    <cfelseif otherSiteID EQ 2><!--- Discogs price increase //--->
    	<cfset thisUnitPrice=getPrice.price+getPrice.NRECSINSET>
     <cfelse>
    	<cfset thisUnitPrice=getPrice.price>
    </cfif>
<cfif form.issueRaised EQ 1><cfset newStat=4><cfelse><cfset newStat=2></cfif>
<cfif checkOrder.recordCount EQ 0>
    <cfquery name="addToOrder" datasource="#DSN#">
        insert into orderItems (orderID,catItemID,qtyOrdered,price,priceOverride,adminAvailID)
        values (
            #form.orderID#,
            <cfqueryparam value="#form.itemID#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#Evaluate('form.addQty'&form.itemID)#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#thisUnitPrice#" cfsqltype="cf_sql_money">,
            <cfqueryparam value="#thisPriceOverride#" cfsqltype="cf_sql_money">,
            #newStat#
        )
    </cfquery>
<cfelse>
	<cfquery name="updateOrder" datasource="#DSN#">
    	update orderItems
        set qtyOrdered=qtyOrdered+<cfqueryparam value="#Evaluate('form.addQty'&form.itemID)#" cfsqltype="cf_sql_char">
        where catItemID=<cfqueryparam value="#form.itemID#" cfsqltype="cf_sql_char"> AND orderID=#form.orderID#
    </cfquery>
</cfif>
<cfquery name="updateOrder" datasource="#DSN#">
	update orders
    set issueResolved=0
    where issueResolved=1 AND ID=#form.orderID#
</cfquery>
<cfquery name="getCust" datasource="#DSN#">
	select custID
    from orders
    where ID=#form.orderID#
</cfquery>
		
<cfif getCust.custID EQ 21116><cfset priceToCheck=NumberFormat(thisUnitPrice*.98,'_.__')><cfset otherPriceToCheck=NumberFormat((thisUnitPrice-.5)*.98,'_.__')><cfelse><cfset priceToCheck=thisUnitPrice><cfset otherPriceToCheck=thisUnitPrice></cfif>

<cfquery name="checkPreviousPricePaid" datasource="#DSN#">
	select orderID, catItemID, shelfID, price, dateShipped, orderItemID as prevItemID
    from orderItemsQuery
    where orderID<#form.orderID# AND catItemID=#form.itemID# AND custID=#getCust.custID# AND price<#priceToCheck# AND price<>0 AND ignoreHistory=0 AND price<>#otherPriceToCheck#
    order by dateShipped DESC
</cfquery>
<cfif checkPreviousPricePaid.recordCount NEQ 0 AND cookie.priceCheck EQ "yes">
	<p>This customer previously paid a lower price for this item.<br>
    Choose the price to charge on the new order:</p>
    <blockquote>
<cfoutput>
    <form action="ordersShop.cfm" method="post">
    <p>Other: <input type="text" size="15" name="resetPrice"><input type="submit" name="submit" value="Set"></p>
    <input type="hidden" name="orderID" value="#form.orderID#">
    <input type="hidden" name="itemID" value="#form.itemID#">
    </form>
    <p>Current Price <a href="ordersShop.cfm?orderID=#form.orderID#&itemID=#form.itemID#&addQty=#Evaluate('form.addQty'&form.itemID)#">#DollarFormat(thisUnitPrice)#</a></p>
</cfoutput>
<cfset ignoreAll="">
<cfoutput query="checkPreviousPricePaid">
	<p><a target="_blank" href="ordersEdit.cfm?ID=#orderID#">#orderID#</a> #DateFormat(dateShipped,"yyyy-mm-dd")# <a href="ordersShop.cfm?orderID=#form.orderID#&itemID=#form.itemID#&addQty=#Evaluate('form.addQty'&form.itemID)#&resetPrice=#price#">#DollarFormat(price)#</a> <a href="ordersShopIgnoreHistoryFlag.cfm?prevItemID=#prevItemID#" target="_blank">Ignore</a></p>
<cfset ignoreAll=ignoreAll&","&prevItemID>
</cfoutput>
<cfset ignoreAll=Right(ignoreAll,Len(ignoreAll)-1)>
	<cfoutput><p><a href="ordersShopIgnoreHistoryFlag.cfm?ignoreAll=#ignoreAll#" target="_blank">Ignore All</a></p></cfoutput>
</blockquote>
<cfelse>
<cflocation url="ordersShop.cfm?orderID=#form.orderID#&itemID=#form.itemID#&addQty=#Evaluate('form.addQty'&form.itemID)#">
</cfif>