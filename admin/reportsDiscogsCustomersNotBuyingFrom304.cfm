<cfquery name="discogsNotBuyingGood" datasource="#DSN#">
	select email, firstname, lastname, orderCount, itemCount, username
    from ((custAccounts LEFT JOIN ordersCountByCust ON custAccounts.ID=ordersCountByCust.custID) LEFT JOIN ordersItemCountByCust ON custAccounts.ID=ordersItemCountByCust.custID) where ID NOT IN (select custID from orders where otherSiteID=0 AND statusID=6) AND ID IN (select custID from orders where otherSiteID=2) AND (orderCount>1 OR itemCount>orderCount) order by itemCount DESC
</cfquery>
<cfquery name="discogsNotBuyingNotAsGood" datasource="#DSN#">
	select email, firstname, lastname, orderCount, itemCount, username
    from ((custAccounts LEFT JOIN ordersCountByCust ON custAccounts.ID=ordersCountByCust.custID) LEFT JOIN ordersItemCountByCust ON custAccounts.ID=ordersItemCountByCust.custID) where ID NOT IN (select custID from orders where otherSiteID=0 AND statusID=6) AND ID IN (select custID from orders where otherSiteID=2) AND orderCount=1 AND itemCount=orderCount order by itemCount DESC
</cfquery>
<h1>Discogs Customers who have not bought from Downtown 304</h1>
<h2>Bought More than Once or Bought More Than One Record Per Order</h2>
<table border=1><cfset emailcount=0>
<cfoutput query="discogsNotBuyingGood">
<cfset emailcount=emailcount+1>
<tr><td>#emailcount#</td><td>#firstname# #lastname#</td><td>#username#</td><td>#email#</td><td>#orderCount# orders</tr><td>#itemCount# items</td></tr>
</cfoutput>
</table>
-----------------------------------------<br>
<h2>Only Bought Once / Only Bought One Record</h2>
<table border=1>
<cfset emailcount=0>
<cfoutput query="discogsNotBuyingNotAsGood">
<cfset emailcount=emailcount+1>
<tr><td>#emailcount#</td><td>#firstname# #lastname#</td><td>#username#</td><td>#email#</td><td>#orderCount# orders</tr><td>#itemCount# items</td></tr>
</cfoutput>
</table>