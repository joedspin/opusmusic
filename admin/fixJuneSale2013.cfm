<!---<cfquery name="undomemDaySale2012" datasource="#DSN#">
	update catItems
	set price=cost+2.50, specialItem=0
	where specialItem=1 AND price=8.99
</cfquery>//--->
<cfquery name="memDaySale2012DT" datasource="#DSN#">
	select * from catItemsQuery
	
	where albumStatusID>21 AND albumStatusID<25 AND ONHAND>0 AND vendorID<>5650
    order by label, catnum
</cfquery>
<cfquery name="clearSpecial" datasource="#DSN#">
	update catItems
	set specialItem=0
</cfquery>
<cfset count12=1>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse:collapse;">
<!---<cfoutput query="memDaySale2012">
<tr>
	<td>#count12#</td>
	<td>#DollarFormat(cost)#</td>
	<td>#DollarFormat(price)#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
</tr>
<cfset count12=count12+1>
</cfoutput>//--->
<cfset count12=1>
<cfoutput query="memDaySale2012DT">
<tr>
	<td>#count12#</td>
	<td>#DollarFormat(cost)#</td>
	<td>#DollarFormat(price)#</td>
	<td>#catnum#</td>
	<td>#label#</td>
	<td>#artist#</td>
	<td>#title#</td>
	<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
</tr>
<cfset count12=count12+1>
</cfoutput>
</table>