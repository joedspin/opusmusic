<cfparam name="form.allowedits" default="no">
<cfparam name="url.ID" default="0">
<cfparam name="url.start" default="">
<cfparam name="url.express" default="">
<cfparam name="form.ID" default="0">
<cfparam name="form.isGEMM" default="No">
<cfparam name="form.shipID" default="0">
<cfparam name="form.shipAddressID" default="0">
<cfparam name="form.pickupReady" default="0">
<cfparam name="form.picklistPrinted" default="0">
<cfparam name="form.issueRaised" default="0">
<cfparam name="form.issueResolved" default="0">
<cfparam name="form.otherSiteID" default="0">
<cfparam name="form.otherSiteOrderNum" default="">
<cfparam name="form.pageBack" default="orders.cfm">
<cfparam name="form.onlyImports" default="true">
<cfparam name="form.adminPassword" default="">
<cfparam name="form.express" default="">
<cfparam name="form.fSubmit" default="">
<cfparam name="form.comments" default="">
<cfparam name="form.readyToPrint" default="false">
<cfparam name="form.isVinylmania" default="0">
<cfparam name="form.custID" default="0">
<cfparam name="form.loadcatnums" default="">
<cfparam name="form.moveItem" default="">
<cfparam name="form.makeNew" default="">
<cfparam name="form.makeBackInStock" default="">
<cfparam name="form.makeRegular" default="">
<cfparam name="form.makeOutOfStock" default="">
<cfparam name="form.makeInactive" default="">
<cfset intentionalReassign="">
<cfif form.makeNew NEQ "">
	<cfquery name="makeNewItems" datasource="#DSN#">
    	update catItems
        set albumStatusID=21
        where ID IN (#form.makeNew#)
    </cfquery>
    <cfset intentionalReassign=form.makeNew>
</cfif>
<cfif form.makeBackInStock NEQ "">
	<cfquery name="makeBackInStockItems" datasource="#DSN#">
    	update catItems
        set albumStatusID=23, dtDateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
        where ID IN (#form.makeBackInStock#)
    </cfquery>
    <cfif intentionalReassign EQ "">
    	<cfset intentionalReassign=form.makeBackInStock>
    <cfelse>
    	<cfset intentionalReassign=intentionalReassign & ',' & form.makeBackInStock>
    </cfif>
</cfif>
<cfif form.makeRegular NEQ "">
	<cfquery name="makeRegularItems" datasource="#DSN#">
    	update catItems
        set albumStatusID=24
        where ID IN (#form.makeRegular#)
    </cfquery>
    <cfif intentionalReassign EQ "">
    	<cfset intentionalReassign=form.makeRegular>
    <cfelse>
    	<cfset intentionalReassign=intentionalReassign & ',' & form.makeRegular>
    </cfif>
</cfif>
<cfif form.makeOutOfStock NEQ "">
	<cfquery name="makeOutOfStockItems" datasource="#DSN#">
    	update catItems
        set albumStatusID=25
        where ID IN (#form.makeOutOfStock#)
    </cfquery>
    <cfif intentionalReassign EQ "">
    	<cfset intentionalReassign=form.makeOutOfStocK>
    <cfelse>
    	<cfset intentionalReassign=intentionalReassign & ',' & form.makeOutOfStock>
    </cfif>
</cfif>
<cfif form.makeInactive NEQ "">
	<cfquery name="makeInactiveItems" datasource="#DSN#">
    	update catItems
        set albumStatusID=44
        where ID IN (#form.makeInactive#)
    </cfquery>
    <cfif intentionalReassign EQ "">
    	<cfset intentionalReassign=form.makeInactive>
    <cfelse>
    	<cfset intentionalReassign=intentionalReassign & ',' & form.makeInactive>
    </cfif>
</cfif>
<cfif form.loadcatnums NEQ "">
<cffile action="write" 
		file="#serverPath#\orderadd.txt"
	output="#form.loadcatnums#">

<cfhttp method="Get"
		url="#webPath#/orderadd.txt"
		name="addtoorder"
		delimiter="|"
		textqualifier="" columns="Catalog_Number,QTY">
<cfif addtoorder.RecordCount GT 0>
		<cfloop query="addtoorder">
        <cfquery name="getID" datasource="#DSN#">
        	select ID
            from catItems
            where catnum='#Catalog_Number#'
        </cfquery>
        <cfif getID.recordCount GT 0>
	<cfquery name="additems" datasource="#DSN#">
    	insert into orderItems (catItemID,qtyOrdered,orderID)
        values (#getID.ID#,#QTY#,#form.ID#)
    </cfquery>
    </cfif>
</cfloop>
<cflocation url="ordersEdit.cfm?ID=#form.ID#">
</cfif>
</cfif>
<cfif url.ID NEQ 0><cfset thisOrderID=url.ID><cfelse><cfset thisOrderID=form.ID></cfif>
<cfif url.express NEQ ""><cfset thisExpress=url.express><cfelse><cfset thisExpress=form.express></cfif>
<cfset itemEditScript="AND shipped=0">
<cfset orderEditScript=" AND statusID<>6">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
    from orders
    where ID=#thisOrderID#
</cfquery>
<cfif NOT (form.fSubmit EQ "Admin Save" AND form.adminPassword EQ "joe") AND NOT form.allowedits EQ "yes">
    <cfif thisOrder.statusID EQ 6>
        <p align="center" style="margin-top: 30px;"><font color="red" size="+5">CHANGES NOT ALLOWED</font>
        <br />ORDER MARKED AS SHIPPED ALREADY</font></p>
        <p><a href="order.cfm">Continue</a></p><cfabort>
    </cfif>
<cfelse>
	<cfset itemEditScript="">
    <cfset orderEditScript="">
</cfif>
<cfquery name="thisItems" datasource="#DSN#">
	select *
	from orderItemsQuery
	where orderID=#thisOrderID# and shelfID Is Not Null #itemEditScript#
</cfquery>
<cfset newSub=0>
<cfloop query="thisItems">
	<cfset newStat=Evaluate("form.stat" & orderItemID)>
	<cfset newQty=Evaluate("form.qty" & orderItemID)>
	<cfif form.fSubmit EQ "Store Prices">
    	<!---<cfif shelfID EQ 11>
        	<cfset newPrice=buy>
        <cfelse>//--->
           	<cfif price LT wholesalePrice><cfset newPrice=price><cfelse><cfset newPrice=wholesaleprice></cfif>
        <!---</cfif>//--->
        <cfelseif form.fSubmit EQ "Fifty Cent Markup" OR url.start EQ "161">
		<cfif price LT cost><cfset newPrice=price-0.50><cfelse><cfset newPrice=cost+0.50></cfif>
    <cfelseif form.fSubmit EQ "BS $2.00" AND shelfCode EQ "BS">
		<cfset newPrice=2.00>
    <cfelseif form.fSubmit EQ "Cost">
		<cfset newPrice=cost>
    <cfelseif form.fSubmit EQ "2 Percent Discount">
		<cfset newPrice=price*.98>
	<cfelseif form.fSubmit EQ "5 Percent Discount">
		<cfset newPrice=price*.95>
    <cfelseif form.fSubmit EQ "10 Percent Discount">
		<cfset newPrice=price*.90>
    <cfelseif form.fSubmit EQ "20 Percent Discount">
		<cfset newPrice=price*.80>
    <cfelseif form.fSubmit EQ "30 Percent Discount">
		<cfset newPrice=price*.70>
    <cfelseif form.fSubmit EQ "35 Percent Discount">
		<cfset newPrice=price*.65>
    <cfelseif form.fSubmit EQ "1.25 Markup">
		<cfset newPrice=cost+1.25>
    <cfelseif form.fSubmit EQ "Zero Out Prices">
		<cfset newPrice=0.00>
    <cfelseif form.fSubmit EQ "Reset Prices">
        <cfif priceOverride NEQ 0 AND priceOverride LTE itemPrice>
        	<cfset newPrice=priceOverride>
        <cfelse>
			<cfset newPrice=itemPrice>
        </cfif>
	<cfelse>
		<cfset newPrice=Evaluate("form.price" & orderItemID)>
	</cfif>
    <cfset newPrice=Replace(Replace(newPrice,"(","-","all"),")","","all")>
    <cfset newPrice=Replace(newPrice,"$","","all")>
    <cfif newStat GT 3><cfset newSub=newSub+(newQty*newPrice)></cfif>
    <cfif NOT IsNumeric(newPrice)><font color="red">PRICE ERROR:</font> One of the items has an invalid price. Click BACK to fix the error and try again.<cfabort></cfif>
	<cfif newStat NEQ adminAvailID OR newQty NEQ qtyOrdered OR newPrice NEQ DollarFormat(price)>
		<cfquery name="updateItem" datasource="#DSN#">
			update orderItems
			set adminAvailID=#newStat#,
				qtyOrdered=#newQty#,
				price=<cfqueryparam value="#Replace(newPrice,'$','','all')#" cfsqltype="cf_sql_money">
			where ID=#orderItemID#
		</cfquery>
		<!--- this is obsolete since we removed "Not Available" (1) from order item statuses
		<cfif newStat EQ 1>
			<cfquery name="updateCatItem" datasource="#DSN#">
				update catItems
				set ONHAND=0, ONSIDE=0, albumStatusID=25
				where ID=#catItemID#
			</cfquery>
		</cfif>//--->
        <cfquery name="checkBad" datasource="#DSN#">
        	select *
            from custAccounts
            where badCustomer=1 AND ID=#thisOrder.custID#
        </cfquery>
        <cfif checkBad.recordCount EQ 0>
        	<cfif intentionalReassign NEQ ""><cfset IRinsert="AND ID NOT IN ("&intentionalReassign&")"><cfelse><cfset IRinsert=""></cfif>
            <cfquery name="ForceOutOfStock" datasource="#DSN#">
                update catItems
                set albumStatusID=27
                where ONHAND<=(select sum(qtyOrdered) from orderItemsQuery where catItemID=#catItemID# AND adminAvailID IN (2,4,5) AND statusID NOT IN (1,7)) AND ID=#catItemID# AND albumStatusID<25 #IRinsert#
            </cfquery>
        </cfif>
	</cfif>
</cfloop>
<cfquery name="removeZeroQ" datasource="#DSN#">
	delete
	from orderItems
	where qtyOrdered=0 AND orderID=#thisOrderID#
</cfquery>
<cfquery name="checkForDiscountLine" datasource="#DSN#">
	select *
    from orderItems
    where orderID=<cfqueryparam value="#thisOrderID#" cfsqltype="cf_sql_integer"> AND catItemID=74648
</cfquery>
<cfset discountAmount=.10>
<cfif checkForDiscountLine.recordCount GT 0>
	<cfquery name="getSpecInstr" datasource="#DSN#">
    	select specialInstructions As SI
        from orders
        where ID=#url.ID#
    </cfquery>
	<cfif Find(getSpecInstr.SI,'20[%] Discount') GT 0><cfset discountAmount=.20>got here<cfoutput>#Find(getSpecInstr.SI,'20[%] Discount')#</cfoutput></cfif>
	<cfif Find(getSpecInstr.SI,'30[%] Discount') GT 0><cfset discountAmount=.30>got here<cfoutput>#Find(getSpecInstr.SI,'30[%] Discount')#</cfoutput></cfif>
    <cfif Find(getSpecInstr.SI,'15[%] Discount') GT 0><cfset discountAmount=.15>got here<cfoutput>#Find(getSpecInstr.SI,'15[%] Discount')#</cfoutput></cfif>
    <cfif Find(getSpecInstr.SI,'5[%] Discount') GT 0><cfset discountAmount=.05>got here<cfoutput>#Find(getSpecInstr.SI,'5[%] Discount')#</cfoutput></cfif>
    <cfif Find(getSpecInstr.SI,'10[%] Discount') GT 0><cfset discountAmount=.10>got here<cfoutput>#Find(getSpecInstr.SI,'10[%] Discount')#</cfoutput></cfif>
    <cfquery name="cartContents" datasource="#DSN#">
        SELECT * from orderItemsQuery
        where orderID=<cfqueryparam value="#thisOrderID#" cfsqltype="cf_sql_integer">
        	AND adminAvailID=4 AND catItemID<>74648
    </cfquery>
    <cfset orderSubTAKE=0>
    <cfloop query="cartContents">
        <cfif priceOverride NEQ 0>
        	<cfset orderSubTAKE=orderSubTAKE+(priceOverride*qtyOrdered)>
        <cfelse>
			<cfset orderSubTAKE=orderSubTAKE+(price*qtyOrdered)>
        </cfif>
    </cfloop><cfoutput>#orderSubTake#</cfoutput>
    <cfset orderSubTAKE=orderSubTAKE*-discountAmount>
    <cfoutput>#orderSubTake# #discountAmount#</cfoutput>
    <cfquery name="addDiscountItem" datasource="#DSN#">
       update orderItems 
       set price=<cfqueryparam value="#orderSubTake#" cfsqltype="cf_sql_money">,
           priceOverride=<cfqueryparam value="#orderSubTake#" cfsqltype="cf_sql_money">
        where ID=<cfqueryparam value="#checkForDiscountLine.ID#" cfsqltype="cf_sql_integer">
    </cfquery>
</cfif>

<cfif form.shipID EQ 71><cfset changeShipping=", orderShipping=0, orderTotal=orderSub"><cfelse><cfset changeShipping=""></cfif>
<cfif form.custID EQ 2126><cfset newStatus=4><cfelse><cfset newStatus=form.statusID></cfif>
<cfquery name="updateOrder" datasource="#DSN#">
	update orders
	set otherSiteID=<cfqueryparam value="#form.otherSiteID#" cfsqltype="cf_sql_integer">,
    		otherSiteOrderNum=<cfqueryparam value="#form.otherSiteOrderNum#" cfsqltype="cf_sql_char">,
			pickupReady=<cfqueryparam value="#form.pickupReady#" cfsqltype="cf_sql_bit">,
			issueRaised=<cfqueryparam value="#form.issueRaised#" cfsqltype="cf_sql_bit">,
			issueResolved=<cfqueryparam value="#form.issueResolved#" cfsqltype="cf_sql_bit">,
			isVinylmania=<cfqueryparam value="#form.isVinylmania#" cfsqltype="cf_sql_bit">,
			picklistPrinted=<cfqueryparam value="#form.picklistPrinted#" cfsqltype="cf_sql_bit">,
            readyToPrint=<cfqueryparam value="#form.readyToPrint#" cfsqltype="cf_sql_bit">,
            oFlag2=<cfqueryparam value="#form.onlyImports#" cfsqltype="cf_sql_bit">,
        	orderSub=<cfqueryparam value="#newSub#" cfsqltype="cf_sql_money">,
			shipAddressID=<cfqueryparam value="#form.shipAddressID#" cfsqltype="cf_sql_char">,
        	shipID=<cfqueryparam value="#form.shipID#" cfsqltype="cf_sql_char">#changeShipping#,
            specialInstructions=<cfqueryparam value="#form.comments#" cfsqltype="cf_sql_longvarchar">,
            statusID=#newStatus#
	where ID=#thisOrderID# #orderEditScript#
</cfquery>

	<!---<cfquery name="updateOrderShipping" datasource="#DSN#">
        update orders
        set 
        where ID=#thisOrderID#
    </cfquery>//--->
	<cfset moveOrderID=0>
<cfif form.moveItem NEQ "">
	<cfquery name="customerOtherOrder" datasource="#DSN#">
    	select *
        from orders
        where custID=#form.custID# AND statusID<6 AND ID<>#form.ID#
    </cfquery>
    <cfif customerOtherOrder.recordCount EQ 0>
    	<cfquery name="addCustOrder" datasource="#DSN#">
            insert into orders (custID, dateStarted, dateUpdated, statusID,shipID,picklistPrinted,issueRaised,issueResolved,pickupReady)
            values (<cfqueryparam value="#form.custID#" cfsqltype="cf_sql_integer">,#varDateODBC#,#varDateODBC#,2,64,1,1,1,1)
        </cfquery>
        <cfquery name="getNewOrderID" datasource="#DSN#">
            select Max(ID) As MaxID
            from orders
            where custID=<cfqueryparam value="#form.custID#" cfsqltype="cf_sql_integer"> AND statusID=2
        </cfquery>
        <cfset moveOrderID=getNewOrderID.MaxID><!---<cfoutput>#moveOrderID#: #form.moveItem#</cfoutput><cfabort>//--->
    <cfelseif customerOtherOrder.recordCount EQ 1>
    	<cfset moveOrderID=customerOtherOrder.ID><!---<cfoutput>#moveOrderID#: #form.moveItem#</cfoutput><cfabort>//--->
    <cfelse>
    	There is more than one open order for this customer. You need to pick and merge all orders for this customer before you can use this feature.<br>
        <a href="ordersEdit.cfm?ID=#thisOrderID#">Continue</a><cfabort>
    </cfif>
		<cfif moveOrderID NEQ 0>
    	<cfquery name="moveItems" datasource="#DSN#">
        	update orderItems
            set orderID=#moveOrderID# where ID in (#form.moveItem#)
        </cfquery>
    </cfif>
</cfif>
<cfif form.fSubmit EQ "Combine">
<cfset lastItemChecked=0>
<cfset lastItemFixed=0>
<cfquery name="thisOrderItems" datasource="#DSN#">
	select * from orderItems where orderID=#form.ID# order by catItemID	
</cfquery>
<cfloop query="thisOrderItems">
<cfif catItemID EQ lastItemChecked AND catItemID NEQ lastItemFixed>
<cfquery name="countTotalItems" datasource="#DSN#">
	select sum(qtyOrdered) as thisQty from orderItems where catItemID=#thisOrderItems.catItemID# AND orderID=#form.ID#
</cfquery>
<cfquery name="setNewQty" datasource="#DSN#">
	update orderItems set qtyOrdered=#countTotalItems.thisQty# where ID=#thisOrderItems.ID#	
</cfquery>
<cfquery name="deleteOthers" datasource="#DSN#">
	delete from orderItems where catItemID=#thisOrderItems.catItemID# AND ID<>#thisOrderItems.ID# AND orderID=#form.ID#
</cfquery>
<cfset lastItemFixed=catItemID>
</cfif>
<cfset lastItemChecked=catItemID>
	</cfloop>
</cfif>
<cfif form.fSubmit NEQ "Save Changes" AND form.fSubmit NEQ "Shop" AND form.fSubmit NEQ "Reveal Pics" AND form.fSubmit NEQ "Shelf List"><!--- EQ "Wholesale Prices" OR form.fSubmit EQ "Save" OR form.fSubmit EQ "Five Percent Discount" OR form.fSubmit EQ "Ten Percent Discount" OR fSubmit EQ "Reset Prices" OR fSubmit EQ "Zero Out Prices"//--->
	<cflocation url="ordersEdit.cfm?ID=#thisOrderID#">
<cfelseif form.fSubmit EQ "Shelf List">
	<cflocation url="ordersEdit.cfm?ID=#thisOrderID#&shelf=yes">
<cfelseif form.fSubmit EQ "Shop">
	<cflocation url="ordersShop.cfm?orderID=#thisOrderID#">
<cfelseif form.fSubmit EQ "Reveal Pics">
	<cflocation url="ordersEdit.cfm?ID=#thisOrderID#&revealPics=true">
<cfelseif thisExpress NEQ "" AND url.start NEQ "161">
	<cflocation url="ordersUpdateInvoice.cfm?ID=#thisOrderID#&express=#thisExpress#">
<cfelse>
	<cflocation url="orders.cfm?editedID=#thisOrderID#"><!---##edited//--->
</cfif>