<cfparam name="binsOnly" default="false">
<cfset bigSalePerc=1>
<!---<cfif DateFormat(varDateODBC,"yyyy-mm") EQ "2009-08"><cfset bigSalePerc=.9></cfif>//--->
<cfparam name="Session.userID" default="0">
<cfif Session.userID EQ "">
	<cfset Session.userID=0>
</cfif>
<cfparam name="url.dsu" default="xxxxxxxxxx">
<cfif url.dsu NEQ "xxxxxxxxxx"><cfset thisUserID=urlDecode(Decrypt(url.dsu,'y6DD3cxo86zHGO'))><cfelse><cfset thisUserID=0></cfif>
<cfif thisUserID NEQ 0 AND IsNumeric(thisUserID)>
	<cfset Session.userID=thisUserID>
</cfif>
<cfif Session.userID NEQ 0>
	<cfset thisUserID=Session.userID>
</cfif>
<!---<cfoutput>#thisUserID# #Session.userID#</cfoutput><cfabort>//--->
<cfif Session.userID NEQ "0">
	<!---<cfquery name="checkForSpecial" datasource="#DSN#">
		select *
		from orderItemsQuery
		where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND specialItem=1 AND catItemID<>46317 AND price<>0
	  </cfquery>
	<cfif checkForSpecial.recordCount EQ 0>
		<cfquery name="clearPromoItemFromCart" datasource="#DSN#">
				delete
				from orderItems
				where orderID=(select Max(ID) from orders where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND statusID=1)
				AND adminAvailID=2 AND ((catItemID>=49118 AND catItemID<=49122) OR (catItemID IN (44545,44547,44581,44582,44584,44585,44586,44587)) OR (catItemID>=54297 AND catItemID<=54301) OR (catItemID=46317 AND price=0))
			  </cfquery>
		</cfif>//--->
        <cfif Session.isStore EQ true OR Session.isStore EQ 1>
      	<cfquery name="setwholesale" datasource="#DSN#">
        	update orderItems
            set price=wholesaleprice, priceoverride=wholesaleprice
            FROM ((orderItems LEFT JOIN catItems ON orderItems.catItemID = catItems.ID) LEFT JOIN orders ON orderItems.orderID=orders.ID) 
			WHERE custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=2 AND statusID=1
            </cfquery>
      </cfif>
	<cfif NOT binsOnly>
		  <cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2015-07-24">
          	<cfquery name="salePercentSummer" datasource="#DSN#">
            	select Sum(qtyOrdered) As numItems
                from orderItemsQuery
                where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=2 AND statusID=1 AND (catItemID<>46317)
            </cfquery>
            <cfif salePercentSummer.numItems GTE 20>
            	<cfset bigSalePerc=.80>
            <cfelseif salePercentSummer.numItems GTE 15>
            	<cfset bigSalePerc=.85>
            <cfelseif salePercentSummer.numItems GTE 10>
            	<cfset bigSalePerc=.90>
            <cfelseif salePercentSummer.numItems GTE 5>
            	<cfset bigSalePerc=.95>
			<cfelse>
                <cfset bigSalePerc=1.00>
            </cfif>
            
			</cfif>
          </cfif>
          <cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2013-05-23">
          	<cfquery name="salePercentSummer" datasource="#DSN#">
            	select Sum(qtyOrdered) As numItems from orderItemsQuery
                where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=2 AND statusID=1 AND (catItemID<>46317)
                group by qtyOrdered
            </cfquery>
            
            <cfif salePercentSummer.numItems GTE 10>
                <cfset bigSalePerc=.90>
                <cfelse>
                <cfset bigSalePerc=1.00>
			</cfif>
          </cfif>
          <!---
		<cfquery name="resetPrices" datasource="#DSN#">
			UPDATE orderItems
			SET [orderItems].[priceOverride] = [catItems].[price]*#bigSalePerc#
            FROM ((orderItems LEFT JOIN catItems ON orderItems.catItemID = catItems.ID) LEFT JOIN orders ON orderItems.orderID=orders.ID) 
			WHERE custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=2 AND statusID=1 AND (catItemID<>46317)
		</cfquery>//--->
		<cfquery name="setSalePrices" datasource="#DSN#">
			UPDATE orderItems
			SET price=priceOverride
            FROM (orderItems LEFT JOIN orders ON orderItems.orderID=orders.ID)
			WHERE priceOverride<>0 AND custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=2 AND statusID=1
		</cfquery>
		<!-- prices reset //-->
	</cfif>
	  <!---<cfquery name="checkForPromoItem" datasource="#DSN#">
	  	select *
		from orderItemsQuery
		where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=2 AND catItemID=46317 AND price=0
	  </cfquery>
	  <cfif checkForSpecial.recordCount GT 0 AND checkForPromoItem.recordCount EQ 0>
		<cfquery name="addPromoItem" datasource="#DSN#">
			insert into orderItems (orderID,catItemID,qtyOrdered,price,priceOverride,adminAvailID)
			values (
				<cfqueryparam value="#checkForSpecial.orderID#" cfsqltype="cf_sql_integer">,
				<cfqueryparam value="46317" cfsqltype="cf_sql_char">,
				1,
				<cfqueryparam value="0.00" cfsqltype="cf_sql_money">,
				<cfqueryparam value="0.00" cfsqltype="cf_sql_money">,
				2
			)
		</cfquery>
	  </cfif>//--->
      <!--- BUY ONE GET ONE FREE ... Syam Aug 2009 //--->
      <!---<cfquery name="checkForBuyOne" datasource="#DSN#">
		select Sum(qtyOrdered) As itemQty, orderItemID
        from orderItemsQuery
        where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=2 AND statusID=1 AND (labelID=2129 OR labelID=1830) 
        group by qtyOrdered, orderItemID, price
        order by price ASC
      </cfquery>
      <cfif checkForBuyOne.recordCount GT 1>
      	<cfset buyOneCount=0>
      	<cfloop query="checkForBuyOne">
        	<cfset buyOneCount=buyOneCount+itemQty>
        </cfloop>
      	<cfset freeCount=buyOneCount-NumberFormat(buyOneCount/2,"0")>
        <!---<cfmail to="order@downtown304.com" from="info@downtown304.com" subject="syamfreecount=#freeCount#"></cfmail>//--->
        <cfset giveFree=0>
        <cfloop query="checkForBuyOne">
        	<cfif giveFree LT freeCount>
            	<cfif giveFree+itemQty LTE freeCount>
                	<cfquery name="giveFreeOne" datasource="#DSN#">
                    	update orderItems
                        set price=0
                        where ID=#orderItemID#
                    </cfquery>
					<cfset giveFree=giveFree+itemQty>
				</cfif>
            </cfif>
        </cfloop>
      </cfif>//--->
      <!--- END BUY ONE GET ONE FREE //--->
<cfif Session.isStore AND Session.userID NEQ 0>
    <cfquery name="setwholesale" datasource="#DSN#">
        update orderItems
        set price=wholesaleprice, priceoverride=wholesaleprice
        FROM ((orderItems LEFT JOIN catItems ON orderItems.catItemID = catItems.ID) LEFT JOIN orders ON orderItems.orderID=orders.ID) 
        WHERE custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=2 AND statusID=1
    </cfquery>
    <cfquery name="cartContents" datasource="#DSN#">
        SELECT *
        FROM orderItemsQuery
        where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
        AND adminAvailID=2 AND statusID=1
    </cfquery>
<cfelseif Session.userID NEQ 0>
	<cfquery name="cartContents" datasource="#DSN#">
		SELECT *
		FROM orderItemsQuery
		where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
		AND adminAvailID=2 AND statusID=1
	</cfquery>
<cfelse>
	<cfquery name="cartContents" datasource="#DSN#">
		select *
		from orderItemsQuery
		where orderID=0
	</cfquery>
</cfif>