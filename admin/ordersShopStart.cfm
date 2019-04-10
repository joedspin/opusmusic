<cfparam name="form.username" default="">
<cfparam name="url.username" default="">
<cfparam name="form.submit" default="">
<cfif url.username NEQ "">
	<cfset lookupuser=url.username>
<cfelse>
	<cfset lookupuser=form.username>
</cfif>
<cfif lookupuser EQ "" AND form.submit EQ "Vinylmania">
	<cfset lookupuser="vinylmania">
</cfif>
<cfquery name="lookupUser" datasource="#DSN#">
    select ID
    from custAccounts
    where username=<cfqueryparam value="#Trim(lookupuser)#" cfsqltype="cf_sql_char">
</cfquery><style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: x-large;
	color: #CCFF00;
}
body {
	background-color:#333;
}
.style1 {color: #FFFF00}
.style2 {color: #66FF00}
-->
</style>
<cfif lookupUser.recordCount NEQ 0>
		<cfset thisCustID=lookupUser.ID>
        <cfif form.submit EQ "Vinylmania"><cfset isVM=1><cfelse><cfset isVM=0></cfif>
        <cfif thisCustID EQ 2126><cfset paidStat=4><cfelse><cfset paidStat=2></cfif>
        <cfquery name="addCustOrder" datasource="#DSN#">
            insert into orders (custID, dateStarted, dateUpdated, datePurchased, statusID, shipID,isVinylmania,picklistPrinted,readyToPrint,paymentTypeID,userCardID)
            values (#thisCustID#,#varDateODBC#,#varDateODBC#,#varDateODBC#,#paidStat#,64,#isVM#,0,0,5,0)
        </cfquery>
        <cfquery name="getNewOrderID" datasource="#DSN#">
            select Max(ID) As MaxID
            from orders
            where custID=#thisCustID# AND statusID=2 OR statusID=4
        </cfquery>
        <cfset thisOrderID=getNewOrderID.MaxID>
        <cflocation url="ordersEdit.cfm?ID=#thisOrderID#">
<cfelse>
	<cflocation url="orders.cfm?shopUser=#form.username#&userNotFound=true">
</cfif>
