<cfset pageName="ORDERS">
<cfinclude template="pageHead.cfm">
<p>Downtown 304 online admin tool</p>
<p>Orders</p>
<p>GEMM Import</p>
<cfform name="getGEMMtext" action="ordersGEMMLoadAction.cfm" method="post">
	<cftextarea name="GEMMtext" rows="10" cols="150"></cftextarea>
	<cfinput type="submit" name="load" value="Load Orders">
</cfform>
<cfinclude template="pageFoot.cfm">