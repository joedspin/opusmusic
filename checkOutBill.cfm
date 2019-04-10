<cfinclude template="checkOutPageHead.cfm">
<cfparam name="url.shipID" default="0">
<cfparam name="url.billID" default="0">
<cfparam name="url.shipOptionID" default="0">
<cfparam name="url.promo" default="">
<cfparam name="url.addCard" default="false">
<cfparam name="url.thisPromo" default="">
<cfparam name="url.cshok" default="false">
<cfquery name="thisShipping" datasource="#DSN#">
	select *
	from custAddresses
	where ID=<cfqueryparam value="#url.shipID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfquery name="cardTypes" datasource="#DSN#">
	select *
	from paymentTypes
	where PayName <> '' and isCC=1 AND PaymtID<5
	order by PayName ASC
</cfquery>
<h4>Payment</h4>
<cfif url.thisPromo EQ "not valid">
	<h1><strong><font color="#990000">Promo Code NOT VALID.</font></strong><font color="#FFCC33"><br />
    <font color="#CCCCCC">No discount has been applied.</font></font></h1>
<cfelseif url.thisPromo NEQ "">
	<h1><strong><font color="#66FF00">Promo Code Accepted</font></strong><font color="#FFCC33"><br />
    <font color="#CCCCCC">Your <cfoutput>#url.thisPromo#</cfoutput> has been applied</font></font></h1>
</cfif>
<p>&nbsp;</p>
<h4>Choose Billing Address</h4>
<p><font color="#FFCC33">Please be sure the Billing Address selected below matches the address where 
  your 
  credit card<br /> 
  statement is mailed. If that address is not shown below, click &quot;Add New Address&quot;.</font></p>
<cfoutput>
	<p><a href="profileAddressesAdd.cfm?ret=cob&shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">Add New Address</a></p>
</cfoutput>
<cfform name="billingInfo" method="post" action="checkOutBillAction.cfm" style="margin-top: 0px;">
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
		#country# [ <a href="profileAddressesEdit.cfm?ID=#ID#&ret=cob&shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">edit</a> ]
		</tr>
		</table>
	</td>
	</cfoutput>
	</tr>
	</table>
	</cfif>
<cfoutput><input type="hidden" name="shipID" value="#url.shipID#" /><input type="hidden" name="shipOptionID" value="#url.shipOptionID#" /></cfoutput>
<h4>Choose a Payment Method</h4>
<table border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF" style="border-collapse: collapse;">
		<!---<cfif Cookie.userID EQ Session.userID><cfset thisUserID=Session.userID></cfif>//--->
		<cfif Session.userID NEQ 0><cfset thisUserID=Session.userID><cfelse><cfset thisUserID=Session.userID></cfif>
		<cfquery name="myCards" datasource="#DSN#">
			select *
			from userCardsQuery
			where accountID=<cfqueryparam value="#thisUserID#" cfsqltype="cf_sql_integer"> AND store=1
		</cfquery>
		<cfif NOT url.addCard AND myCards.recordCount NEQ 0>
			<cfoutput>
				<tr>
					<td colspan="4"><a href="checkOutBill.cfm?addCard=true&shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">Add New Card</a></td>
				</tr>
			</cfoutput>	
		</cfif>
		<cfif myCards.recordCount NEQ 0>
		<cfset noCheck=true>
			<cfoutput query="myCards">
				<tr>
					<cfif noCheck><cfset optionCheck="yes"><cfelse><cfset optionCheck="no"></cfif>
                    
                    <cfset theMonth=Decrypt(ccExpMo,encryKey71xu)>
                    <cfset theYear=Decrypt(ccExpYr,encryKey71xu)>
                    <cfset theCard=Decrypt(ccNum,encryKey71xu)>
                    <cfset cardExpDate=NumberFormat(theYear+2000,"0000")&"-"&NumberFormat(theMonth,"00")&"-00">
                    <!---#cardExpDate# / #DateFormat(varDateODBC,"yyyy-mm-dd")# / #cardExpDate LT DateFormat(varDateODBC,"yyyy-mm-dd")#//--->
					<cfif cardExpDate LT DateFormat(varDateODBC,"yyyy-mm-dd")><td colspan="2" align="center"><font color="red"><b>X</b></font></td>
                    
				  <td colspan="2"><font color="##CCCCCC">Stored #PayName# ending in #Right(theCard,"4")#</font><font color="red"> EXPIRED DO NOT USE</font> <a href="cardDelete.cfm?ID=#myCards.ID#&ret=cob&shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">delete</a></td>
                    <cfelse>
				  <td colspan="2"><cfinput type="radio" name="cardChoice" value="#ID#" required="yes" message="Please select a Payment Method." checked="#optionCheck#"></td><td colspan="2"><font color="##CCCCCC">Stored #PayName# ending in #Right(theCard,"4")#</font> <a href="cardDelete.cfm?ID=#myCards.ID#&ret=cob&shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">delete</a></td>
                  </cfif>
				</tr>
				<cfset noCheck=false>
			</cfoutput>
		</cfif>
		<!---<cfquery name="lookupUser" datasource="#DSN#">
				select username
				from custAccounts
				where ID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
					AND password LIKE '%discogs%' OR password LIKE '%amazon%'
		</cfquery>//--->
		<cfif url.cshok>
            <tr>
                <td colspan="2" nowrap><cfinput type="radio" name="cardChoice" value="C" required="yes" message="Please select a Payment Method."></td>
              <td colspan="2" nowrap><font color="#CCCCCC">Cash</font></td>
            </tr>
        </cfif>
		<cfif thisShipping.countryID EQ 1>
        <tr>
			<td colspan="2" nowrap><cfinput type="radio" name="cardChoice" value="M" required="yes" message="Please select a Payment Method."></td>
		  <td colspan="2" nowrap><font color="#CCCCCC">Money Order</font></td>
		</tr>
		</cfif>
		<!---<tr>
			<td colspan="2" nowrap><cfinput type="radio" name="cardChoice" value="P" required="yes" message="Please select a Payment Method.">&nbsp;</td>
		  <td colspan="2" nowrap><img src="images/PayPal_mark_37x23.gif" align="left" style="margin-right:7px;"><span style="font-size:11px; font-family: Arial, Verdana;">The safer, easier way to pay.<!---The PayPal payment option is temporarily unavaialble.//---></span></td>
		</tr>//--->
		<cfif url.addCard OR myCards.recordCount EQ 0>
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
					<option value="01">01 - Jan</option>
					<option value="02">02 - Feb</option>
					<option value="03">03 - Mar</option>
					<option value="04">04 - Apr</option>
					<option value="05">05 - May</option>
					<option value="06">06 - Jun</option>
					<option value="07">07 - Jul</option>
					<option value="08">08 - Aug</option>
					<option value="09">09 - Sep</option>
					<option value="10">10 - Oct</option>
					<option value="11">11 - Nov</option>
					<option value="12">12 - Dec</option>
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
		  <td ><cfinput type="Text" name="CCV" size="6" maxlength="4"></td>
		</tr>
		<tr>
			<td valign="middle" nowrap>Store for Future Use:</td>
		  <td ><cfinput type="checkbox" name="saveCard" value="Yes" checked="yes"></td>
		</tr>
		</cfif>
	</table>
	<p><cfoutput><input type="hidden" name="thisPromo" value="#url.thisPromo#" /></cfoutput><input type="submit" name="submit" value=" Next " /></p>
</cfform>
<p><a href="http://downtown304.com/index.cfm" target="_top">Continue Shopping</a></p>

<!---
<script type="text/javascript" data-pp-pubid="defb552e89" data-pp-placementtype="468x60"> (function (d, t) {
"use strict";
var s = d.getElementsByTagName(t)[0], n = d.createElement(t);
n.src = "//paypal.adtag.where.com/merchant.js";
s.parentNode.insertBefore(n, s);
}(document, "script"));
</script>
//--->

<cfinclude template="checkOutPageFoot.cfm">