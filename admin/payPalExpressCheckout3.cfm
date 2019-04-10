<!-- 
*************************************************
DoExpressCheckoutPayment.cfm

This page takes necessary parameter from GetExpressCheckoutDetails page 
and pssing into doHttppost function to perform doExpressCheckout  
This page will show the response value coming from the Server. If any error occurs,
the page will redirect to APIError.cfm to show exact error details

*************************************************
-->


<head>
    <title>PayPal CF SDK - DoExpressCheckoutPayment API</title>
    <link href="sdk.css" rel="stylesheet" type="text/css" />
</head>


<body>
    <center>
	
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
		  <center>
			<br>
				<center>
				<font size=2 color=black face=Verdana><b>DoExpressCheckoutPayment</b></font>
				<br><br>
				<b>Thank you for your payment!</b><br><br>
				
		    <table class="api">
			<tr>
			    <td class="field">
				Transaction ID:</td>
			    <td><CFOUTPUT>#responseStruct.TRANSACTIONID#</CFOUTPUT></td>
			</tr>
			<tr>
			    <td class="field">
				Amount:</td>
			    <td>USD <CFOUTPUT>#responseStruct.AMT#</CFOUTPUT></td>
			</tr>
		    </table>
		    </center>
		</cfif>
	<cfif responseStruct.Ack is "Failure">
		<CFLOCATION URL="APIError.cfm?error=fromServer"> 
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
	<CFLOCATION URL="APIError.cfm?error=fromClient">
</CFCATCH>
</CFTRY>
</center> </center>
</body>
<a class="home" id="CallsLink" href="index.html">Home</a>
</html>