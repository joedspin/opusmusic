<cfparam name="form.shipID" default="0">
<cfparam name="form.shipOptionID" default="0">
<cfparam name="form.promo" default="">
<cfparam name="form.promoID" default="0">
<cfparam name="Session.orderID" default="0">
<cfset otherSiteID=0>
<cfset thisUserID=NumberFormat(Session.userID,"0000000")>
<cfset checkPromo="">
<cfset thisPromo="">
<cfset setGC="0">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where custID=#thisUserID# AND statusID=1
</cfquery>
<cflock scope="session" timeout="20" type="exclusive">
	<cfset Session.orderID=thisOrder.ID>
</cflock>
<cfif Session.orderID NEQ "0" AND Session.orderID NEQ "" AND Session.orderID NEQ "0000000">
	<cfquery name="cartContents" datasource="#DSN#">
		SELECT * from orderItemsQuery
		where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
		AND adminAvailID=2 AND statusID=1
	</cfquery>
  <cfif form.promoID EQ 0>
	<cfset dopromo=false>
    	<cfset checkPromo=Ucase(Replace(HTMLEditFormat(form.promo)," ",""))>
        <!---<cfif checkPromo EQ ""><cfset checkPromo="VOTE"></cfif>//--->
        <!--- OR ((checkPromo EQ "VINYL2008" OR checkPromo EQ "SOULDEEP") AND DateFormat(varDateODBC,"yyyy-mm-dd") LT "2008-11-01")  OR (checkPromo EQ "DEEPVINYL" AND DateFormat(varDateODBC,"yyyy-mm-dd") LT "2009-01-01")//--->
        <cfif checkPromo EQ "BTVINYL"><cfmail to="judy@downtown161.com" cc="joe@downtown161.com" from="info@downtown304.com" subject="Order placed from Delmar's radio show"></cfmail></cfif>
      <!--- Also see ordersPrintLabels.cfm for the corresponding bit to produce these codes on the packing slips //--->
      <cfif checkPromo EQ "CHART304" OR 
			checkPromo EQ "DT3045" OR  
			(checkPromo EQ "SCARE2013" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2013-11-01") OR 
			(checkPromo EQ "JTD3045" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2015-01-01") OR 
			(checkPromo EQ "DJNY304" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-03-31") OR 
			(checkPromo EQ "NYC304" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-06-30") OR 
			(checkPromo EQ "VIN304" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-09-30") OR 
			(checkPromo EQ "REC304" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-12-31")><!---  OR (checkPromo EQ "VOTE" AND DateFormat(varDateODBC,"yyyy-mm-dd") LT "2008-11-06") OR (DateFormat(varDateODBC,"yyyy-mm-dd") LT "2008-11-06")//--->
		
		<cfloop query="cartContents">
			<cfset itemID=orderItemID>
			<cfquery name="checkPrice" datasource="#DSN#">
				select *
				from catItemsQuery
				where ID=<cfqueryparam value="#catItemID#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfquery name="fixPrice" datasource="#DSN#">
				update orderItems
				set price=<cfqueryparam value="#checkPrice.price#" cfsqltype="cf_sql_money">
				where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_char">
			</cfquery>
		</cfloop>
        <!---<cfquery name="checkAndFixPrice" datasource="#DSN#">
        	update ((orderItems LEFT JOIN catItems ON orderItems.catItemID=catItems.ID) LEFT JOIN orders ON orderItems.orderID=orders.ID)
            set ordersItems.price=catItems.price
            where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
		AND adminAvailID=2 AND statusID=1
        </cfquery>//--->
		<cfif checkPromo EQ "DT3045" OR checkPromo EQ "CHART304" OR checkPromo EQ "JTD3045" OR checkPromo EQ "DOWN503">
        	<cfset doPromo=true>
             <cfloop query="cartContents">
                <cfset itemID=orderItemID>
                <cfif price GT 6.99>
                    <cfquery name="applyDiscount" datasource="#DSN#">
                        update orderItems
                        set price=price*.95
                        where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
                    </cfquery>
                </cfif>
            </cfloop>
			<cfset thisPromo="5% Discount ("&HTMLEditFormat(form.promo)&")">
		<!---<cfelseif checkPromo EQ "VOTE" OR DateFormat(varDateODBC,"yyyy-mm-dd") LT "2008-11-06">
        	<cfloop query="cartContents">
                <cfset itemID=orderItemID>
                <cfquery name="applyDiscount" datasource="#DSN#">
                    update orderItems
                    set price=price*.92
                    where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
                </cfquery>
            </cfloop>
			<cfset thisPromo="8% Discount (HOUSE the VOTE)">//--->
		
		<!---<cfelseif checkPromo EQ "DISCOGSDT">
            <cfset otherSiteID=2>
            <cfset thisPromo="Discogs">
        <cfelseif checkPromo EQ "AMAZONDT">
            <cfset otherSiteID=3>
            <cfset thisPromo="amazon.com">
        <cfelseif checkPromo EQ "MUSICSTACK">
            <cfset otherSiteID=4>
            <cfset thisPromo="MusicStack">//--->
        <cfelse>
        	<cfset doPromo=true>
        	<cfloop query="cartContents">
                <cfset itemID=orderItemID>

                	<cfquery name="applyDiscount" datasource="#DSN#">
                        update orderItems
                        set price=price*.9
                        where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
                    </cfquery>
                    <cfquery name="getThisPrice" datasource="#DSN#">
                    	select *
                        from orderItems
                        where  ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
                    </cfquery>

            </cfloop>
			<cfset thisPromo="10% Discount ("&HTMLEditFormat(form.promo)&")">
		</cfif>
		<!---	(checkPromo EQ "NYDT1112" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2012-11-11") OR
		<cfquery name="cartContents" datasource="#DSN#">
			SELECT * from orderItemsQuery
			where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
			AND adminAvailID=2 AND statusID=1
		</cfquery>//--->
	<!---<cfelseif UCase(HTMLEditFormat(form.promo)) EQ "YOURHOUSE" OR UCase(HTMLEditFormat(form.promo)) EQ "GOALSOUL" OR Ucase(HTMLEditFormat(form.promo)) EQ "304VIBE">
		<cfset thisPromo="Promo code expired.">//--->
	<!---<cfelseif checkPromo EQ "JUDYJUDY">
		<cfloop query="cartContents">
			<cfset itemID=orderItemID>
			<cfquery name="checkPrice" dbtype="query">
				select *
				from Application.dt304Items
				where ID=<cfqueryparam value="#catItemID#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfquery name="fixPrice" datasource="#DSN#">
				update orderItems
				set price=<cfqueryparam value="#checkPrice.price-1.00#" cfsqltype="cf_sql_money">
				where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
			</cfquery>
		</cfloop>
		<cfquery name="cartContents" datasource="#DSN#">
			SELECT * from orderItemsQuery
			where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
			AND adminAvailID=2 AND statusID=1
		</cfquery>
		<cfset thisPromo="$1.00 Discount">//--->
    <cfelseif (checkPromo EQ "NYDT1112" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2012-11-11")>
        	<cfloop query="cartContents">
                <cfset itemID=orderItemID>
                	<cfquery name="applyDiscount" datasource="#DSN#">
                        update orderItems
                        set price=price*.9
                        where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
                    </cfquery>
            </cfloop>
			<cfset thisPromo="10% Discount ("&HTMLEditFormat(form.promo)&")">
			
	<cfelseif UCase(HTMLEditFormat(form.promo)) EQ "STORE304">
		<cfloop query="cartContents">
			<cfset itemID=orderItemID>
			<cfquery name="checkPrice" dbtype="query">
				select *
				from Application.dt304Items
				where ID=<cfqueryparam value="#catItemID#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfquery name="fixPrice" datasource="#DSN#">
				update orderItems
				set price=<cfqueryparam value="#checkPrice.price-1.25#" cfsqltype="cf_sql_integer">
				where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
			</cfquery>
		</cfloop>
		<cfquery name="cartContents" datasource="#DSN#">
			SELECT * from orderItemsQuery
			where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
			AND adminAvailID=2 AND statusID=1
		</cfquery>
		<cfset thisPromo="Wholesale Price-point">
    <!---<cfelseif UCase(HTMLEditFormat(form.promo)) EQ "IMPORT599">
		<cfloop query="cartContents">
			<cfset itemID=orderItemID>
			<cfquery name="fixPrice" datasource="#DSN#">
				update orderItems
				set price=5.99
				where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
			</cfquery>
		</cfloop>
		<cfquery name="cartContents" datasource="#DSN#">
			SELECT * from orderItemsQuery
			where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
			AND adminAvailID=2 AND statusID=1
		</cfquery>
		<cfset thisPromo="Prices Set to $5.99 - Import Sale">//--->
	<cfelseif UCase(HTMLEditFormat(form.promo)) EQ "STORESTORE">
		<cfloop query="cartContents">
			<cfset itemID=orderItemID>
			<cfquery name="checkPrice" dbtype="query">
				select *
				from Application.dt304Items
				where ID=<cfqueryparam value="#catItemID#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfquery name="fixPrice" datasource="#DSN#">
				update orderItems
				set price=<cfqueryparam value="#checkPrice.cost+1.50#" cfsqltype="cf_sql_money">
				where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
			</cfquery>
		</cfloop>
		<cfquery name="cartContents" datasource="#DSN#">
			SELECT * from orderItemsQuery
			where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
			AND adminAvailID=2 AND statusID=1
		</cfquery>
		<cfset thisPromo="Store Discount">
	<!---<cfelseif UCase(HTMLEditFormat(form.promo)) EQ "LINDALIN" OR Session.userID EQ 2342>
		<cfloop query="cartContents">
			<cfset itemID=orderItemID>
			<cfquery name="checkPrice" dbtype="query">
				select *
				from Application.dt304Items
				where ID=<cfqueryparam value="#catItemID#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfquery name="fixPrice" datasource="#DSN#">
				update orderItems
				set price=<cfqueryparam value="#checkPrice.cost#" cfsqltype="cf_sql_money">
				where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
			</cfquery>
		</cfloop>
		
		<cfset thisPromo="Downtown 161 discount (NO MARKUP)">//--->
	<!--- THIS LINE WAS USED TO PASS THROUGH THE WMC CD CODES
	<cfelseif HTMLEditFormat(form.promo) NEQ "">
		<cfset thisPromo=HTMLEditFormat(form.promo)>//--->
	<cfelseif HTMLEditFormat(form.promo) NEQ "" AND IsNumeric(left(form.promo,4))>
		<cfset thisPromo="not valid">
		<cfquery name="lookupGC" datasource="#DSN#">
        	select * from giftCertificates
            where ID=<cfqueryparam value="#left(form.promo,4)#" cfsqltype="cf_sql_char"> AND gcCode=<cfqueryparam value="#form.promo#" cfsqltype="cf_sql_char">
        </cfquery>
		<cfloop query="lookupGC">
        	<cfif gcCurrentAmount GT 0>
            	<cfset thisPromo="Gift Certificate">
                <cfset setGC=ID>
                <cfmail to="order@downtown304.com" from="info@downtown304.com" subject="Gift Certificate Redeemed">Order ###Session.orderID#</cfmail>
            </cfif>
        </cfloop>
	<cfelse>
		<cfset thisPromo="">
	</cfif>
<!---<cfelseif form.promoID GT 0 AND IsNumeric(form.promoID)>
	<cfquery name="clearPromoItemFromCart" datasource="#DSN#">
    	delete
        from orderItems
        where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer"> AND adminAvailID=2 AND ((catItemID>=49118 AND catItemID<=49122) OR (catItemID IN (44545,44547,44581,44582,44584,44585,44586,44587)) OR (catItemID>=54297 AND catItemID<=54301))
    </cfquery>
    <cfif form.promoID LT 10><!--- WMC 2008 series //--->
		<cfset CDitemID=49117+#form.promoID#>
        <cfset thisPromo="Free WMC 2008 CD0"&form.promoID>
      <cfelseif form.promoID LT 19><!--- WMC 2007 series //--->
      	<cfset promoID07=form.promoID-10>
        <cfset thisPromo="Free WMC 2007 CD0"&#promoID07#>
		<cfif form.promoID EQ 11>
            <cfset CDitemID=44545>
        <cfelseif form.promoID EQ 12>
            <cfset CDitemID=44547>
        <cfelseif form.promoID EQ 13>
            <cfset CDitemID=44581>
        <cfelseif form.promoID EQ 14>
            <cfset CDitemID=44582>
        <cfelseif form.promoID EQ 15>
            <cfset CDitemID=44584>
        <cfelseif form.promoID EQ 16>
            <cfset CDitemID=44585>
        <cfelseif form.promoID EQ 17>
            <cfset CDitemID=44586>
        <cfelseif form.promoID EQ 18>
            <cfset CDitemID=44587>
        </cfif>
       <cfelse><!--- WMC 2009 series //--->
       	<cfset CDitemID=#form.promoID#>
        <cfset CDVolume=#form.promoID#-54296>
        <cfset thisPromo="Free Downtown Underground 2009 CD Volume "&CDVolume>
    </cfif>
    <cfquery name="addToCart" datasource="#DSN#">
        insert into orderItems (orderID,catItemID,qtyOrdered,price,priceOverride,adminAvailID)
        values (
            <cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">,
            <cfqueryparam value="#CDitemID#" cfsqltype="cf_sql_char">,
            1,
            <cfqueryparam value="0.00" cfsqltype="cf_sql_money">,
            <cfqueryparam value="0.00" cfsqltype="cf_sql_money">,
            2
        )
    </cfquery>
    <cfset dopromo=true>//--->
</cfif>
    <!--
<cfquery name="setSalePrices" datasource="#DSN#">
    UPDATE orderItems
    set price=priceOverride
        from (orderItems LEFT JOIN orders ON orderItems.orderID=orders.ID)
    where priceOverride<>0 AND orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer"> AND adminAvailID=2 AND statusID=1
</cfquery>//-->
<cfquery name="cartContents" datasource="#DSN#">
        SELECT * from orderItemsQuery
        where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
        AND adminAvailID=2 AND statusID=1
    </cfquery>
	<cfset thisSub=0>
	<cfset vinylCount=0>
	<cfset cdCount=0>
	<cfset shipmentWeight=0.5>
	<cfloop query="cartContents">
		<cfif weightException GT 0>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weightException*qtyOrdered)>
		<cfelse>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weight*qtyOrdered)>
		</cfif>
		<cfif mediaID EQ 1 OR mediaID EQ 5 OR mediaID EQ 9>
			<cfset vinylCount=vinylCount+(NRECSINSET*qtyOrdered)>
		<cfelse>
			<cfset cdCount=cdCount+(NRECSINSET*qtyOrdered)>
		</cfif>
		<cfset thisSub=thisSub+(qtyOrdered*price)>
	</cfloop>
	<cfquery name="shipOptions" dbtype="query">
		select *
		from Application.allShipOptions
		where ID=<cfqueryparam value="#form.shipOptionID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfif shipOptions.recordCount EQ 0>
		<cfquery name="shipOptions" dbtype="query">
			select *
			from Application.allShipOptions
			where countryID=2
			order by cost1Record DESC
		</cfquery>
	</cfif>
	<cfloop query="shipOptions">
		<cfset shipCost=0>
        <cfif Find('UPS',shipOptions.name) GT 0><cfset isUPS=true><cfelse><cfset isUPS=false></cfif>
		<cfif (vinylCount+cdCount GTE minimumItems) AND ((vinylCount+cdCount LTE maximumItems) OR (maximumItems EQ 0)) AND (shipmentWeight GTE minimumWeight) AND ((shipmentWeight LTE maximumWeight) OR (maximumWeight EQ 0))>
			<cfif vinylCount GT 0>
				<cfset shipCost=shipCost+cost1Record+(costplusrecord*(vinylCount-1))>
				<cfif cdCount GT 0>
					<cfset shipCost=shipCost+(costpluscd*(cdCount-1))>
				</cfif>
			<cfelse>
				<cfif cdCount GT 0>
					<cfset shipCost=shipCost+cost1CD+(costpluscd*(cdCount-1))>
				</cfif>
			</cfif>
		</cfif>
	</cfloop>
    <cfif checkPromo EQ "SHIP50">
		<cfset shipCost=Replace(DollarFormat(shipCost/2),"$","","all")>
		<cfset thisPromo="50% Off Shipping ("&HTMLEditFormat(form.promo)&")">
        <cfset dopromo=true>
    <cfelseif checkPromo EQ "SHIPJOEFREE">
    	<cfset shipCost=0>
		<cfset thisPromo="FREE Shipping ("&HTMLEditFormat(form.promo)&")">
        <cfset dopromo=true>
	</cfif>
    <!--- THIS BLOCK OF CODE (along with a similar one in checkOutShip.cfm produces the FREE SHIPPING/$5 OFF deal//--->
    <!--- CURRENTLY ONLY FREE MEDIA MAIL SHIPPING IS ENABLED...NOTE THAT $5 OFF OTHER METHOD IS COMMENTED OUT BELOW //--->
	<cfif DateFormat(varDateODBC,"yyyy-mm-dd") GTE "2012-10-04">
		<cfif shipCost GT 0 and form.shipOrderSub GTE 50>
            <cfif form.shipOptionID EQ 1>
                <cfset shipCost=0>
            <!---<cfelseif shipOrderSub GT 5.00>
                <cfset shipCost=shipCost-5>//--->
            <cfset checkPromo="FREESHIPPING">
            <cfset thisPromo="Free Shipping">
            <cfset doPromo=true>
            </cfif>
         </cfif>
        </cfif><!---//--->
	 <!--- END FREE SHIPPING BLOCK //--->
     <!--- THIS BLOCK OF CODE (along with a similar one in checkOutShip.cfm produces the FREE SHIPPING/$5 OFF deal
	<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2009-08-31">
		<cfif shipCost GT 0 and thisSub GTE 50 AND isUPS>
            <cfif form.shipOptionID EQ 1>
                <cfset shipCost=0>
            <cfelseif thisSub LT 75>
                <cfset shipCost=shipCost*.95>
            <cfelse>
            	<cfset shipCost=shipCost*.90>
            </cfif>
            <cfset checkPromo="UPS SHIPPING SPECIAL">
            <cfset thisPromo="Summer Madness UPS Shipping Special">
            <cfset doPromo=true>
         </cfif>
        </cfif>
	 END FREE SHIPPING BLOCK //--->
	<cfquery name="thisShipAddress" datasource="#DSN#">
		select *
		from custAddresses
		where ID=<cfqueryparam value="#form.shipID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfif thisShipAddress.countryID EQ 1 AND thisShipAddress.stateID EQ 39><!--- If shipping to NY State, add sales tax //--->
		<cfset thisTax=NumberFormat((.08875*(shipCost+thisSub)),"0.00")>
	<cfelse>
		<cfset thisTax=0>
	</cfif>
	<cfset thisTotal=thisSub+shipCost+thisTax>

	<cfquery name="updateOrder" datasource="#DSN#">
		update orders
		set
			orderSub=<cfqueryparam value="#thisSub#" cfsqltype="cf_sql_money">,
			orderShipping=<cfqueryparam value="#shipCost#" cfsqltype="cf_sql_money">,
			orderTax=<cfqueryparam value="#thisTax#" cfsqltype="cf_sql_money">,
			orderTotal=<cfqueryparam value="#thisTotal#" cfsqltype="cf_sql_money">,
			shipID=<cfqueryparam value="#form.shipOptionID#" cfsqltype="cf_sql_char">,
			shipAddressID=<cfqueryparam value="#form.shipID#" cfsqltype="cf_sql_char">,
            specialInstructions=<cfqueryparam value="#thisPromo#" cfsqltype="cf_sql_longvarchar">,
            promoCode=<cfqueryparam value="#checkPromo#" cfsqltype="cf_sql_char">,
            otherSiteID=#otherSiteID#,
            gcNum=#setGC#
		where ID=<cfqueryparam value="#cartContents.orderID#" cfsqltype="cf_sql_integer">
	</cfquery>
<cfelse>
	<p>Your login to Downtown 304 has timed out, before you can check out you must log in again.</p><p><a href="http://www.downtown304.com/index.cfm?logout=true">Click here</a> to go back to the home page and try again.</p>
</cfif>
<cfquery name="cartContents" datasource="#DSN#">
			SELECT *
			FROM orderItemsQuery
			where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
		</cfquery><cfoutput query="cartContents">#price#</cfoutput><cfabort>
<cfif form.shipID NEQ 0>
	<cfif form.shipOptionID EQ 64 OR otherSiteID GT 0 OR checkPromo EQ "SHOWCASH"><cfset cashok=1><cfelse><cfset cashok=0></cfif>
    <cfif cashok EQ 0>
		<cflocation url="checkOutBill.cfm?shipID=#form.shipID#&shipOptionID=#form.shipOptionID#&thisPromo=#URLEncodedFormat(thisPromo)#">
        <cfelse>
        <cflocation url="checkOutBill.cfm?shipID=#form.shipID#&shipOptionID=#form.shipOptionID#&thisPromo=#URLEncodedFormat(thisPromo)#&cshok=true">
        </cfif>
<cfelse>
	<cflocation url="checkOut.cfm">
</cfif>