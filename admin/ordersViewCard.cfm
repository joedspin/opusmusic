<font color="red">Unauthorized Access</font><cfmail to="order@downtown304.com" from="info@downtown304.com" subject="ATTEMPTED ACCESS to ordersViewCard.cfm">#CGI.REMOTE_HOST#</cfmail><cfabort>
<cfparam name="url.ID" default="0">
<cfparam name="url.pageBack" default="orders.cfm">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfloop query="thisOrder">
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#userCardID#
</cfquery>
<cfset procDetails="#thisCard.PayAbbrev# ending in #Right(thisCard.ccNum,4)#">
<cfset paymType=thisCard.ccTypeID>
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#custID#
</cfquery>


<cfoutput>
<h1>Downtown 304 Order : #NumberFormat(url.ID,"00000")#</h1>
<h2>#thisCust.firstName# #thisCust.lastName#</h2>
<h3><cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput></h3>
<p>Customer email: #thisCust.email#</p>
</cfoutput>
<style>
body {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
td {font-size: small; font-family: Arial, Helvetica, sans-serif; vertical-align: top;"}
</style>
<cfoutput query="thisCard">
<table border="0" cellpadding="10" cellspacing="0" width="100%">
	<tr>
		<td valign="top">

</td></tr></table>
	</cfoutput>
	</cfloop>