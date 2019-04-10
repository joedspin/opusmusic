<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer"> AND accountID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND store=1
</cfquery>
<style>
	body {background-color:#000000; font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: medium;}
	h1 {font-family:Gotham, "Helvetica Neue", Helvetica, Arial, sans-serif; font-size: large; color:CCCCCC; margin-top: 24px; margin-bottom: 18px;}
</style>
<cfoutput query="thisCard">
<cfset theMonth=Decrypt(ccExpMo,encryKey71xu)>
<cfset theYear=Decrypt(ccExpYr,encryKey71xu)>
<cfset theCard=Decrypt(ccNum,encryKey71xu)>
<cfset cardExpDate=NumberFormat(theYear+2000,"0000")&"-"&NumberFormat(theMonth,"00")>
<blockquote>
	<h1 style="margin-top: 12px;"><b>My Account</b><br>
    Stored Credit Cards: Delete</h1>
		<blockquote>
        <h1><font color="red">Are you sure you want to permanently delete this stored card?</font></h1>
		<blockquote>
			<p><b>#ccName# #PayName# ending in #Right(theCard,4)#</b> (expires #theMonth#/#theYear#)</p>
		</blockquote>
		<p><a href="profileCardsDeleteAction.cfm?ID=#ID#">DELETE&nbsp;&nbsp;</a> / <a href="profileCards.cfm">&nbsp;&nbsp;CANCEL</a></p>
        </blockquote>
		<p><a href="profileCards.cfm">Back to Stored Credit Cards</a><br />
		<a href="profile.cfm">Back to My Account</a></p>
	</blockquote>
</cfoutput>
<cfinclude template="pageFoot.cfm">