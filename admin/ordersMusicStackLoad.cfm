<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<p>Downtown 304 online admin tool</p>
<p>Orders</p>
<p>MusicStack Import</p>
<cfform name="getMStext" action="ordersMusicStackLoadAction.cfm" method="post">
	<cftextarea name="MStext" rows="10" cols="150"></cftextarea>
	<cfinput type="submit" name="load" value="Load Orders">
</cfform>
<cfinclude template="pageFoot.cfm">