<cfparam name="url.ID" default="0">
<cfparam name="url.find" default="">
<cfparam name="url.findField" default="">
<cfset pageName="CUSTOMERS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisCust" datasource="#DSN#">
 select *
 from custAccounts
 where ID=#url.ID#
</cfquery>
<cfform name="cust" action="customersOpusDeleteAction.cfm" method="post">
	<input type="hidden" name="find" value="#url.find#">
	<input type="hidden" name="findField" value="#url.findField#">
<p>Are you sure you want to delete this customer (action cannot be undone)?</p>
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisCust">
			<tr>
				<td>Username:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#username#" size="40" maxlength="100" passthrough="readonly"></td>
			</tr>
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#firstName# #lastName#" size="40" maxlength="100" passthrough="readonly"></td>
			</tr>
			<tr>
				<td>Email:&nbsp;</td>
				<td><cfinput type="text" name="sort" value="#email#" size="20" maxlength="30" passthrough="readonly"></td>
			</tr>	
		</cfoutput>
	</table>
	<p><cfinput type="submit" name="delete" value="Yes">&nbsp;<cfinput type="submit" name="delete" value="No"></p>
	<cfoutput><input type="hidden" name="ID" value="#ID#" /></cfoutput>
</cfform>
<cfinclude template="pageFoot.cfm">