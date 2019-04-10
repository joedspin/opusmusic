<cfparam name="form.CCV" default="">
<cfparam name="form.saveCard" default="yes">
<cfparam name="form.expmo" default="12">
<cfparam name="form.expyr" default="99">

<cfif form.CCV EQ ""><cfinclude template="checkOutPageHead.cfm"><p>Please click "Back" and enter the CCV number for your card. On MasterCard or Visa it is 3 digits on the back of the card after the card number. On American Express it is 4 digits on the front of the card above the card number.</p><cfinclude template="checkOutPageFoot.cfm"><cfabort></cfif>

<cfset theMonth=form.expmo>
<cfset theYear=form.expyr>
<cfset cardExpDate=NumberFormat(theYear+2000,"0000")&"-"&NumberFormat(theMonth+1,"00")>
<cfif cardExpDate LT DateFormat(varDateODBC,"yyyy-mm")><cfinclude template="pageHead.cfm"><p>Please click "Back" and enter a new new expiration date for your card. The date you entered is already expired.</p><cfinclude template="checkOutPageFoot.cfm"><cfabort></cfif>

<cfquery name="checkCard" datasource="#DSN#">
    select *
    from userCardsQuery
    where	accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND
    		ccNum=<cfqueryparam value="#Encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">
</cfquery>

<cfif checkCard.RecordCount EQ 0>
    <cfquery name="addCard" datasource="#DSN#">
        insert into	userCards (accountID, ccTypeID, ccFirstName, ccName, ccNum, ccExpMo, ccExpYr, ccCCV, store)
        values (
            <cfqueryparam value="#Session.userID#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#form.CCType#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#form.CCFirstName#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#form.CCName#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#Encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#Encrypt(form.expmo,encryKey71xu)#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#Encrypt(form.expyr,encryKey71xu)#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#Encrypt(form.CCV,encryKey71xu)#" cfsqltype="cf_sql_char">,
            <cfqueryparam value="#form.saveCard#" cfsqltype="cf_sql_bit">
        )
    </cfquery>
    <cfquery name="newCard" datasource="#DSN#">
        select Max(ID) as maxID
        from userCards
        where accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> and ccNum=<cfqueryparam value="#Encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">
    </cfquery>
    <cfset thisCardID=newCard.maxID>
    <cfset thisCardTypeID=form.CCType>
<cfelse>
    <cfquery name="editCard" datasource="#DSN#">
        update userCards 
        set 
            ccTypeID=<cfqueryparam value="#form.CCType#" cfsqltype="cf_sql_char">,
            ccFirstName=<cfqueryparam value="#form.CCFirstName#" cfsqltype="cf_sql_char">,
            ccName=<cfqueryparam value="#form.CCName#" cfsqltype="cf_sql_char">,
            ccExpMo=<cfqueryparam value="#Encrypt(form.expmo,encryKey71xu)#" cfsqltype="cf_sql_char">,
            ccExpYr=<cfqueryparam value="#Encrypt(form.expyr,encryKey71xu)#" cfsqltype="cf_sql_char">,
            ccCCV=<cfqueryparam value="#Encrypt(form.CCV,encryKey71xu)#" cfsqltype="cf_sql_char">,
            store=<cfqueryparam value="#form.saveCard#" cfsqltype="cf_sql_bit">
        where ID=#checkCard.ID#
    </cfquery>
    <cfset thisCardID=checkCard.ID>
    <cfset thisCardTypeID=form.CCType>
</cfif>
<cflocation url="profileCards.cfm">
