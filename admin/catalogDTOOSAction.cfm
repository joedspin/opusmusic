<cfset pageName="CATALOG">
<cfinclude template="pageHead.cfm">
<p>Downtown 304 online admin tool</p>
<p>Catalog</p>
<p>DT Out Of Stock Import</p>
<cfparam name="form.DTOOStext" default="">
<cfif form.DTOOStext EQ "">
	ERROR<cfabort>
<cfelse>
<cfquery name="getOOSItems" datasource="#DSN#">
	select *
	from catItemsQuery
	where [catItems.catnum] IN (#ListQualify(form.DTOOStext,"'")#) AND LEFT(shelfCode,'1')='D'
</cfquery>
<cfif getOOSItems.RecordCount GT 0>
<form name="chooseOOSList" action="catalogDTOOSActionFinalize.cfm" method="post">
<table bgcolor="white" border="1" bordercolor="#000000" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
	
	<cfoutput query="getOOSItems">
	<cfif ONHAND EQ 0><cfset oos='OOS'><cfelse><cfset oos=''></cfif>
	<tr>
		<td class="catDisplay"><input type="checkbox" name="OOSList" value="#ID#" checked /></td>
		<td class="catDisplay#oos#">#label#</td>
		<td class="catDisplay#oos#">#catnum#</td>
		<td class="catDisplay#oos#">#artist#</td>
		<td class="catDisplay#oos#">#title#</td>
		<td class="catDisplay#oos#" align="center">#shelfCode#</td>
		<td class="catDisplay#oos#" align="center">#ONHAND#</td>
		<td class="catDisplay#oos#" align="center">#media#</td>
	</tr>
	</cfoutput>
</table>
<p><input type="submit" value=" Finalize Out of Stock" name="submitFinalize" /></p>
</form>
<cfelse>
	<p>No Items found.</p>
</cfif>
</cfif>
<cfinclude template="pageFoot.cfm">