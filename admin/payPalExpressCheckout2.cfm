<!-- 
*************************************************
GetExpressCheckoutDetails.cfm

This page shows shipping details coming from the server's response object. When click the submit button
token, payerid, amount, currency and other necessary information passed into DoExpressChekoutpayment.cfm.	

*************************************************
-->

<head>
<title>PayPal CF SDK - ExpressCheckout API</title>
<link href="sdk.css" rel="stylesheet" type="text/css" />
</head>

<body>
  <CFFORM ACTION="payPalExpressCheckout3.cfm" method="post">

<CFTRY>

	<cfset StructClear(Session)>
	
	<CFOBJECT COMPONENT="CallerService" name="caller">
<!---
	<CFHTTP URL="#serverURL#" METHOD="POST" THROWONERROR="YES">
	  <CFHTTPPARAM NAME="METHOD" VALUE="GetExpressCheckoutDetails" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="USER" VALUE="#APIUserName#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="PWD" VALUE="#APIPassword#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="SIGNATURE" VALUE="#APISignature#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="VERSION" VALUE="#version#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="PAYERID" VALUE="#URL.payerId#" TYPE="FormField" ENCODED="YES">
	  <CFHTTPPARAM NAME="TOKEN" VALUE="#URL.token#" TYPE="FormField" ENCODED="YES">

	</CFHTTP>
--->
	<CFSET requestData = StructNew()>
	<CFSET requestData.METHOD = "GetExpressCheckoutDetails">
	<CFSET requestData.USER = "#APIUserName#">
	<CFSET requestData.PWD = "#APIPassword#">
	<CFSET requestData.SIGNATURE = "#APISignature#">
	<CFSET requestData.VERSION = "#version#">
	<CFSET requestData.TOKEN = "#URL.token#">

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
<cfif not StructKeyExists(responseStruct, "SHIPTOSTREET2")>
	<cfset responseStruct.SHIPTOSTREET2 = "">
</cfif>
  <cfif responseStruct.Ack is "Success">
	<center>
           <table width =400>
	   <tr>
            <td colspan="2" align = center>
            <font size=larger color=black face=Verdana><b>GetExpressCheckoutDetails </br></br> </b> </font> 
            </td>
         </tr> 
			
			<tr>
				<td>
                   <b>Order Total:</b> </td>
                <td>USD <CFOUTPUT>#URL.AMT#</CFOUTPUT></td>
            </tr>
            <tr>
			<td><b>Shipping Address:</b></td>
			</tr>
            <tr>
                <td >
                    Street 1:</td>
                <td><CFOUTPUT>#responseStruct.SHIPTOSTREET#</CFOUTPUT></td>
            </tr>
            <tr>
                <td >
                    Street 2:</td>
                <td><CFOUTPUT>#responseStruct.SHIPTOSTREET2#</CFOUTPUT></td>
            </tr>
            <tr>
                <td >
                    City:</td>
                <td><CFOUTPUT>#responseStruct.SHIPTOCITY#</CFOUTPUT></td>
            </tr>
            <tr>
                <td >
                    State:</td>
                <td><CFOUTPUT>#responseStruct.SHIPTOSTATE#</CFOUTPUT></td>
            </tr>
            <tr>
                <td >
                    Postal code:</td>
                <td><CFOUTPUT>#responseStruct.SHIPTOZIP#</CFOUTPUT></td>
            </tr>
            <tr>
                <td >
                    Country:</td>
                <td><CFOUTPUT>#responseStruct.SHIPTOCOUNTRYNAME#</CFOUTPUT></td>
            </tr>
            <tr>
                <td colspan="2" align = center>
                    <input type="submit" value="Pay" />
                </td>
            </tr>
        </table>
	</center>
</cfif>

<cfif responseStruct.Ack is "Failure">
	<CFLOCATION URL="APIError.cfm?error=fromServer"> 
</cfif>

    <CFINPUT TYPE="hidden"  NAME="payerId" VALUE="#URL.payerId#">
    <CFINPUT TYPE="hidden" NAME="token" VALUE="#URL.token#">
    <CFINPUT TYPE="hidden"  NAME="amount" VALUE="#URL.AMT#">
    <CFINPUT TYPE="hidden" NAME="currencycode" VALUE="#URL.currencycode#">
    <CFINPUT TYPE="hidden" NAME="paymentaction" VALUE="#URL.paymentaction#">

    <!--
		Following variable passed as hidden values in the doexpresschekout 
		page to perform expresscheckout transaction
	-->
<CFCATCH>

	<cfset responseStruct = StructNew() >
	<cfset responseStruct.errorType =  "#cfcatch.type#">
	<cfset responseStruct.errorMessage =  "#cfcatch.message#">
	<cfset Session.resStruct = "#responseStruct#">
	<CFLOCATION URL="APIError.cfm?error=fromClient">
	
</CFCATCH>
</CFTRY>
  </CFFORM>
<a class="home" id="CallsLink" href="index.html">Home</a>
</body>
</html>