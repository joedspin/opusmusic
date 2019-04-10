<cfquery name="fixLabels" datasource="#DSN#">
	update catItems
    set labelID=7709, artistID=3121
    where labelID=796 and title LIKE '%Loft Classic%'
</cfquery>
<cfquery name="fixLabels" datasource="#DSN#">
	update catItems
    set labelID=7710, artistID=3121
    where labelID=796 and title LIKE '%Garage Classic%'
</cfquery>