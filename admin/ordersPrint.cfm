<cfquery name="ordersWaiting" datasource="#DSN#">
	select statusID AS StatusCode, orderItemStatus.name As Status, catnum As opCATNUM, label As opLABEL, artist As opARTIST, 
		title As opTITLE, '[' & opCATNUM & '] ' & label & ' - ' & artist & ' / ' & title As ItemDescrip, qtyOrdered As Quantity, orderItems.price As Price,
		dateStarted As DatePlaced, datePurchased As DateChanged, orderItems.ID As ItemGML, catItemID & shelfCode As SellerCatnum, 
		media As opMEDIA, shippingRates.name & ' ' & specialInstructions & ' ' As CustomerInstruct, comments As GEMMAdminNote, Str(orderItemsQuery.custID) As CustomerGMU, 
		firstName & ' ' & lastName As ShiptoAttn, add1 As ShiptoStreet, add2 As ShiptoStreet2, add3 As ShiptoStreet3, city & ', ' & state & stateprov & ' ' & postcode As SS4, 
		country As ShiptoCountry, adminAvailID As Processed, email As CustomerEmail, orderItems.ID As OrderGMR, shelfCode As PARTNER, shelfCode As CONSIGNEE, shippingRates.name As ShipMethod
	from (((orderItemsQuery  LEFT JOIN custAddressesQuery ON orderItemsQuery.shipAddressID=custAddressesQuery.ID)
			LEFT JOIN orderItemStatus ON orderItemsQuery.adminAvailID=orderItemStatus.ID)
			LEFT JOIN shippingRates ON orderItemsQuery.shipID=shippingRates.ID)
	where (statusID=4 AND (adminAvailID=4 OR adminAvailID=5)) OR (statusID=6 AND adminAvailID=6)
	order by orderItemsQuery.custID, GMU
</cfquery>
<cfif ordersWaiting.recordCount GT 0>
<!---<cfoutput query="ordersWaiting">
#opCATNUM#<br />
</cfoutput><cfabort>
	//--->
<cfreport template="ordersGEMMPrint.cfr"
	filename="ordersGEMMPrint.PDF"
    format="pdf"
	query="ordersWaiting"
	overwrite="yes"></cfreport>
<cfmail to="order@downtown304.com" from="info@downtown304.com" subject="Downtown 304 Addresses #DateFormat(varDateODBC,"mm/dd/yy")#" type="html">
<cfset lastCust=0>
<cfloop query="ordersWaiting">
	<cfif CustomerGMU NEQ lastCust>
		<cfif Left(ShiptoAttn,1) EQ " "><cfset custName=Right(ShiptoAttn,Len(ShiptoAttn)-1)><cfelse><cfset custName=ShiptoAttn></cfif>
		<p>#custName#<br />
		#ShiptoStreet#<br />
		<cfif ShiptoStreet2 NEQ "">#ShiptoStreet2#<br />
		</cfif><cfif ShiptoStreet NEQ "">#ShiptoStreet3#<br />
		</cfif><cfif ShiptoCountry NEQ "" AND ShiptoCountry NEQ "United States">#ShiptoCountry#<br />
		</cfif><cfif CustomerEmail NEQ "">#CustomerEmail#<br />
		</cfif></p>
	</cfif>
	<cfset lastCust=CustomerGMU>
</cfloop>
</cfmail>
<cfset y=3>
<cfloop from="1" to="200000" index="x">
	<cfset y=x*x+y*x+y*y+x*y*x>
</cfloop>
<!---
<cfquery name="markAsShipped" datasource="#DSN#">
	update orders
	set statusID=6
	where statusID=4 AND adminPayID=1
</cfquery>
<cfloop query="ordersWaiting">
<cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#ID# AND adminPayID=1
</cfquery>
<cfloop query="thisItems">
	<cfif adminAvailID EQ 5>
		<cfquery name="updateONHAND" datasource="#DSN#">
			update catItems
			set ONSIDE=ONSIDE-#qtyOrdered#
			where ID=#catItemID#
		</cfquery>
	<cfelseif adminAvailID EQ 4>
		<cfquery name="updateONHAND" datasource="#DSN#">
			update catItems
			set ONHAND=ONHAND-1
			where ID=#catItemID#
		</cfquery>
	</cfif>
</cfloop>
<cfquery name="updateOrderStatus" datasource="#DSN#">
	update orders
	set statusID=6, dateShipped=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
	where ID=#ID# AND adminPayID=1
</cfquery>
<cfquery name="updateOrderItems" datasource="#DSN#">
	update orderItems
	set qtyAvailable=qtyOrdered, adminAvailID=6
	where orderID=#ID# AND (adminAvailID=4 OR adminAvailID=5) AND adminPayID=1
</cfquery>//--->
<cflocation url="ordersGEMMPrint.PDF">
<!---<cfelse>
	<cfset pageName="ORDERS">
	<cfinclude template="pageHead.cfm">
	<h1>No Orders Ready to Print</h1>
	<cfinclude template="pageFoot.cfm">
</cfif>//--->