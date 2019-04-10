<cfquery name="updateCat" datasource="#DSN#">
	update
    catItems
    set mp3Deleted=0
    where mp3Deleted<>1

</cfquery>
