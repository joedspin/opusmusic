<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfquery name="clearFromBackInStock" datasource="#DSN#">
	update catItems
    set albumStatusID=24
    where albumStatusID=23 AND labelID=#url.ID#
</cfquery>
<cflocation url="listsLabels.cfm?letter=#url.letter#">