<cfset pageName="CUSTOMERS">
<cfparam name="url.letter" default="a">
<cfparam name="url.find" default="">
<cfparam name="url.findField" default="">
<cfparam name="form.find" default="#url.find#">
<cfparam name="form.findField" default="#url.findField#">
<cfinclude template="pageHead.cfm">
<form name="customerFind" action="customersOpus.cfm" method="post">
<cfoutput>Find: <input type="text" name="find" value="#form.find#" /></cfoutput><input type="submit" name="findField" value="email" /><input type="submit" name="findField" value="firstName" /><input type="submit" name="findField" value="lastName" /><input type="submit" name="findField" value="username" />
</form>
<cfif form.findField NEQ "">
	<cfquery name="allCustomers" datasource="#DSN#" maxRows="100">
		select *
		from custAccounts
		where #Trim(form.findField)# LIKE '%#form.find#%'
        order by username
	</cfquery>
<cfelseif url.letter EQ "none">
	<cfquery name="allCustomers" datasource="#DSN#">
		select *
		from custAccounts 
		where lastName=''
		order by lastName
	</cfquery>
<cfelse>
	<cfquery name="allCustomers" datasource="#DSN#">
		select *
		from custAccounts
		where Left(lastName,1)='#url.letter#'
		order by lastName
	</cfquery>
</cfif>
<p><cfoutput>#allCustomers.recordCount#</cfoutput> Customer Accounts</p>
<cfquery name="letterList" datasource="#DSN#">
	select DISTINCT Left(lastName,1) As custLetter
	from custAccounts
    order by Left(lastName,1)
</cfquery>
<p><cfoutput query="letterList"><cfif custLetter NEQ ""><a href="customersOpus.cfm?letter=#custLetter#">#UCase(custLetter)#</a>
<cfelse><a href="customersOpus.cfm?letter=none">[no last name]</a></cfif> </cfoutput></p>
<table border="1" style="border-collapse:collapse;" cellpadding="4">
<cfoutput query="allCustomers">
	<tr>
		<td><a href="customersOpusEdit.cfm?ID=#ID#&find=#form.find#&findField=#form.findField#">EDIT</a></td>
        <td><a href="customersOpusDelete.cfm?ID=#ID#&find=#form.find#&findField=#form.findField#">DELETE</a></td>
        <td><a href="ordersShopStart.cfm?username=#username#">SHOP</a></td>
        <td><a href="customersOpusStatement.cfm?ID=#ID#">STATEMENT</a></td>
        <td><a href="customerBackorders.cfm?custID=#ID#">BACKORDERS</a></td>
		<td>#Trim(firstName)# #Trim(lastName)#</td>
        <td>#billingName#</td>
		<td>#username#</td>
		<td>#email#</td>
	</tr>
</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">