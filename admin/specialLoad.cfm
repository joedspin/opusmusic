<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<p>Downtown 304 online admin tool</p>
<p>Orders</p>
<p>Special Load</p>
<cfform name="getSpecialtext" action="specialLoadAction.cfm" method="post">
	<cftextarea name="Specialtext" rows="10" cols="150"></cftextarea>
	<cfinput type="submit" name="load" value="Load">
</cfform>
<cfinclude template="pageFoot.cfm">