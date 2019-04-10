<cfinclude template="checkOutPageHead.cfm">
<cfparam name="form.billID" default="0">
<cfparam name="url.billID" default="#form.billID#">
<cfquery name="cardTypes" datasource="#DSN#">
	select *
	from paymentTypes
	where PayName <> '' and isCC=1 AND PaymtID<5
	order by PayName ASC
</cfquery>
<h4>Add Credit Card</h4>
<p>&nbsp;</p>
<h4>Choose Billing Address</h4>
<p><font color="#FFCC33">Please be sure the Billing Address selected below matches the address where 
  your 
  credit card<br /> 
  statement is mailed. If that address is not shown below, click &quot;Add New Address&quot;.</font></p>
<cfoutput>
	<p><a href="profileAddressesAdd.cfm?ret=prb&">Add New Address</a></p>
</cfoutput>
<cfform name="billingInfo" method="post" action="profileBillingAction.cfm" style="margin-top: 0px;">
<cfquery name="myAddresses" datasource="#DSN#">
	select *
	from custAddressesQuery
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
</cfquery>
<cfif myAddresses.recordCount GT 0>
	<table cellpadding="15">
	<tr>
	<cfoutput query="myAddresses">
		<td valign="top">
		<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<tr>
		<td valign="top">
		<input type="radio" name="billID" value="#ID#" <cfif ID EQ url.billID OR useFirst OR myAddresses.RecordCount EQ 1>checked</cfif>></td>
		<td><b>#addName#</b><br />
		#firstName# #LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country# [ <a href="profileAddressesEdit.cfm?ID=#ID#&ret=prb">edit</a> ]
		</tr>
		</table>
	</td>
	</cfoutput>
	</tr>
	</table>
	</cfif>

<table border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF" style="border-collapse: collapse;">
		

		<tr>
			<td colspan="2"><cfinput type="radio" name="cardChoice" value="0" required="yes" message="Please select a Payment Method." checked="yes"></td>
		  <td colspan="2"><font color="#CCCCCC">New Credit Card:</font></td>
		</tr>
		<tr>
			<td rowspan="7" colspan="2">&nbsp;</td>
			<td valign="middle">Type of Card:</td>
			<td colspan="2"><cfselect query="cardTypes" name="CCType" display="PayName" value="PaymtID" ></cfselect></td>
		</tr>
		<tr>
			<td valign="middle" >First Name on Card:</td>
		  <td ><cfinput type="Text" name="CCFirstName" size="30" maxlength="50"></td>
		</tr>
		<tr>
			<td valign="middle" >Last Name on Card:</td>
		  <td ><cfinput type="Text" name="CCName" size="30" maxlength="50"></td>
		</tr>
		<tr>
			<td valign="middle" >Card Number:</td>
		  <td ><cfinput type="Text" name="CCNum" message="Card Number not valid, please verify." validate="creditcard" size="30" maxlength="20"></td>
		</tr>
		<tr>
			<td valign="middle" >Card Expiration:</td>
			<td>
				<cfselect name="expmo">
					<option value="01">Jan</option>
					<option value="02">Feb</option>
					<option value="03">Mar</option>
					<option value="04">Apr</option>
					<option value="05">May</option>
					<option value="06">Jun</option>
					<option value="07">Jul</option>
					<option value="08">Aug</option>
					<option value="09">Sep</option>
					<option value="10">Oct</option>
					<option value="11">Nov</option>
					<option value="12">Dec</option>
				</cfselect>
				<cfselect name="expyr">
					<cfset thisYear=DatePart("yyyy",varDateODBC)>
					<cfoutput>
						<cfloop from="#thisYear#" to="#thisYear+10#" index="y">
							<option value="#Right(y,"2")#">#y#</option>
						</cfloop>
					</cfoutput></cfselect>
			</td>
		</tr>
		<tr>
			<td valign="middle" nowrap>Card CCV:<br />MC, Visa or<br />
            Discover = 3 digits<br />Amex = 4 digits</td>
		  <td ><cfinput type="Text" name="CCV" message="CCV is required (3 digits for MC/Visa/Discover, 4 digits for Amex" required="no" size="6" maxlength="4"><cfinput type="hidden" name="saveCard" value="Yes"></td>
		</tr>
		<tr>
        	<td colspan="2" align="right"><input type="submit" name="submit" value=" Next " /></td>
        </tr>

	</table>
	
</cfform>
<p><a href="index.cfm?manageCards=true" target="_top">Exit</a></p>


<!---<script type="text/javascript" data-pp-pubid="defb552e89" data-pp-placementtype="468x60"> (function (d, t) {
"use strict";
var s = d.getElementsByTagName(t)[0], n = d.createElement(t);
n.src = "//paypal.adtag.where.com/merchant.js";
s.parentNode.insertBefore(n, s);
}(document, "script"));
</script>//--->


<cfinclude template="checkOutPageFoot.cfm">