
<cfquery name="thisItems" datasource="#DSN#">
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE
	FROM orderItemsQuery
	where adminAvailID=2 AND statusID<6 AND statusID>1 AND Left(shelfCode,1)='D'
	group by catnum, label, artist, title, ONSIDE
	order by label, Sum(qtyOrdered) DESC
</cfquery>
<style>
body {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
td {font-size: xx-small; vertical-align: top;"}
</style>
<h1>Opus Picklist (from Downtown Inventory)</h1>
<h3><cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput></h3>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse; border-color:#000000;" width="100%">
<cfset total=0>
<cfset toggle=0>
<cfoutput query="thisItems">
<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>
	<td width="10" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
	<td width="50">#Left(UCase(catnum),20)#</td>
	<td width="100">#Left(UCase(label),20)#</td>
	<td>#Left(UCase(artist),30)#</td>
	<td>#Left(UCase(title),30)#</td>
</tr>
</cfoutput>
<!---
<cfquery name="thisItems" datasource="#DSN#" >
	SELECT opCATNUM As catnum, Sum(Quantity) As totalOrdered, opLABEL As label, opARTIST As artist, opTITLE As title
	FROM GEMMBatchProcessingQuery
	where Processed=0
	group by opCATNUM, opLABEL, opARTIST, opTITLE
	order by opLABEL, Sum(Quantity) DESC
</cfquery>
<cfoutput query="thisItems">
<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>
	<td width="10" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
	<td>#Left(UCase(catnum),20)#</td>
	<td>#UCase(label)#</td>
	<td>#Left(UCase(artist),30)#</td>
	<td>#Left(UCase(title),30)#</td>
</tr>
</cfoutput>//--->
</table>
<p>Picklist Total: <cfoutput>#total#</cfoutput></p>
<cfquery name="opusItems" datasource="#DSN#">
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE
	FROM orderItemsQuery
	where adminAvailID=2 AND statusID<6 AND statusID>1 AND Left(shelfCode,1)<>'D'
	group by catnum, label, artist, title, ONSIDE
	order by label, Sum(qtyOrdered) DESC
</cfquery>
<style>
body {font-family: Arial, Helvetica, sans-serif; font-size: x-small;}
td {font-size: xx-small; vertical-align: top;"}
</style>
<h1>Opus Picklist (from Opus Inventory)</h1>
<h3><cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput></h3>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse; border-color:#000000;" width="100%">
<cfset total=0>
<cfset toggle=0>
<cfoutput query="opusItems">
<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>
	<td width="10" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
	<td width="50">#Left(UCase(catnum),20)#</td>
	<td width="100">#Left(UCase(label),20)#</td>
	<td>#Left(UCase(artist),30)#</td>
	<td>#Left(UCase(title),30)#</td>
</tr>
</cfoutput>
<!---
<cfquery name="thisItems" datasource="#DSN#" >
	SELECT opCATNUM As catnum, Sum(Quantity) As totalOrdered, opLABEL As label, opARTIST As artist, opTITLE As title
	FROM GEMMBatchProcessingQuery
	where Processed=0
	group by opCATNUM, opLABEL, opARTIST, opTITLE
	order by opLABEL, Sum(Quantity) DESC
</cfquery>
<cfoutput query="thisItems">
<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>
	<td width="10" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
	<td>#Left(UCase(catnum),20)#</td>
	<td>#UCase(label)#</td>
	<td>#Left(UCase(artist),30)#</td>
	<td>#Left(UCase(title),30)#</td>
</tr>
</cfoutput>//--->
</table>
<p>Picklist Total: <cfoutput>#total#</cfoutput></p>
<!---<cfset itemList="">
<cfloop query="thisItems">
	<cfif itemList EQ "">
		<cfset itemList=ID>
	<cfelse>
		<cfset itemList=itemList&","&ID>
	</cfif>
</cfloop>
<cfloop query="opusItems">
	<cfif itemList EQ "">
		<cfset itemList=ID>
	<cfelse>
		<cfset itemList=itemList&","&ID>
	</cfif>
</cfloop>
<form name="picklistAvail" method="post" action="ordersPicklistAction.cfm">
<cfoutput>	<input type="hidden" name="availList" value="#itemList#" /><input type="submit" name="submit" value="Mark All as Available" /></cfoutput>
</form>//--->