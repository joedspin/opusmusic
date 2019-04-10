<cfparam name="url.ID" default="0">
<cfparam name="url.notice" default="final">
<cfparam name="url.pageBack" default="orders.cfm">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID# AND orderLock=0
</cfquery>
<cfif thisOrder.recordCount EQ 0>
	<p>Duplicate submission. This order is already being processed.</p><cfabort>
<cfelse>
	<cfquery name="lockTheOrder" datasource="#DSN#">
    	update orders
        set orderLock=1
        where ID=#url.ID#
    </cfquery>
</cfif>
<cfloop query="thisOrder">
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#userCardID#
</cfquery>
<cfif thisCard.ccNum NEQ ""><cfset procDetails="#thisCard.PayAbbrev# ending in #Right(Decrypt(thisCard.ccNum,encryKey71xu),4)#"></cfif>
<cfset paymType=thisCard.ccTypeID>
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#custID#
</cfquery>
<cfquery name="thisShipOption" datasource="#DSN#">
	select *
	from shippingRates
	where ID=#shipID#
</cfquery>
<cfquery name="thisShipping" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#shipAddressID#
</cfquery>
<cfquery name="thisBilling" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#billingAddressID#
</cfquery>
<cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#ID# AND (adminAvailID=4 OR adminAvailID=5) AND shipped=0
</cfquery>
<cfset newStatusID=thisOrder.statusID>
<cfif url.notice EQ "complete" OR url.notice EQ "final" OR url.notice EQ "readypaid">
<cfset newStatusID=6>
<cfset ONSIDEalert="">
<cfloop query="thisItems">
	<!---<cfif adminAvailID EQ 5 AND shipped NEQ 1>
		<cfquery name="updateONSIDE" datasource="#DSN#">
			update catItems
			set ONSIDE=ONSIDE-(#qtyOrdered#)
			where ID=#catItemID#
		</cfquery>
        <cfquery name="fixItemStatus" datasource="#DSN#">
        	update catItems
            set albumStatusID=25
            where albumStatusID=27 AND ONHAND<1 AND ID=#catItemID#
        </cfquery>//--->
        <!---<cfquery name="checkONSIDE" datasource="#DSN#">
        	select *
            from catItemsQuery
            where (ID=#catItemID# AND ONSIDE<5 AND albumStatusID<25 AND ONHAND>0)
        </cfquery>
        <cfloop query="checkONSIDE">
        	<cfset ONSIDEalert=ONSIDEalert&"On the Side: "&ONSIDE&" x ["&catnum&"] "&UCase(label)&" - "&UCase(Left(artist,15))&" - "&UCase(Left(title,15))&"<br>">
        </cfloop>//--->
	<cfif adminAvailID EQ 4 AND shipped NEQ 1>
		<cfquery name="updateONHAND" datasource="#DSN#">
			update catItems
			set ONHAND=ONHAND-(#qtyOrdered#)
			where ID=#catItemID#
		</cfquery>
        <cfquery name="fixItemStatus" datasource="#DSN#">
        	update catItems
            set albumStatusID=25
            where albumStatusID=27 AND ONHAND<1 AND ID=#catItemID#
        </cfquery>
        <cfquery name="logSale" datasource="#DSN#">
        	insert into catSold (qtyOrdered, catItemID, orderID, dateShipped)
            values (#qtyOrdered#,#catItemID#,#orderID#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">)
        </cfquery>
	</cfif>
</cfloop>
<cfquery name="updateOrderItems" datasource="#DSN#">
	update orderItems
	set qtyAvailable=qtyOrdered, adminAvailID=6, adminShipID=adminAvailID, shipped=1
	where orderID=#url.ID# AND (adminAvailID=4 OR adminAvailID=5)
</cfquery>
</cfif>
<cfif url.notice EQ "ready" OR url.notice EQ "readypaid"><cfset pickupInsert="pickupReady=1,"><cfelseif url.notice EQ "moneyorder"><cfset pickupInsert="adminIssueID=1,"><cfelse><cfset pickupInsert=""></cfif>
<cfquery name="updateOrderStatus" datasource="#DSN#">
	update orders
	set statusID=#newStatusID#, #pickupInsert# dateShipped=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
    	dateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
	where ID=#url.ID#
</cfquery>
<cfinclude template="ordersUpdateStatusNotify.cfm">
</cfloop>
<!---<cfif ONSIDEalert NEQ ""><cfmail to="order@downtown304.com" cc="marianne@downtown304.com" from="order@downtown304.com" subject="ONSIDE Alert" type="html"><p>#ONSIDEalert#</p></cfmail></cfif>//--->
<cfquery name="lockTheOrder" datasource="#DSN#">
    	update orders
        set orderLock=0
        where ID=#url.ID#
    </cfquery>
<cflocation url="#url.pageBack#">