<cfparam name="form.orderID" default="0">
<cfparam name="form.thisPromo" default="">
<cfparam name="form.comments" default="">
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
    <cfquery name="killLog" datasource="#DSN#">
    	delete
        from sessionLogger
        where ID=<cfqueryparam value="#form.loggedID#" cfsqltype="cf_sql_integer"> AND
        		userID=#Session.userID#
    </cfquery>
</cfif>
<cfinclude template="checkOutPageHead.cfm">
<cfset thisdsu=URLEncodedFormat(Encrypt(Session.userID,'y6DD3cxo86zHGO'))>
<!-- 
*************************************************
DoExpressCheckoutPayment.cfm

This page takes necessary parameter from GetExpressCheckoutDetails page 
and pssing into doHttppost function to perform doExpressCheckout  
This page will show the response value coming from the Server. If any error occurs,
the page will redirect to APIError.cfm to show exact error details

*************************************************
-->


	
	<!--
		The cfobject tag is creating object for Credentialinfo component. 
		This component returns credential information.Retrieving form values 
		from getExpresscheckoutdetails.cfm page and setting into appropriate variable
	-->
	<cfobject component="CallerService" name="caller">

<CFTRY>
<cfset StructClear(Session)>
		<!--
			CFHTTP tag accepts necessary parameter for doexpresscheckout 
		 -->

<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "DoExpressCheckoutPayment">
<CFSET requestData.USER = "#APIUserName#">
<CFSET requestData.PWD = "#APIPassword#">
<CFSET requestData.SIGNATURE = "#APISignature#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.TOKEN = "#Form.token#">
<CFSET requestData.PAYERID = "#Form.payerId#">
<CFSET requestData.PAYMENTACTION = "#Form.paymentaction#">
<CFSET requestData.AMT = "#Form.amount#">
<CFSET requestData.CURRENCYCODE = "#Form.currencycode#">

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
	
		<cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
		<cfset Session.resStruct = #responseStruct#>
		<cfif responseStruct.Ack is "Success">
		 
				<cfset ccResponse=responseStruct.TRANSACTIONID>
				<cfquery name="creditCardResponse" datasource="#DSN#">
					update orders
					set transactionID=<cfqueryparam value="#ccResponse#" cfsqltype="cf_sql_char">,
						statusID=3,
						datePaid=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
            			specialInstructions=<cfqueryparam value="#form.comments#" cfsqltype="cf_sql_longvarchar">
					where ID=<cfqueryparam value="#form.orderID#" cfsqltype="cf_sql_integer">
				</cfquery>
                
				<cflocation url="checkoutConfirmAction.cfm?orderID=#form.orderID#&thisPromo=#form.thisPromo#&ppsid=done&dsu=#thisdsu#">
			
		</cfif>
	<cfif responseStruct.Ack is "Failure">
		<!---<CFLOCATION URL="APIError.cfm?error=fromServer"> //--->
        <CFLOCATION URL="checkoutConfirmAction.cfm?orderID=#form.orderID#&thisPromo=#form.thisPromo#&ppsid=done&dsu=#thisdsu#">
	</cfif>

	<!--
		Below hard coded value should coming from response object from the server. 
		Right now server is not available so we hard coded
	-->
<CFCATCH>
	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	<!---<CFLOCATION URL="APIError.cfm?error=fromClient">//--->
    <CFLOCATION URL="checkoutConfirmAction.cfm?orderID=#form.orderID#&thisPromo=#form.thisPromo#&ppsid=done&dsu=#thisdsu#">
</CFCATCH>
</CFTRY>