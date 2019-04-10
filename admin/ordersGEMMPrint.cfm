<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<cfquery name="ordersWaiting" datasource="#DSN#">
	select statusID AS StatusCode, orderItemStatus.name As Status, catnum As opCATNUM, label As opLABEL, artist As opARTIST, 
		title As opTITLE, '[' & opCATNUM & '] ' & label & ' - ' & artist & ' / ' & title As ItemDescrip, qtyOrdered As Quantity, orderItems.price As Price,
		dateStarted As DatePlaced, datePurchased As DateChanged, orderItems.ID As ItemGML, catItemID & shelfCode As SellerCatnum, 
		media As opMEDIA, specialInstructions As CustomerInstruct, comments As SellerNote, Str(orderItemsQuery.custID) As CustomerGMU, 
		firstName & ' ' & lastName As ShiptoAttn, add1 As ShiptoStreet, add2 As ShiptoStreet2, city & ', ' & state & stateprov & ' ' & postcode As ShiptoStreet3, 
		country As ShiptoCountry, adminAvailID As Processed, email As CustomerEmail, orderItems.ID As OrderGMR, shelfCode As PARTNER, shelfCode As CONSIGNEE
	from ((orderItemsQuery  LEFT JOIN custAddressesQuery ON orderItemsQuery.shipAddressID=custAddressesQuery.ID)
			LEFT JOIN orderItemStatus ON orderItemsQuery.adminAvailID=orderItemStatus.ID)
	where statusID<6 AND statusID>1
	order by orderItemsQuery.custID, GMU
</cfquery>
<cfoutput query="ordersWaiting">
#statusCode#
</cfoutput><cfabort>
<cfreport template="ordersGEMMPrint.cfr"
	filename="ordersGEMMPrint.PDF"
	query="ordersWaiting"
    format="pdf"
	overwrite="yes">
<cfset y=3>
<cfloop from="1" to="400000" index="x">
	<cfset y=x*x+y*x+y*y+x*y*x>
</cfloop>
<cflocation url="ordersGEMMPrint.PDF">
<cfinclude template="pageFoot.cfm">