<cfquery name="fixGenres" datasource="#DSN#">
	update genres
	set name='Dance'
	where ID=2
</cfquery>