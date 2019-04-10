<cfset pageName="CATALOG">
<cfparam name="url.pageBack" default="catalog.cfm">
<cfinclude template="pageHead.cfm">
<cfquery name="thisItem" datasource="#DSN#">
	select *
	from catItems
	where ID=#url.ID#
</cfquery>
<cfquery name="thisArtist" datasource="#DSN#">
	select ID, name
	from artists
	where ID=#thisItem.artistID#
	order by name
</cfquery>
<cfquery name="thisLabel" datasource="#DSN#">
	select ID, name
	from labels
	where ID=#thisItem.labelID#
	order by sort
</cfquery>
<cfquery name="thisMedia" datasource="#DSN#">
	select ID, name
	from media
	where ID=#thisItem.mediaID#
	order by name
</cfquery>
<cfoutput query="thisItem">
	<p>ID##: #ID#<br />
	<b>#thisArtist.name#</b><br />
	#thisItem.title#<br />
	<small>#thisItem.catnum# #thisLabel.name# #thisMedia.name#</small></p>
</cfoutput>
<p><b><font color="red">Are you sure you want to convert this item to BS?</font></p>
<cfoutput><p><a href="catalogBSAction.cfm?ID=#url.ID#&artistID=#thisItem.artistID#&pageBack=#url.pageBack#">YES</a> | <a href="catalogEdit.cfm?ID=#url.ID#&pageBack=#url.pageBack#">NO</a></p></cfoutput>
<cfinclude template="pageFoot.cfm">