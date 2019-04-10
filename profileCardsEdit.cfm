<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<cfparam name="url.addCard" default="no">
<style>
	body {background-color:#000000; font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: medium;}
	h1 {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: large; color:CCCCCC; margin-top: 24px; margin-bottom: 18px;}
	td {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: small; text-wrap:none;}
	input, select {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: medium;}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b>My Account</b><br>
    Stored Credit Cards: Edit</h1>
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer"> AND accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> 
</cfquery>
<cfquery name="cardTypes" datasource="#DSN#">
	select *
	from paymentTypes
	where PayName <> '' and isCC=1 AND PaymtID<5
	order by PayName ASC
</cfquery>
<cfform name="thisCard" method="post" action="profileCardsEditAction.cfm" style="margin-top: 0px;">
<cfinput type="hidden" name="cardID" value="#thisCard.ID#">
<cfif thisCard.recordCount NEQ 0>
	<table border="0" cellpadding="0" cellspacing="1" bordercolor="#FFFFFF" style="border-collapse: collapse;">
		<tr>
			<td rowspan="7" colspan="2">&nbsp;</td>
			<td valign="middle">Type of Card:</td>
			<td colspan="2"><cfselect query="cardTypes" name="CCType" display="PayName" value="PaymtID" selected="#thisCard.ccTypeID#"></cfselect></td>
		</tr>
		<tr>
          <td valign="middle" >First Name on card:</td>
		  <td><cfinput type="Text" name="CCFirstName" size="20" maxlength="50" required="yes" message="First Name is required" value="#thisCard.ccFirstName#"></td>
		</tr>
        <tr>
			<td valign="middle" >Last Name on card:</td>
		  <td><cfinput type="Text" name="CCName" size="20" maxlength="50" required="yes" message="Last Name is required" value="#thisCard.ccName#"></td>
		</tr>
		<tr>
			<td valign="middle" >Card Number:</td>
		  <td ><cfinput type="Text" name="CCNum" message="Card Number is required." required="yes" size="30" maxlength="20" value="#REReplace(Decrypt(thisCard.ccNum,encryKey71xu),".(?=.{4})","#chr(8226)#","all")#"><cfinput type="hidden" name="oldNum" value="#REReplace(Decrypt(thisCard.ccNum,encryKey71xu),".(?=.{4})","#chr(8226)#","all")#"></td>
		</tr>
        <cfset theMonth=Decrypt(thisCard.ccExpMo,encryKey71xu)>
		<cfset theYear=Decrypt(thisCard.ccExpYr,encryKey71xu)>
		<tr>
			<td valign="middle" >Card Expiration:</td>
			<td>
				<cfselect name="expmo">
					<cfif theMonth EQ "01"><option value="01" selected><cfelse><option value="01" ></cfif>01 - Jan</option>
					<cfif theMonth EQ "02"><option value="02" selected><cfelse><option value="02" ></cfif>02 - Feb</option>
					<cfif theMonth EQ "03"><option value="03" selected><cfelse><option value="03" ></cfif>03 - Mar</option>
					<cfif theMonth EQ "04"><option value="04" selected><cfelse><option value="04" ></cfif>04 - Apr</option>
					<cfif theMonth EQ "05"><option value="05" selected><cfelse><option value="05" ></cfif>05 - May</option>
					<cfif theMonth EQ "06"><option value="06" selected><cfelse><option value="06" ></cfif>06 - Jun</option>
					<cfif theMonth EQ "07"><option value="07" selected><cfelse><option value="07" ></cfif>07 - Jul</option>
					<cfif theMonth EQ "08"><option value="08" selected><cfelse><option value="08" ></cfif>08 - Aug</option>
					<cfif theMonth EQ "09"><option value="09" selected><cfelse><option value="09" ></cfif>09 - Sep</option>
					<cfif theMonth EQ "10"><option value="10" selected><cfelse><option value="10" ></cfif>10 - Oct</option>
					<cfif theMonth EQ "11"><option value="11" selected><cfelse><option value="11" ></cfif>11 - Nov</option>
					<cfif theMonth EQ "12"><option value="12" selected><cfelse><option value="12" ></cfif>12 - Dec</option>
				</cfselect><cfselect name="expyr">
					<cfset thisYear=DatePart("yyyy",varDateODBC)>
					<cfoutput>
						<cfloop from="#thisYear#" to="#thisYear+10#" index="y">
                    		<cfset twoDigitYear=#Right(y,"2")#>
							<cfif theYear EQ twoDigitYear><option value="#twoDigitYear#" selected><cfelse><option value="#twoDigitYear#"></cfif>#y#</option>
						</cfloop>
					</cfoutput></cfselect>
			</td>
		</tr>
		<tr>
			<td valign="middle" nowrap>Card CCV:</td>
		  <td ><cfinput type="Text" name="CCV" message="You must re-enter the CCV number to edit the card (3 digits for MC/Visa/Discover, 4 digits for Amex" required="yes" size="6" maxlength="4"></td>
		</tr>
        <tr>
        	<td colspan="2"><cfinput type="submit" name="submit" value="Save Changes" id="savechanges"></td>
        </tr>
	</table>
	</cfif>
    </cfform>
    <p><a href="profileCards.cfm">Back to Stored Credit Cards</a><br />
	<p><a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">