<cfparam name="url.shipID" default="0">
<cfparam name="url.billID" default="0">
<cfparam name="url.shipOptionID" default="0">
<cfparam name="url.promo" default="">
<cfparam name="url.addCard" default="false">
<cfparam name="url.thisPromo" default="">
<cfparam name="url.cshok" default="false">
<cfparam name="url.ID" default="0">
<cfif Session.userID NEQ 0><cfset thisUserID=Session.userID><cfelse><cfset thisUserID=Session.userID></cfif>
<cfquery name="myCardsDelete" datasource="#DSN#">
    delete
    from userCards
    where accountID=<cfqueryparam value="#thisUserID#" cfsqltype="cf_sql_integer"> AND store=1 AND ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<cflocation url="checkOutBill.cfm?ID=#url.ID#&ret=cob&shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">