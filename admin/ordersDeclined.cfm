<cfparam name="url.ID" default="0">
<cfparam name="url.avs" default="false">
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
<cfset procDetails="#thisCard.PayAbbrev# ending in #Right(Decrypt(thisCard.ccNum,encryKey71xu),4)#">
<cfset paymType=thisCard.ccTypeID>
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#custID#
</cfquery>
</cfloop>
<cfmail to="#thisCust.email#" from="order@downtown304.com" bcc="order@downtown304.com" subject="Downtown 304 Order #NumberFormat(url.ID,"00000")# - Problem with Payment" type="html"><html><head>
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
td {padding: 0px;}
//-->
</style></head>
<body>
<p>#thisCust.firstName#,</p>
<p>We attempted to charge your #procDetails#, but the payment was declined.</p>
<cfif url.avs><p>The bank said the billing address provided does not match the billing address of the card used.</p>
<p>Please email us with an updated billing address and we'll try again.</p>
<cfelse>
<p>Please let us know how you wish to proceed. You may need to check with your bank to ensure enough funds are available.</p></cfif>
<p>Best regards,</p>
<p>Downtown 304<br />
<a href="http://www.downtown304.com">www.Downtown304.com</a></p>
	</body>
	</html>
</cfmail>
<cfoutput><h1>Order ###url.ID#</h1>
<p>#thisCust.firstName# #thisCust.lastName#<br>
#thisCust.email#</p>
<p>Decline notification sent.</p>
<p><a href="orders.cfm">Continue</a></p>
</cfoutput>