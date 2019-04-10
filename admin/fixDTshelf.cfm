<cfquery name="updateDT" datasource="#DSN#">
	update catItems
	set shelfID=11 where shelfID=7 OR (shelfID=28 AND releaseDate>'2009-12-31')
</cfquery>
