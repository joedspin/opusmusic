<cfinclude template="checkOutPageHead.cfm">
<!---<cfquery name="logSession" datasource="#DSN#">
	insert into sessionLogger (userID)
    values (#Session.userID#)
</cfquery>
<cfquery name="getLoggedID" datasource="#DSN#">
	select Max(ID) as MaxID 
    from sessionLogger
    where userID=#Session.userID#
</cfquery>
<cfset loggedID=getLoggedID.MaxID>//--->
<cfparam name="url.thisPromo" default="">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=<cfqueryparam value="#Session.orderID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfloop query="thisOrder">
	<cfset thisOrderAmount=numberFormat(orderTotal,"0000.00")>
</cfloop>
<cfparam name="form.PAYMENTACTION" default="authorization">
<cfparam name="form.currencyCodeType" default="USD">
	<!-- 
		Getting the Credential information from the CredentialInfo component and retrieving amount 
		 from the form object	
	-->
<cfset thisOrderID=Session.orderID>
<cfset thisUserID=Session.userID>
<CFTRY>
	<cfset StructClear(Session)>
	<cfset serverName = #SERVER_NAME#>
	<cfset serverPort = #CGI.SERVER_PORT#>
	<cfset contextPath = GetDirectoryFromPath(#SCRIPT_NAME#)>
	<cfset protocol = #CGI.SERVER_PROTOCOL#>
	<cfset cancelUrlPath = "http://" & serverName & ":" & serverPort & contextPath & "checkOut.cfm?dsu=#URLEncodedFormat(Encrypt(thisUserID,'y6DD3cxo86zHGO'))#">
	<cfset returnUrlPath = "http://" & serverName & ":" & serverPort & contextPath & "checkOutConfirm.cfm?amt=#thisOrderAmount#&currencycode=#form.currencyCodeType#&paymentaction=#form.PAYMENTACTION#&orderID=#thisOrderID#&thisPromo=#URLEncodedFormat(url.thisPromo)#&dsu=#URLEncodedFormat(Encrypt(thisUserID,'y6DD3cxo86zHGO'))#">
	<CFOBJECT COMPONENT="CallerService" name="caller">
		
	<!-- 
		Passing necessary parameter to perform Setexpresscheckout transaction in the CFHTTP Tag
	-->

	<CFSET requestData = StructNew()>
	<CFSET requestData.METHOD = "SetExpressCheckout">
	<CFSET requestData.PAYMENTACTION = "authorization">
	<CFSET requestData.USER = "#APIUserName#">
	<CFSET requestData.PWD = "#APIPassword#">
	<CFSET requestData.SIGNATURE = "#APISignature#">
	<CFSET requestData.VERSION = "#version#">
	<CFSET requestData.AMT = "#thisOrderAmount#">
	<CFSET requestData.CURRENCYCODE = "USD">
	<CFSET requestData.CancelURL = "#cancelUrlPath#">
	<CFSET requestData.ReturnURL = "#returnUrlPath#">

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
	 
	<cfif responseStruct.Ack is not "Success">
		<cfthrow>
	<cfelse>
		<CFSET TOKEN = #responseStruct.TOKEN#>
	</cfif>
	<!--
		cfhttp.FileContent returns token and other response value from the server. 
		We need to pass token as parameter to destination URL which redirect to return URL  
	-->

	<CFSET redirecturl = #PayPalURL# & #TOKEN#>

	 <CFLOCATION URL="#redirecturl#" ADDTOKEN="no">  
<CFCATCH>

<cfset urlPath = "APIError.cfm?error=fromClient&errorType=" & #cfcatch.type# & "&errorMessage=" & #cfcatch.message#>


<cfif "#cfcatch.message#" is not "">

	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	<CFLOCATION URL="APIError.cfm?error=fromClient">
</cfif>

<cfset urlPath = "APIError.cfm?error=fromServer">

<cfif responseStruct.Ack is "Failure"> 
    <CFLOCATION URL="APIError.cfm?error=fromServer">
</cfif>

</CFCATCH>
</CFTRY>
</body>
</html>
