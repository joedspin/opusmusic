<cfparam name="form.orderID" default="0">
<cfparam name="form.thisPromo" default="">
<cfparam name="url.ppsid" default="">
<cfparam name="form.comments" default="">
<cfparam name="url.orderID" default="0">
<cfparam name="url.thisPromo" default="">
<cfparam name="form.loggedID" default="0">
<cfif form.loggedID NEQ 0>
	<cfquery name="getLoggedID" datasource="#DSN#">
    	select *
        from sessionLogger
        where ID=<cfqueryparam value="#form.loggedID#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif getLoggedID.recordCount NEQ 0>
    	<cflock scope="session" timeout="20" type="exclusive">
			<cfset Session.userID=getLoggedID.userID>
	    </cflock>
    </cfif>
</cfif>
<cfinclude template="checkOutPageHead.cfm">
<cfif url.ppsid EQ "done">
	<cfset orderStatID=3>
<cfelse>
	<cfset orderStatID=2>
</cfif>
<cfif form.orderID NEQ 0><cfset thisOrderID=form.orderID></cfif>
<cfif url.orderID NEQ 0><cfset thisOrderID=url.orderID></cfif>

<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=<cfqueryparam value="#thisOrderID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfloop query="thisOrder">
<cfif form.comments NEQ ""><cfset thisComments=form.comments><cfelse><cfset thisComments=specialInstructions></cfif>
<cfset thisCustID=custID>
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=<cfqueryparam value="#userCardID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfif thisCard.ccNum NEQ ""><cfset procDetails="#thisCard.PayAbbrev# ending in #Right(Decrypt(thisCard.ccNum,encryKey71xu),4)#"><cfelse><cfset procDetails=""></cfif>
<cfset paymType=thisCard.ccTypeID>
<cfquery name="thisItems" datasource="#DSN#">
	SELECT orderItems.*, catItemsQuery.*
	FROM orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID
	where orderID=#thisOrderID#
    order by label, catnum
</cfquery>

<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=<cfqueryparam value="#thisCustID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="thisShipOption" datasource="#DSN#">
	select *
	from shippingRates
	where ID=<cfqueryparam value="#shipID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="thisShipping" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=<cfqueryparam value="#shipAddressID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="thisBilling" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=<cfqueryparam value="#billingAddressID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfif paymentTypeID GT 0 AND paymentTypeID LT 4>
<!--- BEGIN Authorize credit card //--->

<!--- TEMPORARILY DISABLE CREDIT CARD PROCESSING ON THE FRONT END 
<cfset StructClear(Session)>
<CFOBJECT COMPONENT="CallerService" NAME="caller">
<CFTRY>
<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "DoDirectPayment">
<CFSET requestData.PAYMENTACTION = "authorization">
<CFSET requestData.USER = "#APIUserName#">
<CFSET requestData.PWD = "#APIPassword#">
<CFSET requestData.SIGNATURE = "#APISignature#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.CURRENCYCODE = "USD">
<CFSET requestData.AMT = "#NumberFormat(thisOrder.orderTotal,"00000.00")#">
<cfloop query="thisCard">
<CFSET expDate =  #Decrypt(ccExpMo,encryKey71xu)# & "20" & #Decrypt(ccExpYr,encryKey71xu)# >
<CFSET requestData.FIRSTNAME = "#ccFirstName#">
<CFSET requestData.LASTNAME = "#ccName#">
<CFSET requestData.CVV2 = "#Decrypt(ccCCV,encryKey71xu)#">
<cfif ccTypeID EQ 1>
	<CFSET requestData.CREDITCARDTYPE = "Visa">
<cfelseif ccTypeID EQ 2>
	<CFSET requestData.CREDITCARDTYPE = "MasterCard">
<cfelseif ccTypeID EQ 3>
	<CFSET requestData.CREDITCARDTYPE = "Amex">
<cfelse>
	<CFSET requestData.CREDITCARDTYPE = "Discover">
</cfif>
<CFSET requestData.ACCT = "#Replace(Replace(Decrypt(ccNum,encryKey71xu)," ","","all"),"-","","all")#">
<CFSET requestData.EXPDATE = "#expDate#">
</cfloop>
<cfinvoke component="CallerService" method="doHttppost" returnvariable="response">

	<cfinvokeargument name="requestData" value=#requestData#>
	<cfinvokeargument name="serverURL" value=#serverURL#>
	<cfinvokeargument name="proxyName" value=#proxyName#>
	<cfinvokeargument name="proxyPort" value=#proxyPort#>
	<cfinvokeargument name="useProxy" value=#useProxy#>

</cfinvoke>
<cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
 <cfset messages = ArrayNew(1)>
 <cfset Session.resStruct ="#responseStruct#">
 <cfset ccResponse="00000">
<cfif responseStruct.Ack is "Success">
	<cfset ccResponse=responseStruct.TRANSACTIONID>
	<cfquery name="creditCardResponse" datasource="#DSN#">
		update orders
		set transactionID=<cfqueryparam value="#ccResponse#" cfsqltype="cf_sql_char">,
	        datePurchased=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
			statusID=3,
			datePaid=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
            specialInstructions=<cfqueryparam value="#thisComments#" cfsqltype="cf_sql_longvarchar">
		where ID=#thisOrderID#
	</cfquery>
    <cfset orderStatID=3>
</cfif>

<cfif responseStruct.Ack is "Failure">
    <CFLOCATION URL="APIError.cfm?error=fromServer">
</cfif>

<CFCATCH>
	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	<CFLOCATION URL="APIError.cfm?error=fromClient">

</CFCATCH>

</CFTRY>//--->
<!--- END Authorize credit card //--->
</cfif>
<cfquery name="updateOrder" datasource="#DSN#">
	update orders 
	set
		datePurchased=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
		statusID=<cfqueryparam value="#orderStatID#" cfsqltype="cf_sql_integer">,
        datePaid=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
		processingDetails=<cfqueryparam value="#procDetails#" cfsqltype="cf_sql_longvarchar">,
        specialInstructions=<cfqueryparam value="#thisComments#" cfsqltype="cf_sql_longvarchar">
	where ID=<cfqueryparam value="#thisOrderID#" cfsqltype="cf_sql_integer">
</cfquery>
<!---<cfmail to="marianne@downtown304.com" cc="order@downtown304.com" from="order@downtown304.com" subject="Downtown 304 order #NumberFormat(thisOrderID,"00000")#" type="html">
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {padding: 2px;}
//-->
</style>
<h1>Downtown 304 <b>Order Summary</b> #NumberFormat(thisOrderID,"00000")#</h1>
<p><b>Customer Email:</b>&nbsp;&nbsp;&nbsp;#thisCust.email#</p>
<table border="1" style="border-collapse:collapse;" width="100%">
<tr bgcolor="##CCCCCC">
	<td align="center">QTY</td>
	<td>CATNUM</td>
	<td>LABEL</td>
	<td>ARTIST</td>
	<td>TITLE</td>
	<td>MEDIA</td>
	<td align="center">PRICE</td>
	<td align="center">SHELF</td>
</tr>
<cfloop query="thisItems">
<cfif priceOverride NEQ 0><cfset thisPrice=priceOverride><cfelse><cfset thisPrice=price></cfif>
<tr>
		<td align="center">#qtyOrdered#</td>
		<td valign="top">#catnum#</td>
		<td valign="top">#label#</td>
		<td valign="top">#artist#</td>
		<td valign="top">#title#</td>
		<td valign="top"><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
		<td valign="top" align="right">#DollarFormat(thisPrice)#</td>
		<td valign="top" align="center">#shelfCode#</td>
	</tr>
</cfloop>
</table>
<p><cfif form.thisPromo NEQ "">Promo Code Entered: #form.thisPromo#</cfif></p>
<p><b>Order Sub-Total: #DollarFormat(thisOrder.orderSub)#</b></p>	
	<cfif shipID NEQ 64>
	<p><b>Shipping Method:</b><br /><cfloop query="thisShipOption">
		#name# (#shippingTime#) #DollarFormat(thisOrder.orderShipping)# (estimated)
	</cfloop></p>
	<p><b>Ship to:</b><br />
		<cfloop query="thisShipping">
		#thisShipping.firstName# #thisShipping.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop>
	<p><b>Bill to:</b><br />
		<cfloop query="thisBilling">
		#thisBilling.firstName# #thisBilling.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop>
	<cfelse>
		<p><cfloop query="thisShipping">
		<b>#thisShipping.firstName# #thisShipping.LastName#</b><br /></cfloop>
        <cfloop query="thisShipOption">#name# #shippingTime#</cfloop></p>
	</cfif>
	<p><b>Payment: </b><br />
		<cfif thisCard.RecordCount GT 0>
			<cfloop query="thisCard">
				#PayAbbrev# ending in #Right(Decrypt(ccNum,encryKey71xu),4)#
			</cfloop>
		<cfelseif thisOrder.paymentTypeID EQ 6>
			Money Order
		<cfelseif thisOrder.paymentTypeID EQ 7>
			PayPal
		</cfif>
	</p>
    <cfif thisOrder.orderTax GT 0><p><b>NY Sales Tax (8.875%):</b> #DollarFormat(thisOrder.orderTax)#</p></cfif>
	<p><b>Order Total: </b>#DollarFormat(thisOrder.orderTotal)#</p>
</cfmail>//--->
<cfmail to="#thisCust.email#" from="order@downtown304.com" bcc="order@downtown304.com" subject="Downtown 304 order #NumberFormat(thisOrderID,"00000")#" type="html">
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {padding: 2px;}
//-->
</style>
<h1>Downtown 304 <b>Order Summary</b> #NumberFormat(thisOrderID,"00000")#</h1>
<table border="1" style="border-collapse:collapse;" width="100%"><br />
<tr bgcolor="##CCCCCC">
	<td align="center">QTY</td>
	<td>CATNUM</td>
	<td>LABEL</td>
	<td>ARTIST</td>
	<td>TITLE</td>
	<td>MEDIA</td>
	<td align="center">PRICE</td>
	<!---<td align="center">SHELF</td>//--->
</tr>
<cfset qtysGT1=false>
<cfloop query="thisItems">
<cfif qtyOrdered GT 1><cfset qtysGT1=true></cfif>
<cfif priceOverride NEQ 0><cfset thisPrice=priceOverride><cfelse><cfset thisPrice=price></cfif>
<tr>
		<td align="center">#qtyOrdered#</td>
		<td valign="top">#catnum#</td>
		<td valign="top">#label#</td>
		<td valign="top">#artist#</td>
		<td valign="top">#title#</td>
		<td valign="top"><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
		<td valign="top" align="right">#DollarFormat(thisPrice)#</td>
		<!---<td valign="top" align="center">#shelfCode#</td>//--->
	</tr>
</cfloop>
</table>
<p><cfif form.thisPromo NEQ "">Promo Code Entered: #form.thisPromo#</cfif></p>
<p><b>Order Sub-Total: #DollarFormat(orderSub)#</b></p>

	
	<cfif shipID NEQ 64>
	<p><b>Shipping Method:</b><br />
	<cfloop query="thisShipOption">
		#name# (#shippingTime#) #DollarFormat(thisOrder.orderShipping)# 
	</cfloop></p>
	<p><b>Ship to:</b><br />
		<cfloop query="thisShipping">
		#thisShipping.firstName# #thisShipping.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop>
	<p><b>Bill to:</b><br />
		<cfloop query="thisBilling">
		#thisBilling.firstName# #thisBilling.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# </p>
	</cfloop>
	<cfelse>
		<p><cfloop query="thisShipping">
		<b>#thisShipping.firstName# #thisShipping.LastName#</b><br /></cfloop>
        <cfloop query="thisShipOption">#name# #shippingTime#<cfif thisShipOption.ID EQ 64><br><font color="red">If paying cash, you must pay for and pick up your order within 14 days or it will be cancelled and put back.</font></cfif></cfloop></p>
	</cfif>
	<p><b>Payment: </b><br />
		<cfif thisCard.RecordCount GT 0>
			<cfloop query="thisCard">
				#PayAbbrev# ending in #Right(Decrypt(ccNum,encryKey71xu),4)#
			</cfloop>
		<cfelseif thisOrder.paymentTypeID EQ 6>
			Money Order<br />
			SEND TO:<br />
		&nbsp;&nbsp;Downtown 304<br />
		&nbsp;&nbsp;302 Morgan Ave Ste B3<br />
		&nbsp;&nbsp;Brooklyn, NY 11211<br />
			&nbsp;<br />
			Your order will ship as soon as we receive your payment. Payment must be received within 14 days or your order will be cancelled. Please send payment promptly.
		<cfelseif thisOrder.paymentTypeID EQ 7>
			PayPal
		</cfif>
	</p>
    <cfif thisOrder.orderTax GT 0><p><b>NY Sales Tax (8.875%):</b> #DollarFormat(thisOrder.orderTax)#</p>
	<p><b>Order Total: </b>#DollarFormat(thisOrder.orderTotal)#</p></cfif>
</cfmail>
<cflock scope="session" timeout="20" type="exclusive">
	<cfset Session.cart="">
	<cfset Session.orderID=0>
</cflock>
<cfif thisOrder.paymentTypeID EQ 7><cfset paypalmsg="&paypal=yes"><cfelse><cfset paypalmsg=""></cfif>
<!---<cfquery name="OutOfStockOneLeft" datasource="#DSN#">
	update catItems
    set albumStatusID=27
    where ONHAND+ONSIDE<2 AND albumStatusID<25 AND ID IN (select catItemID from orderItems where orderID=#thisOrderID# AND qtyOrdered=1)
</cfquery>
<cfif qtysGT1>
	<cfquery name="OutOfStockGT1ordered" datasource="#DSN#"> 
    	select catItemID, qtyOrdered
        from orderItems
        where orderID=#thisOrderID# AND qtyOrdered>1
    </cfquery>
    <cfloop query="OutOfStockGT1ordered">
    	<cfquery name="ForceOutOfStock" datasource="#DSN#">
            update catItems
            set albumStatusID=27
            where ONHAND<=(select sum(qtyOrdered) from orderItemsQuery where catItemID=#catItemID# AND adminAvailID IN (2,4,5) AND statusID NOT IN (1,7)) AND ID=#catItemID# AND albumStatusID<25
        </cfquery>
    </cfloop>
</cfif>
<cfquery name="OutOfStockGT1ordered" datasource="#DSN#"> 
    select catItemID, qtyOrdered
    from orderItems
    where orderID=#thisOrderID#
</cfquery>
<cfloop query="OutOfStockGT1ordered">//--->
<cfif NOT thisCust.badCustomer>
<cfloop query="thisItems">
    <cfquery name="ForceOutOfStock" datasource="#DSN#">
                update catItems
                set albumStatusID=27
                where ONHAND<=(select sum(qtyOrdered) from orderItemsQuery where catItemID=#thisItems.catItemID# AND adminAvailID IN (2,4,5) AND statusID NOT IN (1,7)) AND ID=#thisItems.catItemID# AND albumStatusID<25
     </cfquery>
     </cfloop>
     </cfif>
<!---</cfloop>//--->
<cflocation url="checkOutDone.cfm?dsu=#URLEncodedFormat(Encrypt(Session.userID,'y6DD3cxo86zHGO'))##paypalmsg#">
</cfloop>