<cfquery name="fixArtists" datasource="#DSN#">
	update artists
	set sort=right(sort,Len(sort)-3)
	where Left(name,4)='The ' AND Left(sort,3)='THE'
</cfquery>