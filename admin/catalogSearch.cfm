<cfset pageName="CATALOG">
<cfinclude template="pageHead.cfm">
<cfquery name="catalogFind" datasource="#DSN#">
	select *
	from catItemsQuery
	where artist LIKE <cfqueryparam value="%#form.sArtist#%" cfsqltype="cf_sql_char"> AND
		label LIKE <cfqueryparam value="%#form.sLabel#%" cfsqltype="cf_sql_char"> AND
		title LIKE <cfqueryparam value="%#form.sTitle#%" cfsqltype="cf_sql_char"> AND
		catnum LIKE <cfqueryparam value="%#form.sCatnum#%" cfsqltype="cf_sql_char">
</cfquery>
<cfoutput query="catalogFind">
#ID# | #artist# | #title# | #catnum# | #label#<br>
</cfoutput>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
<cfinclude template="pageFoot.cfm">