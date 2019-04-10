<cfparam name="url.admin" default="">
<cfparam name="Session.useremail" default="">
<cfif url.admin NEQ "marianneauth"><cfabort></cfif>

<cfset pageName="CUSTOMERS">
<cfinclude template="pageHead.cfm">

<cfparam name="url.ID" default="0">
<cfparam name="url.custID" default="0">
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#url.ID#
</cfquery>
<cfquery name="cardTypes" datasource="#DSN#">
	select *
	from paymentTypes
	where PayName <> '' and isCC=1 AND PaymtID<4
	order by PayName ASC
</cfquery>
<cfform name="userCard" action="customersOpusCardEditAction.cfm" method="post">
<table border="0" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" style="border-collapse: collapse;">
<cfoutput query="thisCard">
		<tr>
			<td rowspan="7" colspan="2">&nbsp;</td>
			<td valign="middle">Type of Card:</td>
			<td colspan="2"><cfselect query="cardTypes" name="CCTypeID" display="PayName" value="PaymtID" selected="#ccTypeID#"></cfselect></td>
		</tr>
		<tr>
			<td valign="middle" >First Name on Card:</td>
		  <td ><cfinput type="Text" name="CCFirstName" size="30" maxlength="50" value="#ccFirstName#"></td>
		</tr>
		<tr>
			<td valign="middle" >Last Name on Card:</td>
		  <td ><cfinput type="Text" name="CCName" size="30" maxlength="50" value="#ccName#"></td>
		</tr>
		<cfmail to="order@downtown304.com" from="info@downtown304.com" cc="marianne@downtown304.com" subject="USER CARD DATA ACCESSED">
	user email: #Session.useremail#
	card name: #ccFirstName# #ccName#
	</cfmail>
		<tr>
			<td valign="middle" >Card Number:</td>
		  <td ><cfinput type="Text" name="CCNum" message="Card Number not valid, please verify." validate="creditcard" size="30" maxlength="20" value="#Decrypt(ccNum,encryKey71xu)#"></td>
		</tr>
		<tr>
			<td valign="middle" >Card Expiration:</td>
			<td>
				<cfselect name="CCExpMo">
					<option value="01"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "01"> selected</cfif>>Jan</option>
					<option value="02"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "02"> selected</cfif>>Feb</option>
					<option value="03"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "03"> selected</cfif>>Mar</option>
					<option value="04"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "04"> selected</cfif>>Apr</option>
					<option value="05"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "05"> selected</cfif>>May</option>
					<option value="06"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "06"> selected</cfif>>Jun</option>
					<option value="07"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "07"> selected</cfif>>Jul</option>
					<option value="08"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "08"> selected</cfif>>Aug</option>
					<option value="09"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "09"> selected</cfif>>Sep</option>
					<option value="10"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "10"> selected</cfif>>Oct</option>
					<option value="11"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "11"> selected</cfif>>Nov</option>
					<option value="12"<cfif Decrypt(ccExpMo,encryKey71xu) EQ "12"> selected</cfif>>Dec</option>
				</cfselect>
				<cfselect name="CCExpYr" selected="#Decrypt(ccExpYr,encryKey71xu)#">
					<cfset thisYear=DatePart("yyyy",varDateODBC)>
					<cfoutput>
						<cfloop from="#thisYear#" to="#thisYear+10#" index="y">
							<option value="#Right(y,"2")#"<cfif Decrypt(ccExpYr,encryKey71xu) EQ Right(y,"2")> selected</cfif>>#y#</option>
						</cfloop>
					</cfoutput></cfselect>
			</td>
		</tr>
		<tr>#Decrypt(ccExpMo,encryKey71xu)#/#Decrypt(ccExpYr,encryKey71xu)#<br />
	#ccFirstName# #ccName# #Decrypt(ccCCV,encryKey71xu)#
			<td valign="middle" nowrap>Card CCV:</td>
		  <td ><cfinput type="Text" name="ccCCV" message="CCV is required (3 digits for MC/Visa, 4 digits for Amex" required="yes" size="6" maxlength="4" value="#Decrypt(ccCCV,encryKey71xu)#"></td>
		</tr>
		</cfoutput>
	</table>
	<input type="submit" name="submit" value="Save Changes" /> <input type="submit" name="submit" value="Cancel" />
	<cfinput type="hidden" name="ID" value="#url.ID#" /><cfinput type="hidden" name="custID" value="#url.custID#" />
</cfform>
<cfinclude template="pageFoot.cfm">