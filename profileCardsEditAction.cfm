<cfinclude template="pageHead.cfm">
<style>
	body {background-color:#000000; font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: medium;}
	h1 {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: large; color:CCCCCC; margin-top: 24px; margin-bottom: 18px;}
	td {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: small; text-wrap:none;}
	input, select {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: medium;}
</style>
<cfparam name="form.cardID" default="0">
<cfparam name="form.CCV" default="">
<cfparam name="form.saveCard" default="yes">
<cfparam name="form.expmo" default="12">
<cfparam name="form.expyr" default="99">
<cfparam name="form.ccNum" default="">
<cfparam name="form.oldNum" default="">
<cfif isValid("creditcard",form.ccNum)>
    <cfquery name="editCard" datasource="#DSN#">
        update userCards 
        set 
            	ccTypeID=<cfqueryparam value="#form.CCType#" cfsqltype="cf_sql_char">,
            	ccFirstName=<cfqueryparam value="#form.CCFirstName#" cfsqltype="cf_sql_char">,
            	ccName=<cfqueryparam value="#form.CCName#" cfsqltype="cf_sql_char">,
            	ccNum=<cfqueryparam value="#Encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">,
            	ccExpMo=<cfqueryparam value="#Encrypt(form.expmo,encryKey71xu)#" cfsqltype="cf_sql_char">,
            	ccExpYr=<cfqueryparam value="#Encrypt(form.expyr,encryKey71xu)#" cfsqltype="cf_sql_char">,
            	ccCCV=<cfqueryparam value="#Encrypt(form.CCV,encryKey71xu)#" cfsqltype="cf_sql_char">,
            	store=1
        where 	ID=<cfqueryparam value="#form.cardID#" cfsqltype="integer"> AND
        		accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
    </cfquery>
<cfelseif form.ccNum EQ form.oldNum>
	<cfquery name="editCard" datasource="#DSN#">
        update userCards 
        set 
            	ccTypeID=<cfqueryparam value="#form.CCType#" cfsqltype="cf_sql_char">,
            	ccFirstName=<cfqueryparam value="#form.CCFirstName#" cfsqltype="cf_sql_char">,
            	ccName=<cfqueryparam value="#form.CCName#" cfsqltype="cf_sql_char">,
            	ccExpMo=<cfqueryparam value="#Encrypt(form.expmo,encryKey71xu)#" cfsqltype="cf_sql_char">,
            	ccExpYr=<cfqueryparam value="#Encrypt(form.expyr,encryKey71xu)#" cfsqltype="cf_sql_char">,
            	ccCCV=<cfqueryparam value="#Encrypt(form.CCV,encryKey71xu)#" cfsqltype="cf_sql_char">,
            	store=1
        where 	ID=<cfqueryparam value="#form.cardID#" cfsqltype="integer"> AND
        		accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
    </cfquery>
<cfelse>
	<h1><font color="red">ERROR</font><br>
    The Card Number you entered is not valid. <cfoutput><a href="profileCardsEdit.cfm?ID=#form.cardID#">Click here to try again.</a></cfoutput></h1>  
    <p><a href="profileCards.cfm">Back to Stored Credit Cards</a><br />
	<p><a href="profile.cfm">Back to My Account</a></p><cfabort>
</cfif>
<cfinclude template="pageFoot.cfm">
<cflocation url="profileCards.cfm">
