<cfparam name="form.shipID" default="0">
<cfparam name="form.billID" default="0">
<cfparam name="form.CCV" default="">
<cfparam name="form.cardChoice" default="0">
<cfparam name="form.shipOptionID" default="0">
<cfparam name="form.saveCard" default="no">
<cfparam name="form.thisPromo" default="">
<cfparam name="form.expmo" default="12">
<cfparam name="form.expyr" default="99">

<cfquery name="thisOrder" datasource="#DSN#">
	select ID
	from orders
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND statusID=1
</cfquery>

<cfif form.cardChoice EQ 0 AND form.CCV EQ ""><cfinclude template="pageHead.cfm"><p>Please click "Back" and enter the CCV number for your card. On MasterCard or Visa it is 3 digits on the back of the card after the card number. On American Express it is 4 digits on the front of the card above the card number.</p><cfinclude template="pageFoot.cfm"><cfabort></cfif>

<cfset theMonth=form.expmo>
<cfset theYear=form.expyr>
<cfset cardExpDate=NumberFormat(theYear+2000,"0000")&"-"&NumberFormat(theMonth+1,"00")&"-00">
<cfif form.cardChoice EQ 0 AND cardExpDate LT DateFormat(varDateODBC,"yyyy-mm-dd")><cfinclude template="pageHead.cfm"><p>Please click "Back" and enter a new new expiration date for you card. The date you entered is already expired.</p><cfinclude template="pageFoot.cfm"><cfabort></cfif>

<cfif form.billID NEQ 0 AND form.shipID NEQ 0>
	<cfif form.cardChoice EQ 0>
		<cfquery name="checkCard" datasource="#DSN#">
			select *
			from userCardsQuery
			where accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> and ccNum=<cfqueryparam value="#Encrypt(form.CCNum,encryKey71xu)#" cfsqltype="cf_sql_char">
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
	<cfelse>
		<cfif form.cardChoice EQ "C">
			<cfset thisCardID=0>
			<cfset thisCardTypeID=5>
		<cfelseif form.cardChoice EQ "M">
			<cfset thisCardID=0>
			<cfset thisCardTypeID=6>
		<cfelseif form.cardChoice EQ "P">
			<cfset thisCardID=0>
			<cfset thisCardTypeID=7>
		<cfelse>
			<cfquery name="thisCard" datasource="#DSN#">
				select *
				from userCards
				where ID=<cfqueryparam value="#form.cardChoice#" cfsqltype="cf_sql_integer">
			</cfquery>
			<cfset thisCardID=#form.cardChoice#>
			<cfset thisCardTypeID=#thisCard.ccTypeID#>
		</cfif>
	</cfif>
	<cfquery name="updateOrder" datasource="#DSN#">
		update orders
		set
			billingAddressID=<cfqueryparam value="#form.billID#" cfsqltype="cf_sql_char">,
			paymentTypeID=<cfqueryparam value="#thisCardTypeID#" cfsqltype="cf_sql_char">,
			userCardID=<cfqueryparam value="#thisCardID#" cfsqltype="cf_sql_char">
		where ID=<cfqueryparam value="#thisOrder.ID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfif form.cardChoice EQ "P">
		<cflocation url="checkOutPayPal.cfm?orderID=#thisOrder.ID#&thisPromo=#URLEncodedFormat(form.thisPromo)#">
	<cfelse>
		<cflocation url="checkOutConfirm.cfm?orderID=#thisOrder.ID#&thisPromo=#URLEncodedFormat(form.thisPromo)#">
	</cfif>
<cfelse>
<p>Error...something is missing from your submission.  <a href="javascript: history.go(-1);">Click to try again.</a><br />
&nbsp;<br />
The most likely cause is that your login timed-out. <a href="http://www.downtown304.com/index.cfm?logout=true">Click here</a> to LOGOUT and try again. We apologize for the inconvenience.</p>
</cfif>
