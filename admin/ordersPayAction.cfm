<cfset api_response="">
<cfparam name="form.ID" default="0">
<cfparam name="form.orderSub" default="0.00">
<cfparam name="form.orderShipping" default="0.00">
<cfparam name="form.orderTax" default="0.00">
<cfparam name="form.orderTotal" default="0.00">
<cfparam name="form.submit" default="">
<cfset PayPalCaptured=false>
<cfparam name="form.billID" default="0">
<cfparam name="form.CCV" default="">
<cfparam name="form.cardChoice" default="0">
<cfparam name="form.shipOptionID" default="0">
<cfparam name="form.saveCard" default="no">
<cfparam name="form.thisPromo" default="">
<cfparam name="form.expmo" default="12">
<cfparam name="form.expyr" default="99">
<cfquery name="updateOrder" datasource="#DSN#">
	update orders
	set orderSub=<cfqueryparam value="#form.orderSub#" cfsqltype="cf_sql_money">,
		orderShipping=<cfqueryparam value="#form.orderShipping#" cfsqltype="cf_sql_money">,
		orderTax=<cfqueryparam value="#form.orderTax#" cfsqltype="cf_sql_money">,
		orderTotal=<cfqueryparam value="#form.orderTotal#" cfsqltype="cf_sql_money">
	where ID=#form.ID#
</cfquery>


<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=<cfqueryparam value="#form.ID#" cfsqltype="integer">
</cfquery>


<cfif form.cardChoice EQ 0 AND form.CCV EQ ""><p>Please click "Back" and enter the CCV number for your card. On MasterCard or Visa it is 3 digits on the back of the card after the card number. On American Express it is 4 digits on the front of the card above the card number.</p><cfabort></cfif>

<cfset theMonth=form.expmo>
<cfset theYear=form.expyr>
<cfset cardExpDate=NumberFormat(theYear+2000,"0000")&"-"&NumberFormat(theMonth+1,"00")&"-00">
<cfif form.cardChoice EQ 0 AND cardExpDate LT DateFormat(varDateODBC,"yyyy-mm-dd")><p>Please click "Back" and enter a new new expiration date for your card. The date you entered is already expired.</p><cfabort></cfif>

<cfif form.billID NEQ 0>
	<cfif form.cardChoice EQ 0>
		<cfquery name="checkCard" datasource="#DSN#">
			select *
			from userCardsQuery
			where accountID=<cfqueryparam value="#thisOrder.custID#" cfsqltype="integer"> and ccNum=<cfqueryparam value="#Encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">
		</cfquery>
		<cfif checkCard.RecordCount EQ 0>
			<cfquery name="addCard" datasource="#DSN#">
				insert into	userCards (accountID, ccTypeID, ccFirstName, ccName, ccNum, ccExpMo, ccExpYr, ccCCV, store)
				values (
					<cfqueryparam value="#thisOrder.custID#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#form.CCType#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#form.CCFirstName#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#form.CCName#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#Encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#Encrypt(form.expmo,encryKey71xu)#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#Encrypt(form.expyr,encryKey71xu)#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#Encrypt(form.CCV,encryKey71xu)#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#form.saveCard#" cfsqltype="cf_sql_bit">
				)
			</cfquery>
			<cfquery name="newCard" datasource="#DSN#">
				select Max(ID) as maxID
				from userCards
				where accountID=<cfqueryparam value="#thisOrder.custID#" cfsqltype="integer"> and ccNum=<cfqueryparam value="#Encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">
			</cfquery>
			<cfset thisCardID=newCard.maxID>
			<cfset thisCardTypeID=form.CCType>
		<cfelse>
			<cfquery name="editCard" datasource="#DSN#">
				update userCards 
				set 
					ccTypeID=<cfqueryparam value="#form.CCType#" cfsqltype="cf_sql_char">,
					ccFirstName=<cfqueryparam value="#form.CCFirstName#" cfsqltype="cf_sql_char">,
					ccName=<cfqueryparam value="#form.CCName#" cfsqltype="cf_sql_char">,
					ccExpMo=<cfqueryparam value="#Encrypt(form.expmo,encryKey71xu)#" cfsqltype="cf_sql_char">,
					ccExpYr=<cfqueryparam value="#Encrypt(form.expyr,encryKey71xu)#" cfsqltype="cf_sql_char">,
					ccCCV=<cfqueryparam value="#Encrypt(form.CCV,encryKey71xu)#" cfsqltype="cf_sql_char">,
					store=<cfqueryparam value="#form.saveCard#" cfsqltype="cf_sql_bit">
				where ID=#checkCard.ID#
			</cfquery>
			<cfset thisCardID=checkCard.ID>
			<cfset thisCardTypeID=form.CCType>
		</cfif>
	<cfelse>
		<cfif form.cardChoice EQ "C">
			<cfset thisCardID=0>
			<cfset thisCardTypeID=5>
		<cfelseif form.cardChoice EQ "M">
			<cfset thisCardID=0>
			<cfset thisCardTypeID=6>
		<cfelseif form.cardChoice EQ "P">
			<cfset thisCardID=0>
			<cfset thisCardTypeID=7>
		<cfelse>
			<cfquery name="thisCard" datasource="#DSN#">
				select *
				from userCards
				where ID=<cfqueryparam value="#form.cardChoice#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfset thisCardID=#form.cardChoice#>
			<cfset thisCardTypeID=#thisCard.ccTypeID#>
		</cfif>
	</cfif>
	<cfquery name="updateOrder" datasource="#DSN#">
		update orders
		set
			billingAddressID=<cfqueryparam value="#form.billID#" cfsqltype="cf_sql_char">,
			paymentTypeID=<cfqueryparam value="#thisCardTypeID#" cfsqltype="cf_sql_char">,
			userCardID=<cfqueryparam value="#thisCardID#" cfsqltype="cf_sql_char">
		where ID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_integer">
    </cfquery>
	<!---<cfif form.cardChoice EQ "P">
		<cflocation url="checkOutPayPal.cfm?orderID=#thisOrder.ID#&thisPromo=#URLEncodedFormat(form.thisPromo)#">
	<cfelse>
		<cflocation url="checkOutConfirm.cfm?orderID=#thisOrder.ID#&thisPromo=#URLEncodedFormat(form.thisPromo)#">
	</cfif>//--->
<cfelse>
<p>Error...something is missing from your submission. Most likely billing address was not specified. <a href="http://www.downtown304.com/admin/orders.cfm">Click to try again.</a></p><cfabort>
</cfif>
<cfif form.submit EQ "Save Without Processing"><cfif form.statement NEQ ""><cflocation url="customersOpusStatement.cfm?ID=#form.statement#"><cfelse><cflocation url="orders.cfm?editedID=#form.ID#"></cfif></cfif>
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#form.ID#
</cfquery>
<cfloop query="thisOrder">
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#thisOrder.userCardID#
</cfquery>
<cfif thisCard.ccNum NEQ ""><cfset procDetails="#thisCard.PayAbbrev# ending in #Right(Decrypt(thisCard.ccNum,encryKey71xu),4)#"><cfelse><cfset procDetails=""></cfif>
<cfset paymType=thisCard.ccTypeID>
<cfquery name="thisItems" datasource="#DSN#">
	SELECT orderItems.*, catItemsQuery.*
	FROM orderItems LEFT JOIN catItemsQuery ON orderItems.catItemID = catItemsQuery.ID
	where orderID=#form.ID# AND (adminAvailID=4 OR adminAvailID=5)
</cfquery>
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#thisOrder.custID#
</cfquery>
<cfquery name="thisShipOption" datasource="#DSN#">
	select *
	from shippingRates
	where ID=#shipID#
</cfquery>
<cfquery name="thisShipping" datasource="#DSN#">
	select *, abbrev
	from custAddressesQuery LEFT JOIN countries ON countries.ID=custAddressesQuery.countryID
	where custAddressesQuery.ID=#shipAddressID#
</cfquery>
<cfquery name="thisBilling" datasource="#DSN#">
	select *, abbrev
	from custAddressesQuery LEFT JOIN countries ON countries.ID=custAddressesQuery.countryID
	where custAddressesQuery.ID=#billingAddressID#
</cfquery>
<cfif form.submit EQ "Cancel" AND form.cancelID EQ Decrypt(Session.specialKey,encryKey71xu)>
	<cfif thisCard.recordCount EQ 0>No card<cfabort></cfif><cfoutput query="thisCard"><p>#Decrypt(ccExpMo,encryKey71xu)#/#Decrypt(ccExpYr,encryKey71xu)#<br />
	#ccFirstName# #ccName# #Decrypt(ccCCV,encryKey71xu)#
	<cfif ccTypeID EQ 1>
		Visa
	<cfelseif ccTypeID EQ 2>
		MasterCard
	<cfelseif ccTypeID EQ 3>
		Amex
	<cfelse>
		Discover
	</cfif><br />
    <cfset theNum=Decrypt(ccNum,encryKey71xu)>
	#Replace(Replace(theNum," ","","all"),"-","","all")#</p></cfoutput>
    <cfmail query="thisCard" to="order@downtown304.com" cc="order@downtown304.com" from="order@downtown304.com" subject="card details accessed">#ccFirstName# #ccName# ending in #Right(theNum,4)#</cfmail><cfabort>
<cfelseif form.submit NEQ "Save Without Processing">
	<cfif form.submit EQ "     Capture     ">
		<cfset ReauthFlag=false>
        <cfset StructClear(Session)>
        <CFOBJECT COMPONENT="CallerService" NAME="caller">
	        <CFTRY>
        		<CFSET requestData = StructNew()>
                <CFSET requestData.METHOD = "DoCapture">
                <CFSET requestData.USER = "#APIUserName#">
				<CFSET requestData.PWD = "#APIPassword#">
                <CFSET requestData.SIGNATURE = "#APISignature#">
                <CFSET requestData.VERSION = "#version#">
                <CFSET requestData.AUTHORIZATIONID = "#thisOrder.transactionID#">
                <CFSET requestData.AMT = "#NumberFormat(thisOrder.orderTotal,"00000.00")#">
                <CFSET requestData.COMPLETETYPE = "Complete">
                <CFSET requestData.NOTE = "Downtown 304 Order #NumberFormat(thisOrder.ID,"00000")#">
                <CFSET requestData.CURRENCYCODE = "USD">
		        <!--- CODE REMOVED HERE....see bottom of this file for removed code --->
		<!---<cfelse>
            <cfset ccResponse=responseStruct.TRANSACTIONID>
            <cfquery name="creditCardResponse" datasource="#DSN#">
                update orders
                set transactionID=<cfqueryparam value="#ccResponse#" cfsqltype="cf_sql_char">,
                    statusID=4,
                    datePaid=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
                where ID=#thisOrder.ID#
            </cfquery>
        </cfif>//--->
   
   
<!--- 
	Calling doHttppost for API call 
--->
 <cfinvoke component="CallerService" method="doHttppost" returnvariable="response">

        <cfinvokeargument name="requestData" value=#requestData#>
        <cfinvokeargument name="serverURL" value=#serverURL#>
        <cfinvokeargument name="proxyName" value=#proxyName#>
        <cfinvokeargument name="proxyPort" value=#proxyPort#>
        <cfinvokeargument name="useProxy" value=#useProxy#>
    
    </cfinvoke>
    

    
    <CFCATCH>
        <cfset responseStruct = StructNew() >
        <cfset responseStruct.errorType =  "#cfcatch.type#">
        <cfset responseStruct.errorMessage =  "#cfcatch.message#">
        <cfset Session.resStruct = "#responseStruct#">
        <CFLOCATION URL="APIError.cfm?error=fromClient">
    
    </CFCATCH>
    
    </CFTRY>
    </cfif>
    <cfset PayPalCaptured=true>
</cfif>
<cfif form.submit NEQ "     Capture     "> 
<!---<cfhttp method="post" url="https://test.authorize.net/gateway/transact.dll">//--->
<cfhttp method="post" url="https://secure.authorize.net/gateway/transact.dll">
<!-- 
First, we pass the required fields for this particular transaction type (CC/AUTH_CAPTURE), using the CFHTTPPARAM tag for each value
-->
<cfloop query="thisCard">
	<CFSET expDate =  Decrypt(ccExpMo,encryKey71xu) &"/"& Decrypt(ccExpYr,encryKey71xu)>

	<CFSET requestData.CVV2 = "#ccCCV#">
	<!---<cfif ccTypeID EQ 1>
		<CFSET requestData.CREDITCARDTYPE = "Visa">
	<cfelseif ccTypeID EQ 2>
		<CFSET requestData.CREDITCARDTYPE = "MasterCard">
	<cfelseif ccTypeID EQ 3>
		<CFSET requestData.CREDITCARDTYPE = "Amex">
	<cfelse>
		<CFSET requestData.CREDITCARDTYPE = "Discover">
	</cfif>//--->
	<cfset theNum=Decrypt(ccNum,encryKey71xu)>


<cfhttpparam name="x_login" type="formfield" value="6474EgNn4">
<cfhttpparam name="x_tran_key" type="formfield" value="66F3Buh4a49N7GJU">
<cfhttpparam name="x_method" type="formfield" value="CC">
<cfhttpparam name="x_type" type="formfield" value="AUTH_CAPTURE">
<cfhttpparam name="x_amount" type="formfield" value="#NumberFormat(thisOrder.orderTotal,"00000.00")#">
<cfhttpparam name="x_delim_data" type="formfield" value="TRUE">
<cfhttpparam name="x_delim_char" type="formfield" value="|">
<cfhttpparam name="x_relay_response" type="formfield" value="FALSE">
<cfhttpparam name="x_card_num" type="formfield" value="#Replace(Replace(theNum," ","","all"),"-","","all")#">
<cfhttpparam name="x_exp_date" type="formfield" value="#expDate#">
<cfhttpparam name="x_first_name" type="formfield" value="#ccFirstName#">
<cfhttpparam name="x_last_name" type="formfield" value="#ccName#">
            <cfloop query="thisBilling">
            <cfif state NEQ ""><cfset billStateProv=state><cfelseif stateprov NEQ ""><cfset billStateProv=stateprov><cfelse><cfset billStateProv=""></cfif>
    <cfhttpparam type="Formfield" name="x_address" value="#add1# #add2# #add3# #city#">
	<cfhttpparam type="Formfield" name="x_state" value="#billStateProv#">
	<cfhttpparam type="Formfield" name="x_zip" value="#postcode#">
	<cfhttpparam type="Formfield" name="x_country" value="#country#">
            </cfloop>
<cfhttpparam name="x_version" type="formfield" value="3.1">
<cfhttpparam name="x_invoice_num" type="formfield" value="#NumberFormat(form.ID,"00000")#"> 
<cfhttpparam name="x_description" type="formfield" value="Downtown 304 Records">
<cfhttpparam name="x_cust_id" type="formfield" value="#thisCust.username#"> 
</cfloop>
	
</cfhttp>

<cfset api_response=cfhttp.fileContent>
<cfset strLen=Len(api_response)>
<cfset myString = api_response>
<cfset numberDelims = ListLen(api_response, "|")>
<cfset numOfDelims = Evaluate(Len(myString) - Len(Replace(myString,"|","","ALL")))>
<cfset occurrence=(findoneof(api_response, "|", 0)+1)>
<cfset MyList = api_response>
<cfset MyArray = ListToArray(MyList, "|")>
<!---<cfloop index="Element" from="1" to="#ArrayLen(MyArray)#">
	<cfoutput>Element #Element#: #MyArray[Element]#<br></cfoutput>
</cfloop>//--->

<!-- We need to add 1 to account for the last item (in the response string) which has no delimiting character afterward -->
<cfset numOfDelims = IncrementValue(numOfDelims)>
<cfset newText = Replace(api_response, "|", " |","ALL")>
<cfelse>
<cfset api_response="">
</cfif>
<cfset linkFlag=false>
<cfoutput>
<html>
<head>
<title>Downtown 304 Receipt</title>
</head>
<!---<cfif FindNoCase("approved",api_response) GT 0><body onLoad="javascript:window.print();"><cfelse><body></cfif>//--->
<body>
<h1>Downtown 304 Order Summary ###NumberFormat(form.ID,'00000')#</h1>
<cfif form.submit NEQ "Save Without Processing">
<cfloop query="thisCard">
<p><cfif ccNum NEQ "">#thisCard.PayAbbrev# ending in #Right(Decrypt(ccNum,encryKey71xu),4)#<br /></cfif>
Name on card: #ccFirstName# #ccName#</p>
<cfif form.submit EQ "Authorization Only" OR form.submit EQ "Authorize without Address"><p><b><font color="red">******* AUTHORIZATION see result below - FUNDS NOT YET COLLECTED *******</font></b></p><cfelse>
<h3><b><cfif FindNoCase("approved",api_response) GT 0 OR form.submit EQ "Paid Externally"><cfset newAdminIssueID=0><cfset linkFlag=true><strong>Approved</strong><br><a href="ordersPaid.cfm?ID=#form.ID#&paid=4">PRINT PACKING LIST</a> OR if Declined Externally, <font color="red">DECLINED</font> <a href="ordersDeclined.cfm?ID=#form.ID#">Notify</a><cfelseif FindNoCase("avs mismatch",api_response) GT 0><cfset linkFlag=true><cfset newAdminIssueID=2><font color="red">DECLINED DUE TO WRONG BILLING ADDRESS</font> <a href="ordersDeclined.cfm?ID=#form.ID#&avs=true">Notify</a><cfelseif FindNoCase("declined",api_response) GT 0><cfset linkFlag=true><cfset newAdminIssueID=2><font color="red">DECLINED</font> <a href="ordersDeclined.cfm?ID=#form.ID#">Notify</a><cfelse><cfset newAdminIssueID=4><cfset linkFlag=true>UNKNOWN RESPONSE OR GENERAL ERROR <a href="ordersDeclined.cfm?ID=#form.ID#">Notify</a></cfif></b></h3>
<p><font style="font-size: xx-small;">#api_response#</font></p></cfif>
</cfloop>
<cfif PayPalCaptured AND NOT linkFlag><strong>Approved</strong><br><a href="ordersPaid.cfm?ID=#form.ID#&paid=4">PRINT PACKING LIST</a><cfelse><a href="http://www.downtown304.com/admin/orders.cfm">Return to Orders</a></cfif>
</cfif>
<p><cfloop query="thisItems">
	#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#] #DollarFormat(price)#<br />
</cfloop></p>
<p><b>Order Sub-Total: #DollarFormat(orderSub)#</b></p>
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
	</cfloop><br />
	<p><b>Payment: </b><br />
		<cfif thisCard.RecordCount GT 0>
			<cfloop query="thisCard">
				#PayAbbrev# ending in #Right(Decrypt(ccNum,encryKey71xu),4)#
			</cfloop>
		</cfif>
	</p>
	<cfif thisOrder.orderTax GT 0><p><b>NY Sales Tax (8.875%):</b> #DollarFormat(thisOrder.orderTax)#</p></cfif>
	<p><b>Order Total: </b>#DollarFormat(thisOrder.orderTotal)#</p>
</body></html></cfoutput>
</cfloop>


<!---<cfelseif form.submit EQ "     Reauthorize for New Amount     ">
            <CFSET requestData.METHOD = "DoReauthorization">
            <CFSET requestData.AUTHORIZATIONID = "#thisOrder.transactionID#">
            <CFSET requestData.NOTE = "Downtown 304 Order #NumberFormat(thisOrder.ID,"00000")#">
            <cfset ReauthFlag=true>
        <cfelse>
            <CFSET requestData.METHOD = "DoDirectPayment">
            <cfif form.submit EQ "Authorization Only" OR form.submit EQ "Authorize without Address">
                <CFSET requestData.PAYMENTACTION = "authorization">
            <cfelse>
                <CFSET requestData.PAYMENTACTION = "sale">
            </cfif>//--->
        
        
        <!---<cfif form.submit NEQ "     Capture     ">
            <cfloop query="thisCard">
            <CFSET expDate =  #ccExpMo# & "20" & #ccExpYr# >
            <CFSET requestData.FIRSTNAME = "#ccFirstName#">
            <CFSET requestData.LASTNAME = "#ccName#">
            <CFSET requestData.CVV2 = "#ccCCV#">
            <cfif ccTypeID EQ 1>
                <CFSET requestData.CREDITCARDTYPE = "Visa">
            <cfelseif ccTypeID EQ 2>
                <CFSET requestData.CREDITCARDTYPE = "MasterCard">
            <cfelseif ccTypeID EQ 3>
                <CFSET requestData.CREDITCARDTYPE = "Amex">
            <cfelse>
                <CFSET requestData.CREDITCARDTYPE = "Discover">
            </cfif>
            <CFSET requestData.ACCT = "#Replace(Replace(ccNum," ","","all"),"-","","all")#">
            <CFSET requestData.EXPDATE = "#expDate#">
            </cfloop>
            <cfif form.submit NEQ "Try without Address" AND form.submit NEQ "Authorize without Address">
            <cfloop query="thisBilling">
            <cfif state NEQ ""><cfset billStateProv=state><cfelseif stateprov NEQ ""><cfset billStateProv=stateprov><cfelse><cfset billStateProv=""></cfif>
            <CFSET requestData.STREET = "#add1#">
            <cfif Replace(add2," ","","all") NEQ ""><CFSET requestData.STREET2 = "#add2#"></cfif>
            
            <CFSET requestData.ZIP = "#postcode#">
            <CFSET requestData.STATE = "#billStateProv#">
            <CFSET requestData.CITY = "#city#">
            <CFSET requestData.COUNTRYCODE = "#abbrev#">
            </cfloop>
            <cfloop query="thisShipping">
            <cfif state NEQ ""><cfset shipStateProv=state><cfelseif stateprov NEQ ""><cfset shipStateProv=stateprov><cfelse><cfset shipStateProv=""></cfif>
            <CFSET requestData.SHIPTONAME = "#firstName# #lastName#">
            <CFSET requestData.SHIPTOSTREET = "#add1#">
            <cfif Replace(add2," ","","all") NEQ ""><CFSET requestData.SHIPTOSTREET2 = "#add2#"></cfif>
            <CFSET requestData.SHIPTOZIP = "#postcode#">
            <CFSET requestData.SHIPTOSTATE = "#billStateProv#">
            <CFSET requestData.SHIPTOCITY = "#city#">
            <CFSET requestData.SHIPTOCOUNTRYCODE = "#abbrev#">
            </cfloop>
            </cfif>
        </cfif>//--->