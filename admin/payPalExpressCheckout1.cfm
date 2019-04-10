<!-- 
*************************************************
ReviewOrder.cfm


When click submit button in the setexpresscheckout.cfm, the page submitted in Orderreview.cfm 
it takes necessary values as parameter and pass into destination URL which returns token and 
payerid.This token we need to pass as parameter for getExpresscheckout which return shipping 
details. Then we need to pass payer id, token and other necessary information for doexpresschekout

*************************************************
-->
<cfparam name="form.PAYMENTACTION" default="authorization">
<cfparam name="form.PAYMENTAMOUNT" default="1.00">
<cfparam name="form.currencyCodeType" default="USD">

<body>
	<!-- 
		Getting the Credential information from the CredentialInfo component and retrieving amount 
		 from the form object	
	-->
<CFTRY>
	<cfset StructClear(Session)>
	<cfset serverName = #SERVER_NAME#>
	<cfset serverPort = #CGI.SERVER_PORT#>
	<cfset contextPath = GetDirectoryFromPath(#SCRIPT_NAME#)>
	<cfset protocol = #CGI.SERVER_PROTOCOL#>
	<cfset cancelUrlPath = "http://" & serverName & ":" & serverPort & contextPath & "orders.cfm">
	<cfset returnUrlPath = "http://" & serverName & ":" & serverPort & contextPath & "payPalExpressCheckout2.cfm?amt=#Form.paymentAmount#&currencycode=#Form.currencyCodeType#&paymentaction=#Form.PAYMENTACTION#">
	<CFOBJECT COMPONENT="CallerService" name="caller">
		
	<!-- 
		Passing necessary parameter to perform Setexpresscheckout transaction in the CFHTTP Tag
	-->

	<CFSET requestData = StructNew()>
	<CFSET requestData.METHOD = "SetExpressCheckout">
	<CFSET requestData.PAYMENTACTION = "#Form.PAYMENTACTION#">
	<CFSET requestData.USER = "#APIUserName#">
	<CFSET requestData.PWD = "#APIPassword#">
	<CFSET requestData.SIGNATURE = "#APISignature#">
	<CFSET requestData.VERSION = "#version#">
	<CFSET requestData.AMT = "#Form.paymentAmount#">
	<CFSET requestData.CURRENCYCODE = "#Form.currencyCodeType#">
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
<a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>