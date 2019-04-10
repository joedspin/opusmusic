<cfquery name="media23" datasource="#DSN#">
	update catItems
    set mediaID=2 where mediaID=3
</cfquery>
<cfquery name="media3" datasource="#DSN#">
	delete 
    from media
    where ID=3
</cfquery>