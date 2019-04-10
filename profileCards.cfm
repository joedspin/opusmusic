<cfinclude template="pageHead.cfm">
<cfparam name="url.addCard" default="no">
<style>
	body {background-color:#000000; font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: medium;}
	h1 {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: large; color:CCCCCC; margin-top: 24px; margin-bottom: 18px;}
	td {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: small; text-wrap:none;}
	input, select {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: medium;}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b>My Account</b><br>
    Stored Credit Cards</h1>
<cfquery name="myCards" datasource="#DSN#">
	select *
	from userCardsQuery
	where accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND store=1
</cfquery>
<cfquery name="cardTypes" datasource="#DSN#">
	select *
	from paymentTypes
	where PayName <> '' and isCC=1 AND PaymtID<5
	order by PayName ASC
</cfquery>
	<ul>
	<cfif myCards.RecordCount EQ 0>
	<li>No cards on file</li>
<cfelse>
	<cfoutput query="myCards">
    	<cfset theMonth=Decrypt(ccExpMo,encryKey71xu)>
		<cfset theYear=Decrypt(ccExpYr,encryKey71xu)>
        <cfset theCard=Decrypt(ccNum,encryKey71xu)>
        <cfset cardExpDate=NumberFormat(theYear+2000,"0000")&"-"&NumberFormat(theMonth,"00")>
		<li><a href="profileCardsEdit.cfm?ID=#myCards.ID#">EDIT</a> <a href="profileCardsDelete.cfm?ID=#myCards.ID#">DELETE</a> #ccName# #PayName# ending in #Right(Decrypt(ccNum,encryKey71xu),4)#<cfif cardExpDate LT DateFormat(varDateODBC,"yyyy-mm")> <font color="red">EXPIRED</font><cfelse> (expires #theMonth#/#theYear#)</cfif></li>
	</cfoutput>
</cfif>
	</ul>

			<cfif NOT url.addCard><p><a href="profileCards.cfm?addCard=true">Add New Card</a></p></cfif>

<cfform name="myCards" method="post" action="profileCardsAddAction.cfm" style="margin-top: 0px;">
<cfif url.addCard OR myCards.recordCount EQ 0>
	<table border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF" style="border-collapse: collapse;">
		<tr>
			<td colspan="4"><h1>New Credit Card:</h1></td>
		</tr>
		<tr>
			<td rowspan="7" colspan="2">&nbsp;</td>
			<td valign="middle">Type of Card:</td>
			<td colspan="2"><cfselect query="cardTypes" name="CCType" display="PayName" value="PaymtID" ></cfselect></td>
		</tr>
		<tr>
			<td valign="middle" >First Name on card:</td>
		  <td><cfinput type="Text" name="CCFirstName" size="20" maxlength="50" required="yes" message="First Name is required"></td>
		</tr>
        <tr>
			<td valign="middle" >Last Name on card:</td>
		  <td><cfinput type="Text" name="CCName" size="20" maxlength="50" required="yes" message="Last Name is required"></td>
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
				</cfselect><cfselect name="expyr">
					<cfset thisYear=DatePart("yyyy",varDateODBC)>
					<cfoutput>
						<cfloop from="#thisYear#" to="#thisYear+10#" index="y">
							<option value="#Right(y,"2")#">#y#</option>
						</cfloop>
					</cfoutput></cfselect>
			</td>
		</tr>
		<tr>
			<td valign="middle" nowrap>CCV:</td>
		  <td ><cfinput type="Text" name="CCV" message="CCV is required (3 digits for MC/Visa/Discover, 4 digits for Amex" required="yes" size="6" maxlength="4"></td>
		</tr>
        <tr>
        	<td colspan="2"><cfinput type="submit" name="submit" value="Add Card" id="addcard"></td>
        </tr>
	</table>
	</cfif>
    </cfform>
	<p><a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">