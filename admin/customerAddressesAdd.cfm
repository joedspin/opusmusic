<cfset pageName="CUSTOMERS">
<cfinclude template="pageHead.cfm">
<cfparam name="url.ret" default="">
<cfparam name="url.custID" default="0">
<cfparam name="url.retOrderID" default="0">
<cfquery name="states" datasource="#DSN#" cachedWithin="#CreateTimeSpan(1, 0, 0, 0)#">
	select *
	from statesQuery
	order by abbrev
</cfquery>
<cfquery name="countries" datasource="#DSN#" cachedWithin="#CreateTimeSpan(0, 0, 1, 0)#">
	select *
	from countries
	order by name
</cfquery>
<cfquery name="userCountry" datasource="#DSN#">
	select countryID
	from custAccounts
	where ID=<cfqueryparam value="#url.custID#" cfsqltype="integer">
</cfquery>
<cfif userCountry.RecordCount EQ 0>
	<cfset thisCountryID=1>
<cfelse>
	<cfset thisCountryID=userCountry.countryID>
</cfif>
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">Add New Address</font></b></h1>
<cfform name="address" id="address" method="post" action="customerAddressesAddAction.cfm">
<input type="hidden" name="retOrderID" value="<cfoutput>#url.retOrderID#</cfoutput>">
<input type="hidden" name="custID" value="<cfoutput>#url.custID#</cfoutput>">
<table border="0">
  <!---<tr>
    <td>Name for this address &nbsp;</td>
    <td>
      <cfinput type="text" name="addName" size="30" maxlength="30" required="yes" message="name for this address is required.">
    </td>
  </tr>//--->
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>first name </td>
    <td><cfinput type="text" name="firstName" size="30" maxlength="50" required="yes" message="first name is required."></td>
  </tr>
  <tr>
    <td>last name </td>
    <td><cfinput type="text" name="lastName" size="30" maxlength="50" required="yes" message="last name is required."></td>
  </tr>
  <tr>
    <td>address line 1 </td>
    <td><cfinput type="text" name="add1" size="40" maxlength="255" required="yes" message="address line 1 is required."></td>
  </tr>
  <tr>
    <td>address line 2 </td>
    <td><cfinput type="text" name="add2" size="40" maxlength="255"></td>
  </tr>
  <tr>
    <td>address line 3 </td>
    <td><cfinput type="text" name="add3" size="40" maxlength="255"></td>
  </tr>
  <tr>
    <td>city</td>
    <td><cfinput type="text" name="city" size="30" maxlength="100" required="yes" message="city is required."></td>
  </tr>
  <cfif thisCountryID EQ 1>
  <tr>
    <td>state</td>
    <td><cfselect query="states" name="stateID" display="listName" value="ID"><option value="0">select a state</option></cfselect></td>
  </tr>
  <cfelse>
   <tr>
    <td>state / province</td>
    <td><cfinput type="text" name="stateprov" size="30" maxlength="50"></td>
  </tr>
  </cfif>
  <tr>
    <td>postal code </td>
    <td><cfinput type="text" name="postcode" size="10" maxlength="50" required="yes" message="postal code is required."></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>country</td>
    <td><cfselect query="countries" name="countryID" display="name" value="ID" selected="#thisCountryID#"></cfselect></td>
  </tr><tr>
    <td>phone</td>
    <td><cfinput type="text" name="phone" size="20" maxlength="50" required="yes" message="phone is required."></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
	<td><cfoutput><input type="submit" name="submit" value=" Save  " /><input type="hidden" name="ret" value="#url.ret#"></cfoutput></td>
    </tr>
</table>
</cfform>
<cfoutput><p><a href="ordersEdit.cfm?ID=#url.retOrderID#">Back to Order</a></p></cfoutput>
<p>&nbsp;</p>
</blockquote>
<cfinclude template="pageFoot.cfm">