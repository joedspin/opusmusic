<cfset pageName="CATALOG">
<cfinclude template="pageHead.cfm">
<p>Downtown 304 online admin tool</p>
<p>Catalog</p>
<p>DT Out Of Stock Import</p>
<cfform name="getGEMMtext" action="catalogDTOOSAction.cfm" method="post">
	<cftextarea name="DTOOStext" rows="10" cols="60"></cftextarea>
	<cfinput type="submit" name="load" value="Load Out Of Stock">
</cfform>
<cfinclude template="pageFoot.cfm">