<cfparam name="url.ID" default="0">
<cfparam name="url.sTitle" default="">
<cfparam name="url.sArtist" default="">
<cfparam name="url.sLabel" default="">
<cfparam name="url.sCatnum" default="">
<cfparam name="url.review" default="false">
<cfparam name="url.stat" default="21">
<cfparam name="url.pageBack" default="catalog.cfm">
<cfif url.ID NEQ 0>
<cfquery name="markbackinstock" datasource="#DSN#">
	update catItems
	set ONHAND=1, active=1
	where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_char">
</cfquery>
</cfif>
<cfif url.review>
	<cflocation url="catalogReview.cfm?stat=#url.stat#">
<cfelse>
	<cflocation url="#pageBack#?sArtist=#url.sArtist#&sTitle=#url.sTitle#&sLabel=#url.sLabel#&sCatnum=#url.sCatnum#">
</cfif>