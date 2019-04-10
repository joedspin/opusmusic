<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<cfparam name="url.ret" default="">
<cfparam name="url.shipID" default="0">
<cfparam name="url.shipOptionID" default="0">
<cfquery name="thisAddress" datasource="#DSN#">
	select *
	from custAddresses
	where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cfquery name="states" datasource="#DSN#" cachedWithin="#CreateTimeSpan(0, 12, 0, 0)#">
	select *
	from statesQuery
	order by abbrev
</cfquery>
<cfquery name="countries" datasource="#DSN#" cachedWithin="#CreateTimeSpan(0, 0, 0, 30)#">
	select *
	from countries
	order by name
</cfquery>
<cfoutput query="thisAddress">
<style>
	body {background-color:##333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="##66FF00">My Account</font></b> Address Book: Edit</h1>
<cfform name="address" id="address" method="post" action="profileAddressesEditAction.cfm">
<input type="hidden" name="ID" value="#url.ID#" />
<input type="hidden" name="ret" value="<cfoutput>#url.ret#</cfoutput>">
<table border="0">
  <tr>
    <td>name for this address &nbsp;</td>
    <td>
      <cfinput type="text" name="addName" size="30" maxlength="30" value="#addName#" required="yes" message="name for this address is required.">
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>first name </td>
    <td><cfinput type="text" name="firstName" size="30" maxlength="50" value="#firstName#" required="yes" message="first name is required."></td>
  </tr>
  <tr>
    <td>last name </td>
    <td><cfinput type="text" name="lastName" size="30" maxlength="50" value="#lastName#" required="yes" message="last name is required."></td>
  </tr>
  <tr>
    <td>address line 1 </td>
    <td><cfinput type="text" name="add1" size="40" maxlength="255" value="#add1#" required="yes" message="address line 1 is required."></td>
  </tr>
  <tr>
    <td>address line 2 </td>
    <td><cfinput type="text" name="add2" size="40" maxlength="255" value="#add2#"></td>
  </tr>
  <tr>
    <td>address line 3 </td>
    <td><cfinput type="text" name="add3" size="40" maxlength="255" value="#add3#"></td>
  </tr>
  <tr>
    <td>city</td>
    <td><cfinput type="text" name="city" size="30" maxlength="100" value="#city#" required="yes" message="city is required."></td>
  </tr>
  <cfif countryID EQ 1>
  <tr>
    <td>state</td>
    <td><cfselect query="states" name="stateID" display="listName" value="ID" selected="#stateID#"><option value="0">select a state</option></cfselect></td>
  </tr>
  <cfelse>
  <tr>
    <td>state / province</td>
    <td><cfinput type="text" name="stateprov" size="30" maxlength="50" value="#stateprov#"></td>
  </tr>
  </cfif>
  <tr>
    <td>postal code </td>
    <td><cfinput type="text" name="postcode" size="10" maxlength="50" value="#postcode#" required="yes" message="postal code is required."></td>
  </tr>
  <tr>
    <td>country</td>
    <td><cfselect query="countries" name="countryID" display="name" value="ID" selected="#countryID#"></cfselect></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>phone</td>
    <td><cfinput type="text" name="phone" size="20" maxlength="50" value="#phone1#" required="yes" message="phone is required."></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
	<td><input type="submit" name="submit" value=" Save  " /></td>
    </tr>
</table>
<cfoutput>
	<input type="hidden" name="shipID" value="#url.shipID#" />
	<input type="hidden" name="shipOptionID" value="#url.shipOptionID#" />
</cfoutput>
</cfform>
<cfif url.ret EQ "">
	<p><a href="profileAddresses.cfm">Back to Manage Addresses</a><br />
			<a href="profile.cfm">Back to My Account</a></p>
<cfelseif url.ret EQ "cob">
	<cfoutput>
		<p><a href="checkOutBill.cfm?shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">Return to Checkout</a></p>
	</cfoutput>
<cfelseif url.ret EQ "cos">
	<cfoutput>
		<p><a href="checkOutShip.cfm?shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">Return to Checkout</a></p>
	</cfoutput>
</cfif>
<p>&nbsp;</p>
</blockquote>
</cfoutput>
<cfinclude template="pageFoot.cfm">