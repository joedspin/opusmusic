<cfparam name="url.cAdd" default="">
<cfparam name="url.bAdd" default="">
<cfparam name="url.cRemove" default="">
<cfparam name="url.cWish" default="">
<cfparam name="url.ret" default="">
<cfparam name="url.notify" default="">
<cfparam name="Session.userID" default="0">
<cfparam name="url.dos" default="non">
<cfparam name="url.dosp" default="100">
<cfparam name="url.cart" default="checkout">
<cfparam name="Session.isStore" default="false">
<!---<cfparam name="Session.orderID" default="0">
<cfparam name="Session.userID" default="0">
<cfif Session.orderID EQ ""><cfset Session.orderID=0></cfif>//--->
<cfset sendNotify="">
<cfif Session.userID NEQ "0">
	<cfif url.notify NEQ "">
        <cfquery name="lookupEmailNotify" datasource="#DSN#">
            select *
            from notifyMe
            where custID=#Session.userID#
                AND catItemID=<cfqueryparam value="#url.notify#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfif lookupEmailNotify.recordCount EQ 0>
            <cfquery name="emailMeWhenAvailable" datasource="#DSN#">
                insert into notifyMe (custID, catItemID)
                values (#Session.userID#,<cfqueryparam value="#url.notify#" cfsqltype="cf_sql_integer">)
            </cfquery>
        	<cfset sendNotify=url.notify>
            <cfquery name="onorder" datasource="#DSN#">
                select Sum(qtyRequested-qtyReceived) As ONORDER, catItemID
                from purchaseOrderDetails
                where completed=0 AND qtyRequested>qtyReceived AND catItemID=<cfqueryparam value="#url.notify#" cfsqltype="cf_sql_integer">
                group by catItemID
            </cfquery>
            <cfquery name="notifyrequests" datasource="#DSN#">
                select *
                from notifyMe
                where noticeSent=0 AND catItemID=<cfqueryparam value="#url.notify#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfif notifyRequests.recordCount GT onorder.ONORDER>
                <cfquery name="thisItem" datasource="#DSN#">
                    select CATNUM from catItems where ID=<cfqueryparam value="#url.notify#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfmail to="order@downtown304.com" cc="order@downtown304.com" subject="#thisItem.catnum# Email requests exceeded number on order" from="info@downtown304.com" type="html">
                    <a href="http://www.downtown304.com/admin/catalogEdit.cfm?ID=#url.notify#">#thisItem.catnum#</a> Email requests exceeded number on order
                </cfmail>
            </cfif>
        </cfif>
    </cfif>
	<cfif url.cAdd NEQ "" OR url.cRemove NEQ "" OR url.cWish NEQ "" OR url.bAdd NEQ "">
		<cfquery name="openOrder" datasource="#DSN#">
			select *
			from orders
			where (custID=<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer">) AND statusID=1
		</cfquery>
		<cflock scope="session" timeout="20" type="exclusive">
			<cfif openOrder.RecordCount GT 0>
				<cfset Session.orderID=openOrder.ID>
			<cfelse>
				<cfset Session.orderID=0>
			</cfif>
		</cflock>
			<cfif Session.orderID NEQ 0>
				<cfquery name="updateCustOrder" datasource="#DSN#">
					update orders
					set dateUpdated=#varDateODBC#
					where ID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
				</cfquery>
				<cfquery name="thisCustOrder" datasource="#DSN#">
					select *
					from orders
					where ID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
				</cfquery>
			<cfelse>
				<cfquery name="addCustOrder" datasource="#DSN#">
					insert into orders (custID, dateStarted, dateUpdated, statusID)
					values (<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer">,#varDateODBC#,#varDateODBC#,1)
				</cfquery>
				<cfquery name="getNewOrderID" datasource="#DSN#">
					select Max(ID) As MaxID
					from orders
					where custID=<cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_integer"> AND statusID=1
				</cfquery>
				<cflock scope="session" timeout="20" type="exclusive"><cfset Session.orderID=getNewOrderID.MaxID></cflock>
			</cfif>
			<cfif cAdd NEQ "">
				<cfquery name="checkCart" datasource="#DSN#">
					select ID, qtyOrdered
					from orderItems
					where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer"> AND catItemID=<cfqueryparam value="#url.cAdd#" cfsqltype="cf_sql_char">
				</cfquery>
				<cfif checkCart.recordCount GT 0>
					<cfquery name="addToQty" datasource="#DSN#">
						update orderItems
						set qtyOrdered=(#checkCart.qtyOrdered#+1)
						where ID=<cfqueryparam value="#checkCart.ID#" cfsqltype="cf_sql_integer">
					</cfquery>
				<cfelse>
					<cfquery name="getPrice" dbtype="query">
						select price, wholesalePrice
						from Application.dt304Items
						where ID=<cfqueryparam value="#url.cAdd#" cfsqltype="cf_sql_integer">
					</cfquery>
                    <!---<cfif dos EQ "oui" AND dosp NEQ "100">
                    	<cfset useThisPrice=getPrice.price*url.dosp/100>
                        <cfset thisPriceOverride=useThisPrice>
                    <cfelse>//--->
                    	<cfset thisPriceOverride=0>
                        <cfset useThisPrice=0>
                    	<cfset useThisPrice=getPrice.price>
                        <cfif Session.isStore>
                        	<cfset thisPriceOverride=getPrice.wholesalePrice>
                        <cfelseif dos EQ "oui" AND dosp NEQ "100">
							<cfset useThisPrice=getPrice.price*url.dosp/100>
                            <cfset thisPriceOverride=useThisPrice>
						<cfelse>
                        	<cfset thisPriceOverride=0>
						</cfif>
                        <cfif NOT isNumeric(thisPriceOverride)><cfset thisPriceOverride=0></cfif>
                    <!---</cfif>//--->
                    <cfoutput>#thisPriceOverride# #useThisPrice#</cfoutput>
					<cfquery name="addToCart" datasource="#DSN#">
						insert into orderItems (orderID,catItemID,qtyOrdered,price,priceOverride,adminAvailID)
						values (
							<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#url.cAdd#" cfsqltype="cf_sql_char">,
							1,
							<cfqueryparam value="#useThisPrice#" cfsqltype="cf_sql_money">,
                            <cfqueryparam value="#thisPriceOverride#" cfsqltype="cf_sql_money">,
							2
						)
					</cfquery>
				</cfif>
            <cfelseif url.bAdd NEQ "">
            	<cfquery name="moveToCart" datasource="#DSN#">
                	update orderItems
                    set orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">,
                    	adminAvailID=2
                    where ID=<cfqueryparam value="#url.bADD#" cfsqltype="cf_sql_integer">
                </cfquery>
			<cfelseif url.cRemove NEQ "">
				 <!---<cfquery name="checkOrderStatus" datasource="#DSN#">
                	select *
                    from orderItemsQuery
                    where orderItemID=<cfqueryparam value="#url.cRemove#" cfsqltype="cf_sql_char"> 
                </cfquery>
                <cfif checkOrderStatus.recordCount GT 0>//--->
                    <cfquery name="removeFromCart" datasource="#DSN#">
                        delete from orderItems
                        where ID=<cfqueryparam value="#url.cRemove#" cfsqltype="cf_sql_char">
                    </cfquery>
                <!---</cfif>//--->
			<cfelseif cWish NEQ "">
				<cfquery name="thisCartItem" datasource="#DSN#">
					select *
					from orderItems
					where ID=<cfqueryparam value="#url.cWish#" cfsqltype="cf_sql_char">
				</cfquery>
				<cfset thisCatItemID=thisCartItem.catItemID>
				<cfquery name="moveToWishlist" datasource="#DSN#">
					insert into wishList (custID, catItemID, dateAdded)
					values (<cfqueryparam value="0#Session.userID#" cfsqltype="cf_sql_integer">,0#thisCatItemID#,#varDateODBC#)
				</cfquery>
				<cfquery name="removeFromCart" datasource="#DSN#">
					delete from orderItems
					where ID=<cfqueryparam value="#url.cWish#" cfsqltype="cf_sql_char">
				</cfquery>
			</cfif>
			<!---<cfquery name="cartItems" datasource="#DSN#">
				select *
				from orderItems
				where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
			</cfquery>//--->
	</cfif>
<cfelse>
	<cflocation url="opussitelayout07bins.cfm?user=no">
</cfif>
<cfif url.ret EQ "co">
	<cflocation url="checkOut.cfm?cart=#url.cart#">
<cfelse>
	<cflocation url="opussitelayout07bins.cfm?itemID=0#url.cAdd#&notify=#sendNotify#">
</cfif>