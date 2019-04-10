<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
<cfquery name="labelIMPORT" datasource="#DSN#">
	select catnum, label, artist, title, NRECSINSET, media
	from catItemsQuery 
	where label LIKE '%IMPORT%' 
	order by label
</cfquery>
<table>
<cfoutput query="labelIMPORT">
	<tr>
		<td>#catnum#</td>
		<td>#label#</td>
		<td>#artist#</td>
		<td>#title#</td>
		<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	</tr>
</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">