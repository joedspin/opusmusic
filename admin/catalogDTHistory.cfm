<cfset pageName="CATALOG">
<cfinclude template="pageHead.cfm">
<cfquery name="loadHistory" datasource="#DSN#" maxrows="50">
	select *
	from DTLoadHistory
	order by dateLoaded DESC
</cfquery>
<h1>Catalog</h1>
		<p>
		<a href="catalog.cfm">Browse Catalog</a><br />
		<a href="catalogAdd.cfm">ADD ITEM</a><br />
		<a href="listsLabelsAdd.cfm">ADD LABEL</a><br />
		Downtown Import History</p>
<table border="1" cellspacing="0" cellpadding="2" style="border-collapse:collapse;">
<cfoutput query="loadHistory">
	<tr>
		<td>#DateFormat(dateLoaded,"yyyy-mm-dd")#</td>
		<td>#numRows# Items</td>
		<td>#loadType#</td>
		<td>#comment#</td>
	</tr>
</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">