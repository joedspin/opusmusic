<cfquery name="fixGenres" datasource="#DSN#">
	update catItems
	set genreID=8
	where labelID=2022 OR labelID=2045 OR labelID=3992 OR labelID=2043
</cfquery>
<cfquery name="fixGenres" datasource="#DSN#">
	update catItems
	set genreID=4
	where labelID=2413 OR labelID=2036
</cfquery>
<cfquery name="addGenre" datasource="#DSN#">
	insert into genres (name)
	values ('Trance')
</cfquery>