<cfset pageName="CATALOG">
<cfparam name="url.pageBack" default="catalog.cfm">
<cfinclude template="pageHead.cfm">
<cfquery name="thisItem" datasource="#DSN#">
	select *
	from catItemsQuery
	where ID=#url.ID#
</cfquery>
<cfoutput query="thisItem">
	<p style="font-size: 14px;">ID##: #ID#<br />
	<b>#artist#</b><br />
	#title#<br />
	<small>#catnum# #label# #media#</small><br /><br />
	Will be deleted</p>
</cfoutput>
<cfquery name="mergeItem" datasource="#DSN#">
	select *
	from catItemsQuery
	where catnum='#thisItem.catnum#' AND ID<>#url.ID#
</cfquery>
<cfif mergeItem.recordCount EQ 1>
	<p style="font-size:16px; color:#FFCC33; margin-left: 30px;"><b>MERGE THE ABOVE ITEM WITH THE BELOW ONE?</b><br />
THIS ACTION CANNOT BE UNDONE!</p>
<cfoutput><p style="font-size:16px; color:##FFCC33; margin-left: 30px;"><a href="catalogMergeAction.cfm?ID=#url.ID#&mergeID=#mergeItem.ID#">YES</a> | <a href="catalog.cfm">NO</a></p></cfoutput>
<cfoutput query="mergeItem">
	<p style="font-size: 14px;">ID##: #ID#<br />
	<b>#artist#</b><br />
	#title#<br />
	<small>#catnum# #label# #media#</small><br />
    Will be kept.</p>
</cfoutput>
<cfelseif mergeItem.recordCount EQ 0>
	<p>No matching items found. No merge possible.</p>
	<p><a href="catalog.cfm">Click to continue.</a>
<cfelse>
	<p>More than one item was found with the same catalog number. This item can not be merged.</p>
	<p><a href="catalog.cfm">Click to continue.</a></p>
</cfif>
<cfinclude template="pageFoot.cfm">