<cfinclude template="pageHead.cfm">
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">My Account</font></b> Address Book</h1>
<ul><li><a href="profileAddressesAdd.cfm">Add New Address</a></li>
<cfquery name="myAddresses" datasource="#DSN#">
	select *
	from custAddresses
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
</cfquery>
<cfoutput query="myAddresses">
	<li><cfif addName EQ "">unnamed address<cfelse>#addName#</cfif> [ <a href="profileAddressesEdit.cfm?ID=#ID#">edit</a> ] [ <a href="profileAddressesDelete.cfm?ID=#ID#">delete</a> ]</li>
</cfoutput>
	</ul>
	<p><a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">