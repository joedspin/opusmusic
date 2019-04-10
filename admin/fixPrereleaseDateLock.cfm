<cfquery name="fixPre" datasource="#DSN#">
	update catItems
    set releaseDateLock=0
    where albumStatusID=148
</cfquery>