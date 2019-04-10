<cfparam name="url.ID" default="0">
<cfif url.ID NEQ 0>
	<cfquery name="deleteCard" datasource="#DSN#">
		update userCards
        set store=0
		where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer"> AND accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
	</cfquery>
</cfif>
<cflocation url="profileCards.cfm">