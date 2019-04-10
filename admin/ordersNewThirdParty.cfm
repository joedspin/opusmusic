<cfparam name="url.pageBack" default="orders.cfm">
<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<cfquery name="countries" datasource="#DSN#">
	select *
	from countries
	order by name
</cfquery>
<cfquery name="otherSites" datasource="#DSN#">
	select * 
	from otherSites
	order by otherSiteID
</cfquery>
<!---<cfquery name="allShipOptions" datasource="#DSN#">
	select ID as shippingOptionID, *
	from shippingRatesQuery
	order by countryID, cost1Record DESC
</cfquery>//--->
<cfquery name="states" datasource="#DSN#">
	select *
	from statesQuery
	order by abbrev
</cfquery>
<script language="javascript">
function validateForm()
{
var w=document.forms["neworder3"]["stateprov"].value;
var x=document.forms["neworder3"]["stateID"].value;
var y=document.forms["neworder3"]["countryID"].value;
var z=document.forms["neworder3"]["shipOptionID"].value;
if ((x==0 || x=="0") && w=="")
  {
  alert("You did not select a State or Enter a Province");
  return false;
  }

if (y==0 || y=="0")
  {
  alert("You did not select a Country");
  return false;
  }
if (z==0 || z=="0")
	{
	alert("You did not select a Shipping Option");
	return false;
	}
}

</script>
<cfform name="neworder3" id="neworder3id" method="post" action="ordersNewThirdPartyAction.cfm" onsubmit="return validateForm()">
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">New Account</font></b></h1>
<table cellpadding="15" cellspacing="0" border="0" style="border-collapse:collapse;">
<tr><td valign="top">
		<table border="0">
		<tr>
			<td>First / Last Name</td>
			<td>
			  <cfinput type="text" name="firstName" size="20" maxlength="50" required="yes" message="First Name is required."><cfinput type="text" name="lastName" size="20" maxlength="50" required="yes" message="Last Name is required.">
			</td>
		  </tr>
		  		  <tr>
				<td>email address</td>
				<td>
				  <cfinput type="text" name="email" size="40" maxlength="150" required="yes" message="error in email address.\nnote that it cannot contain spaces\nand must contain an @ symbol" validate="email">
				</td>
			  </tr>
		<tr>
			<td>username</td>
			<td>
			  <cfinput type="text" name="username" size="20" maxlength="25" required="yes" message="username is required.">
			</td>
		  </tr>
		  <tr>
			<td>password</td>
			<td>
			  <cfinput type="text" name="password" size="20" maxlength="15" required="yes" message="password is required.">
			</td>
		  </tr>
		  <!---<tr>
			<td>confirm password</td>
			<td>
			  <cfinput type="text" name="conpass" size="20" maxlength="15" required="yes" message="confirm password is required.">
			</td>
		  </tr>//--->
		  <tr>
		  	<td>other site</td>
			<td><cfselect name="otherSiteID" query="otherSites" display="name" value="otherSiteID" selected="2"></cfselect></td>
            </tr>
            <tr>
		  	<td>Discogs Order ##10096-</td>
			<td><cfinput type="text" name="otherSiteOrderNum" size="20" maxlength="25"></td>
            </tr>
		</table>
</td>
<td valign="top">
<table border="0">
  <tr>
    <td>address 1 </td>
    <td><cfinput type="text" name="add1" size="40" maxlength="255" required="yes" message="address line 1 is required."></td>
  </tr>
  <tr>
    <td>address 2 </td>
    <td><cfinput type="text" name="add2" size="40" maxlength="255"></td>
  </tr>
  <tr>
    <td>address 3 </td>
    <td><cfinput type="text" name="add3" size="40" maxlength="255"></td>
  </tr>
  <tr>
    <td>city</td>
    <td><cfinput type="text" name="city" size="30" maxlength="100" required="yes" message="city is required."></td>
  </tr>
   <tr>
    <td>state / province</td>
    <td><cfselect query="states" name="stateID" display="listName" value="ID"><option value="0" selected>select a state</option></cfselect> OR <cfinput type="text" name="stateprov" size="30" maxlength="50"></td>
  </tr>
  <tr>
    <td>postal code </td>
    <td><cfinput type="text" name="postcode" size="10" maxlength="50" required="yes" message="postal code is required."></td>
  </tr>
  <tr>
    <td>country</td>
    <td><cfselect query="countries" name="countryID" display="name" value="ID" selected="1"></cfselect></td>
  </tr><tr>
    <td>phone</td>
    <td><cfinput type="text" name="phone" size="20" maxlength="50" required="yes" message="phone is required."></td>
  </tr>
</table>
</td>
</tr>
</table>
<p align="right">Shipping Option <select name="shipOptionID"><cfoutput query="Application.allShipOptions">
            	<cfif shippingOptionID EQ 1><option value="#shippingOptionID#" selected>#country# - #name#</option><cfelse><option value="#shippingOptionID#">#country# - #name#</option></cfif></cfoutput></select></p>
<p align="right"><input type="checkbox" value="yes" name="sendNotice">Uncheck this box if you do not want to<br>send an email notification about the new account.</p>
<p align="right">Comments or Special Requests:<br /><textarea name="comments" rows="10" cols="60"></textarea></p>
<p align="right"><input type="submit" name="submit" value="Create Account and Start Order" /></p>
</cfform>
<cfinclude template="pageFoot.cfm">