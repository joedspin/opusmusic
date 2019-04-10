<cfparam name="form.friendsName" default="">
<cfparam name="form.friendsEmail" default="">
<cfparam name="form.shortMessage" default="">
<cfparam name="Session.userID" default="0">
<cfparam name="form.sid" default="0">
<!---<cfoutput>#form.friendsName# #form.friendsEmail# #form.shortMessage# #Session.userID# #form.sid#</cfoutput><cfabort>//--->
<cfif Session.userID NEQ 0 AND IsNumeric(Session.userID) AND form.sid NEQ 0>
<cfquery name="thisUser" datasource="#DSN#">
	select firstName, lastName
	from custAccounts
	where ID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
</cfquery>
<cfquery name="catFind" dbtype="query">
    select *
    from Application.dt304Items
    where ID=<cfqueryparam value="#form.sID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfmail query="catFind" to="#Replace(form.friendsEmail," ","","all")#" from="info@downtown304.com" subject="#thisUser.firstName# #thisUser.lastName# recommends this on Downtown 304" type="html">
<style>
	body, p, h4 {font-family: Arial, Helvetica, sans-serif;}
	.style3 {font-size: x-small}
</style>
<p>#form.friendsName#,</p>
<p>#form.shortMessage#</p>
<h4 align="center"><a href="http://www.downtown304.com/index.cfm?sid=#ID#"><b>#artist#</b><br>
#title#<br>
<font size="2"><span class="style3">[#label# - #catnum#]</span></font></a></h4>
<p align="right"><a href="http://www.downtown304.com">Downtown 304</a><br>
  <span class="style3">The best underground House Music Records in the World</span></p>
</cfmail>
<cflocation url="opussitelayout07main.cfm?sid=#form.sid#&emf=done">
<cfelse>
You must be logged in to use this feature. <a href="http://www.downtown304.com/index.cfm?logout=true" target="_top">Click here</a> to reset your session and log in
</cfif>