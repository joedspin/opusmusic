<cfquery name="topCust" datasource="#DSN#">
	select Sum(OrderTotal) as totalOrdered, firstName, LastName, username
	from (orders LEFT JOIN custAccounts ON orders.custID=custAccounts.ID)
	where statusID=6 AND orderTotal<>0
    GROUP BY username, firstName, LastName
    order by Sum(OrderTotal) DESC
</cfquery>
<cfset total=0>
<cfoutput query="topCust">
#DollarFormat(totalOrdered)# [#username#] #firstName# #lastName#<br>
<cfset total=total+totalOrdered>
</cfoutput>
---------------------------------------------<br>
<cfoutput>#DollarFormat(total)#</cfoutput>