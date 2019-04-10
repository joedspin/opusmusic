<cfparam name="url.IDlist" default="">
<cfparam name="url.ID" default="">
<cfset orderInfo="">
<cfif url.ID NEQ "">
	<cfset orderInfo="orders.ID="&url.ID>
<cfelse>
	<!---<cfset orderInfo="issueRaised=0 AND (statusID=2 OR statusID=3)"> REMOVED THIS TO CHANGE THE CRITERIA FROM "NOT YET PICKED" TO JUST "NOT YET PRINTED" (Below)//--->
    <cfset orderInfo="ID IN (#url.IDlist#)">
</cfif>
<cfquery name="markPrinted" datasource="#DSN#">
	update orders
	set picklistPrinted=1
	where #orderInfo#
</cfquery>
<cflocation url="orders.cfm">