<cfparam name="form.shipID" default="0">
<cfparam name="form.shipOptionID" default="0">
<cfparam name="form.promo" default="">
<cfparam name="form.promoID" default="0">
<cfparam name="form.tickets" default="no">
<cfparam name="form.usingGenericShippingForCountry" default="no">
<cfparam name="form.countryCount" default="1">
<cfparam name="Session.orderID" default="0">
<cfset otherSiteID=0>
<cfset thisUserID=NumberFormat(Session.userID,"0000000")>
<cfset checkPromo="">
<cfset thisPromo="">
<cfset setGC="0">

<cfquery name="addressCheck" datasource="#DSN#">
	select countryID
	from custAddressesQuery
	where ID=<cfqueryparam value="#form.shipID#" cfsqltype="integer">
	order by useFirst DESC
</cfquery>
<cfquery name="optionCheck" datasource="#DSN#">
    select countryID
    from shippingRates
    where ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#form.shipOptionID#">
</cfquery>
<cfif addressCheck.countryID NEQ optionCheck.countryID AND optionCheck.countryID NEQ 3><cflocation URL="checkOutShip.cfm?countryError=yes"></cfif>



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
      <!--- Also see ordersPrintLabels.cfm for the corresponding bit to produce these codes on the packing slips //--->
      <!--- checkPromo EQ "CHART304" OR 
			checkPromo EQ "DT3045" OR //--->
      <cfif NOT Session.isStore AND ((UCase(Trim(Replace(checkPromo," ","","all"))) EQ "CYBER18" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2018-11-28") OR
			(UCase(Trim(checkPromo)) EQ "CYBER2018" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2018-11-28") OR
			(UCase(Trim(checkPromo)) EQ "THANK5" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2016-03-15"))>
			<!---
	   OR (checkPromo EQ "NYC304" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-06-30" AND DateFormat(varDateODBC,"yyyy-mm-dd") GTE "#DateFormat(varDateODBC,"yyyy")#-04-01") OR 
			(checkPromo EQ "VIN304" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-09-30" AND DateFormat(varDateODBC,"yyyy-mm-dd") GTE "#DateFormat(varDateODBC,"yyyy")#-07-01") OR 
			(checkPromo EQ "REC304" AND DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-12-31" AND DateFormat(varDateODBC,"yyyy-mm-dd") GTE "#DateFormat(varDateODBC,"yyyy")#-10-01")
	  //--->
		
		    <cfloop query="cartContents">
			<cfset itemID=orderItemID>
			<cfquery name="checkPrice" datasource="#DSN#">
				select *
				from catItemsQuery
				where ID=<cfqueryparam value="#catItemID#" cfsqltype="cf_sql_integer">
			</cfquery>
            <!--- add this block specifically for the "LONGER THINGS" sale to allow compounded discount with coupon code. This query usually erases special prices when a coupon code is applied //--->
            <cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2016-10-02">
                <cfquery name="fixPrice" datasource="#DSN#">
                    update orderItems
                    set price=<cfqueryparam value="#checkPrice.price#" cfsqltype="cf_sql_money">
                    where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_char"> AND priceOverride=0
                </cfquery>
            <cfelse>
            <!--- ENDING LONGER THINGS BLOCK//--->
                <cfquery name="fixPrice" datasource="#DSN#">
                    update orderItems
                    set price=<cfqueryparam value="#checkPrice.price#" cfsqltype="cf_sql_money">
                    where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_char">
                </cfquery>
            </cfif>
		</cfloop>
        <cfinclude template="cartGetContents.cfm">
		<cfif UCase(Trim(Replace(checkPromo," ","","all"))) EQ "CYBER18" OR UCase(Trim(Replace(checkPromo," ","","all"))) EQ "CYBER2018">
        	<cfquery name="strippromo" datasource="#DSN#">
                delete from orderItems
                where catItemID=74648
                    AND orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
            </cfquery>
        	<cfset orderSubTAKE=0>
        	<cfloop query="cartContents">
            	<cfset orderSubTAKE=orderSubTAKE+(price*qtyOrdered)>
            </cfloop>
            <cfset orderSubTAKE=orderSubTAKE*-.15>
            <cfoutput>#orderSubTake#</cfoutput>
            <cfquery name="addDiscountItem" datasource="#DSN#">
            	insert into orderItems (orderID,catItemID,qtyOrdered,price,priceOverride,adminAvailID)
						values (
							<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="74648" cfsqltype="cf_sql_char">,
							1,
							<cfqueryparam value="#orderSubTake#" cfsqltype="cf_sql_money">,
                            <cfqueryparam value="#orderSubTake#" cfsqltype="cf_sql_money">,
							2)
            </cfquery>
            <cfset thisPromo="15% Discount ("&HTMLEditFormat(form.promo)&")"><br>
		<cfelseif checkPromo EQ "GIFT15JOE">
        	<cfset doPromo=true>
             <cfloop query="cartContents">
                <cfset itemID=orderItemID>
                <cfif price GT 0.99>
                    <cfquery name="applyDiscount" datasource="#DSN#">
                        update orderItems
                        set price=price*.85, priceOverride=price*.85
                        where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
                    </cfquery>
                </cfif>
            </cfloop>
			<cfset thisPromo="15% Discount ("&HTMLEditFormat(form.promo)&")">
		<cfelseif checkPromo EQ "THANK5">
        	<cfset doPromo=true>
        	<cfloop query="cartContents">
                <cfset itemID=orderItemID>

                	<cfquery name="applyDiscount" datasource="#DSN#">
                        update orderItems
                        set price=price*.95, priceOverride=price*.95
                        where ID=<cfqueryparam value="#itemID#" cfsqltype="cf_sql_integer">
                    </cfquery>

            </cfloop>
			<cfset thisPromo="5% Discount ("&HTMLEditFormat(form.promo)&")">
		</cfif>
		
	<cfelse>
		<cfset thisPromo="">
	</cfif>

</cfif>
<cfquery name="cartContents" datasource="#DSN#">
        SELECT * from orderItemsQuery
        where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
        AND adminAvailID=2 AND statusID=1
    </cfquery>
	<cfset thisSub=0>
	<cfset vinylCount=0>
	<cfset cdCount=0>
	<cfset shipmentWeight=0.5>
	<!---<cfloop query="cartContents">
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
	</cfloop>//--->
    <cfset remove99=0>
    <cfloop query="cartContents">
    	<cfif price EQ 0.99><cfset remove99=remove99+0.99></cfif>
    	<cfif mediaID EQ 20><cfset noMediaMail=true></cfif>
        <cfif left(catnum,3) EQ "TVJ" AND DateFormat(varDateODBC,"mm-dd-yyyy") LTE "02-10-2012"><cfset jacket=true></cfif>
		<!---<cfif weightException GT 0>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weightException*qtyOrdered)>
		<cfelse>
			<cfset shipmentWeight=shipmentWeight+(NRECSINSET*weight*qtyOrdered)>
		</cfif>//--->
		<cfif weightException GT 0>
        	<cfset vinylCount=vinylCount+(weightException*2)>
        <cfelse>
			<cfif mediaID EQ 1 OR mediaID EQ 5 OR mediaID EQ 9>
                <cfset vinylCount=vinylCount+(NRECSINSET*qtyOrdered)>
            <cfelse>
                <cfset cdCount=cdCount+(NRECSINSET*qtyOrdered)>
            </cfif>
        </cfif>
        <cfif priceOverride EQ 0>
			<cfset shipOrderSub=shipOrderSub+(qtyOrdered*price)>
		<cfelse>
        	<cfset shipOrderSub=shipOrderSub+(qtyOrdered*priceOverride)>
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
			where countryID=3
			order by cost1Record DESC
		</cfquery>
	</cfif>
    <cfset shipmentWeight=shipmentWeight+(vinylCount*.5)+(cdCount*.3)>
	<cfloop query="shipOptions">
    	<cfset shipCost=0>
        <!---<cfif jacket><cfset vinylCount=9></cfif>//--->
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
<!---<cfoutput>#form.shipOptionID# | #shipmentWeight# | #shipCost# | #vinylCount# | #cdCount#<cfabort></cfoutput>//--->
		<!---<cfset shipCost=0>
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
		</cfif>//--->
	</cfloop>
    <cfif form.tickets EQ "yes">
    	<cfquery name="shipOptions" dbtype="query">
        	select *
            from Application.allShipOptions
            where ID=141
        </cfquery>
        <cfset shipCost=shipOptions.cost1cd>
    </cfif>
    <!---<cfif checkPromo EQ "SHIP50">
		<cfset shipCost=Replace(DollarFormat(shipCost/2),"$","","all")>
		<cfset thisPromo="50% Off Shipping ("&HTMLEditFormat(form.promo)&")">
        <cfset dopromo=true>
    <cfelseif checkPromo EQ "SHIPJOEFREE">
    	<cfset shipCost=0>
		<cfset thisPromo="FREE Shipping ("&HTMLEditFormat(form.promo)&")">
        <cfset dopromo=true>
	</cfif>//--->
    <!--- THIS BLOCK OF CODE (along with a similar one in checkOutShip.cfm produces the FREE SHIPPING/$5 OFF deal//--->
    <!--- CURRENTLY ONLY FREE MEDIA MAIL SHIPPING IS ENABLED...NOTE THAT $5 OFF OTHER METHOD IS COMMENTED OUT BELOW //--->
	<!---/<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2013-12-31">
		<cfif shipCost GT 0 and form.shipOrderSub GTE 50>
            <cfif form.shipOptionID EQ 1>
                <cfset shipCost=0>
            <!---<cfelseif shipOrderSub GT 5.00>
                <cfset shipCost=shipCost-5>//--->
            <cfset checkPromo="FREESHIPPING">
            <cfset thisPromo=thisPromo &" Free Shipping">
            <cfset doPromo=true>
            </cfif>
         </cfif>
        </cfif>/--->
	 <!--- END FREE SHIPPING BLOCK //--->
     <!--- THIS BLOCK OF CODE (along with a similar one in checkOutShip.cfm produces the FREE SHIPPING/$5 OFF deal
	<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2009-08-31">//--->
		<cfif shipCost GT 0 and thisSub GTE 75>
            <cfif form.shipOptionID EQ 1 AND NOT Session.isStore>
                <cfset shipCost=0>
            <cfset checkPromo="FREE SHIPPING">
            <cfset thisPromo=thisPromo &" Free Media Mail Shipping on Orders Over $75">
            <!---<cfelseif thisSub LT 75>
                <cfset shipCost=shipCost*.95>
            <cfelse>
            	<cfset shipCost=shipCost*.90>//--->
            </cfif>
            <cfset doPromo=true>
         </cfif>
      <!---  </cfif>
	 END FREE SHIPPING BLOCK //--->
	<cfquery name="thisShipAddress" datasource="#DSN#">
		select *
		from custAddresses
		where ID=<cfqueryparam value="#form.shipID#" cfsqltype="cf_sql_integer">
	</cfquery>
    <cfset thisTax=0>
	<!---<cfif thisShipAddress.countryID EQ 1 AND thisShipAddress.stateID EQ 39 AND NOT Session.isStore AND NOT form.tickets><!--- If shipping to NY State, add sales tax //--->
		<cfset thisTax=NumberFormat((.0875*(shipCost+thisSub)),"0.00")>
	<cfelse>
		<cfset thisTax=0>
	</cfif>//--->
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
            specialInstructions=<cfqueryparam value="#Trim(thisPromo)#" cfsqltype="cf_sql_longvarchar">,
            promoCode=<cfqueryparam value="#checkPromo#" cfsqltype="cf_sql_char">,
            otherSiteID=#otherSiteID#,
            gcNum=#setGC#
		where ID=<cfqueryparam value="#cartContents.orderID#" cfsqltype="cf_sql_integer">
	</cfquery>
</cfif>
		<!---<cfquery name="cartContents" datasource="#DSN#">
			SELECT *
			FROM orderItemsQuery
			where orderID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
		</cfquery><cfoutput query="cartContents">#price#</cfoutput><cfabort>//--->
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