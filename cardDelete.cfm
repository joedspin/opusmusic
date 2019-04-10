<cfinclude template="checkOutPageHead.cfm">
<cfparam name="url.shipID" default="0">
<cfparam name="url.billID" default="0">
<cfparam name="url.shipOptionID" default="0">
<cfparam name="url.promo" default="">
<cfparam name="url.addCard" default="false">
<cfparam name="url.thisPromo" default="">
<cfparam name="url.cshok" default="false">
<cfparam name="url.ID" default="0">
<cfif Session.userID NEQ 0><cfset thisUserID=Session.userID><cfelse><cfset thisUserID=Session.userID></cfif>
<cfquery name="myCards" datasource="#DSN#">
    select *
    from userCardsQuery
    where accountID=<cfqueryparam value="#thisUserID#" cfsqltype="cf_sql_integer"> AND store=1 AND ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<h1>Delete Card</h1>
<cfoutput query="myCards">
 <cfset theCard=Decrypt(ccNum,encryKey71xu)>
<p>Are you sure you want to delete the  #PayName# ending in #Right(theCard,"4")#?</p>
<p><a href="cardDeleteAction.cfm?ID=#url.ID#&ret=cob&shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">YES</a> | <a href="checkOutBill.cfm?ID=#url.ID#&ret=cob&shipID=#url.shipID#&shipOptionID=#url.shipOptionID#">NO</a></p>
</cfoutput>
<cfinclude template="checkOutPageFoot.cfm">