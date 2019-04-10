<cfparam name="url.ID" default="0">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfloop query="thisOrder">
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#custID#
</cfquery>

<cfoutput>
<h1>Downtown 304 OPEN Order : <s>#NumberFormat(url.ID,"00000")#</s></h1>
<h2>#thisCust.firstName# #thisCust.lastName#</h2>
<p>Customer email: #thisCust.email#</p>
</cfoutput>
<cfquery name="thisItems" datasource="#DSN#">
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE
	FROM orderItemsQuery
	where Left(shelfCode,1)='D' AND orderID=#url.ID#
	group by catnum, label, artist, title, ONSIDE
	order by label, Sum(qtyOrdered) DESC
</cfquery>
<style>
body {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
td {font-size: xx-small; vertical-align: top;"}
</style>
<h1>Warehouse</h1>
<h3><cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput></h3>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse; border-color:#000000;" width="100%">
<cfset total=0>
<cfset toggle=0>
<cfoutput query="thisItems">
<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>
	<td width="10" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
	<td width="100">#Left(UCase(label),20)#</td>
	<td width="50">#Left(UCase(catnum),20)#</td>
	<td>#Left(UCase(artist),30)#</td>
	<td>#Left(UCase(title),30)#</td>
</tr>
</cfoutput>
</table>
<p>Warehouse Total: <cfoutput>#total#</cfoutput></p>
<cfquery name="opusItems" datasource="#DSN#">
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE, shelfCode
	FROM orderItemsQuery
	where Left(shelfCode,1)<>'D' AND orderID=#url.ID#
	group by catnum, label, artist, title, ONSIDE, shelfCode
	order by label, Sum(qtyOrdered) DESC
</cfquery>
<style>
body {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
td {font-size: xx-small; vertical-align: top;"}
</style>
<h1>On the Side</h1>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse; border-color:#000000;" width="100%">
<cfset total=0>
<cfset toggle=0>
<cfoutput query="opusItems">
<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>
	<td width="10" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
	<td width="100">#Left(UCase(label),20)# [#shelfCode#]</td>
	<td width="50">#Left(UCase(catnum),20)#</td>
	<td>#Left(UCase(artist),30)#</td>
	<td>#Left(UCase(title),30)#</td>
</tr>
</cfoutput>
</table>
<p>On the Side Total: <cfoutput>#total#</cfoutput></p>
</cfloop>