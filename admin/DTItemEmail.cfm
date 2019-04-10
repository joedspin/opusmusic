<cfset pageName="CATALOG">
<cfinclude template="pageHead.cfm">
<cfparam name="url.ID" default="0">
<cfparam name="url.pageBack" default="catalogReview.cfm">
<cfparam name="Session.userEmail" default="">
<cfif Session.userEmail EQ "">
	<cflogout>
	<cfset userMessage="Your email address is not loaded, please login again. Sorry for the inconvenience.">
	<cfinclude template="loginform.cfm">
	<cfabort>
</cfif>
<cfquery name="catalogFind" datasource="#DSN#">
	select *
	from catItemsQuery
	where ID=#url.ID#
</cfquery>
<cfform name="getMessage" method="post" action="DTItemEmailAction.cfm">
	<cfoutput query="catalogFind">
		<p>Sending:</p>
		<p><b>#artist#</b><br />
		#title# (<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#)<br />
		[#label# - #catnum#]</p>
	<input type="hidden" name="ID" value="#url.ID#">
	<input type="hidden" name="pageBack" value="#url.pageBack#">
	</cfoutput>
	<p>Type a message to include at the top of the email:</p>
	<textarea rows="8" cols="80" name="custMessage" class="inputBox"></textarea>
	<input type="submit" name="submit" value=" Send " />
</cfform>
<cfinclude template="pageFoot.cfm">