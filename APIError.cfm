<!---<cfinclude template="checkOutPageHead.cfm">//--->
<div align="center">
<p align="left"><font color="red" size="4">There was an error processing your credit card. Please <a href="http://www.downtown304.com/index.cfm">click here</a> to go back and try again.<br>
  The response from the credit card processor is shown below.</font></p>
<p align="left"><strong><font color="#FF9900" size="5">YOUR ORDER HAS NOT BEEN PLACED</font></strong></p>
<p align="left">You may need to check with your bank or card provider.</p>
<p align="left">If you need assistance from Downtown 304, please email order@downtown304.com</p>
<p align="left">&nbsp;</p>
</div>
<cfset responseStruct = #Session.resStruct#>
<cfif #URL.error# is "fromClient">
<center>
    <table class="api">
      <tr>
            <td class="field">
                Error Type :</td>
            <td><CFOUTPUT>#responseStruct.errorType#</CFOUTPUT></td>
        </tr>
        <tr>
            <td class="field">
                Error Message :</td>
            <td><CFOUTPUT>#responseStruct.errorMessage#</CFOUTPUT></td>
        </tr>
	</table>
</center>
</cfif>

<cfif #URL.error# is "fromServer">
<center>
<table class="api">
	<tr>
		<td colspan="2" class="header">CREDIT CARD TRANSACTION FAILED</td>
	</tr>
	<cfloop collection=#responseStruct# item="key">
		<tr>
			<td><CFOUTPUT>#key#:</CFOUTPUT></td>
			<td><CFOUTPUT>#responseStruct[key]#</CFOUTPUT></td>
	       </tr>
	</cfloop>
</table>
</center>
</cfif>
<cfinclude template="checkOutPageFoot.cfm">