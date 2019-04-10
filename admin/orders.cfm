<cfset pageName="ORDERS">
<cfset pageSub="MAIN">
<cfparam name="url.findID" default="">
<cfparam name="url.findDiscogsID" default="">
<cfparam name="url.findLastName" default="">
<cfparam name="url.findEmail" default="">
<cfparam name="url.findUsername" default="">
<cfparam name="url.notFound" default="false">
<cfparam name="url.closed" default="">
<cfparam name="url.editedID" default="0">
<cfparam name="url.editedPaid" default="no">
<cfparam name="url.flagToPrint" default="">
<cfparam name="url.shopUser" default="">
<cfparam name="url.userNotFound" default="false">
<cfif url.flagToPrint NEQ "">
	<cfquery name="flagToPrint" datasource="#DSN#">
    	update orders
        set picklistPrinted=0, readyToPrint=1
        where ID=#url.flagToPrint#
    </cfquery>
</cfif>
<cfquery name="ordersWaiting" datasource="#DSN#">
	select *, statusName, firstName, lastName, orders.custID As customerID, badCustomer, shipID, otherSites.name AS otherSiteName, PayType
	from ((((orders LEFT JOIN orderStatus ON orderStatus.ID=orders.statusID) LEFT JOIN custAccounts ON custAccounts.ID=orders.custID) LEFT JOIN otherSites ON otherSites.otherSiteID=orders.otherSiteID) LEFT JOIN paymentTypes ON orders.paymentTypeID=paymentTypes.PaymtID)
	where statusID<6 AND statusID>1
	order by isStore DESC, pickupReady, orders.otherSiteID, orders.otherSiteOrderNum DESC, orders.ID DESC
</cfquery>
<cfif url.closed EQ "recent">
	<cfquery name="ordersWaiting" datasource="#DSN#">
					select *, statusName, firstName, lastName, orders.custID As customerID, badCustomer, shipID, otherSites.name AS otherSiteName, PayType
					from ((((orders LEFT JOIN orderStatus ON orderStatus.ID=orders.statusID) LEFT JOIN custAccounts ON custAccounts.ID=orders.custID) LEFT JOIN otherSites ON otherSites.otherSiteID=orders.otherSiteID) LEFT JOIN paymentTypes ON orders.paymentTypeID=paymentTypes.PaymtID)
					where statusID>4 AND statusID>1 AND DateDiff(day,[dateShipped],getDate())<15
					order by orders.ID DESC
			</cfquery>
</cfif>
<cfset printableOrdersList="">
<!--- AND otherSiteID<>2 //--->
<cfquery name="printableOrders" dbtype="query">
	select ID as orderID from ordersWaiting where picklistPrinted=0 AND readyToPrint=1 AND (statusID=2 OR statusID=3) AND custID <>2126 order by datePurchased
</cfquery>
<cfif printableOrders.recordCount GT 0>
	<cfloop query="printableOrders">
		<cfif printableOrdersList NEQ "">
			<cfset printableOrdersList=printableOrdersList&",">
		</cfif><cfset printableOrdersList=printableOrdersList&orderID>
    </cfloop>
</cfif>
<cfinclude template="pageHead.cfm">
<cfquery name="maxDiscogs" datasource="#DSN#">
	select Max(otherSiteOrderNum) AS maxID, ID from orders where otherSiteID=2 AND IsNumeric(OtherSiteOrderNum)=1 group by ID, otherSiteOrderNum order by Cast(otherSiteOrderNum As Int) DESC
</cfquery>
<style>
<!--//
input {font-size: small; }
td {font-size: small; }
body {font-size: small; }
//--->
</style>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
<tr><td>
<cfform name="findOrder" action="ordersFind.cfm" method="post">
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<tr>
			<td colspan="5"><h2 style="margin-bottom: 0px;">Find Order <cfif url.notFound><font color="red">Not Found</font></cfif></h2></td>
		</tr>
		<tr>
			<td>Order Num:</td>
            <td>Discogs:</td>
			<td>Last Name:</td>
			<td>Email:</td>
            <td>Username:</td>
			<td rowspan="2" valign="bottom"><cfinput type="submit" name="submit" value=" Find "></td>
		</tr>
		<tr>
			<td><cfinput type="text" name="ID" size="6" maxlength="6" value="#url.findID#"></td>
            <td><cfinput type="text" name="discogsID" size="6" maxlength="6" value="#url.findDiscogsID#"></td>
			<td><cfinput type="text" name="lastName" size="18" maxlength="50" value="#url.findLastName#"></td>
			<td><cfinput type="text" name="email" size="18" maxlength="50" value="#url.findEmail#"></td>
            <td><cfinput type="text" name="username" size="18" maxlength="50" value="#url.findUsername#"></td>
	</table>
</cfform>
</td><td width="15">&nbsp;</td><td>
<cfform name="shopOrder" action="ordersShopStart.cfm" method="post">
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" align="center">
		<tr>
			<td colspan="4"><h2 style="margin-bottom: 0px;">New Order <cfif url.userNotFound><font color="red">User Not Found</font></cfif></h2></td>
		</tr>
		<tr>
			<td>Username:</td>
			<td rowspan="2" valign="bottom"><cfinput type="submit" name="submit" value=" Shop "><!---<cfinput type="submit" name="submit" value="Vinylmania">//---></td>
		</tr>
		<tr>
			<td><cfinput type="text" name="username" size="20" value="#url.shopUser#"></td>
	</table>
</cfform></td></td><td width="15">&nbsp;</td>
<td><p><a href="ordersNewThirdParty.cfm"><span style="font-size:18pt;"><b>New</b></span></a></p><p>Discogs Max <cfoutput><font style="font-size: 14pt;">#maxDiscogs.maxID#</font></cfoutput></td><td align="right" width="150" valign="top"><cfoutput><p style="font-weight: bold; font-size: 36px; color: green;">#ordersWaiting.recordCount#</p></cfoutput></td></tr></table>
<table border="1" cellpadding="4" cellspacing="0" style="margin-top: 10px;">
		<cfset setGreenline=false>
        <cfset setGoldLine=false>
		<cfset lastOtherSiteID=0>
        
        
        <cfquery name="ordersWaiting" datasource="#DSN#">
	select *, statusName, firstName, lastName, orders.custID As customerID, badCustomer, shipID, otherSites.name AS otherSiteName, PayType
	from ((((orders LEFT JOIN orderStatus ON orderStatus.ID=orders.statusID) LEFT JOIN custAccounts ON custAccounts.ID=orders.custID) LEFT JOIN otherSites ON otherSites.otherSiteID=orders.otherSiteID) LEFT JOIN paymentTypes ON orders.paymentTypeID=paymentTypes.PaymtID)
	where statusID<6 AND statusID>1 AND isStore=1
	order by billingName, orders.ID DESC
</cfquery>
		<cfinclude template="ordersOutput.cfm">
        <cfquery name="ordersWaiting" datasource="#DSN#">
	select *, statusName, firstName, lastName, orders.custID As customerID, badCustomer, shipID, otherSites.name AS otherSiteName, PayType
	from ((((orders LEFT JOIN orderStatus ON orderStatus.ID=orders.statusID) LEFT JOIN custAccounts ON custAccounts.ID=orders.custID) LEFT JOIN otherSites ON otherSites.otherSiteID=orders.otherSiteID) LEFT JOIN paymentTypes ON orders.paymentTypeID=paymentTypes.PaymtID)
	where statusID<6 AND statusID>1 AND isStore<>1
	order by pickupReady, orders.otherSiteID, orders.otherSiteOrderNum DESC, orders.ID DESC
</cfquery>
		<cfinclude template="ordersOutput.cfm">
        
</table>
<cfinclude template="pageFoot.cfm">