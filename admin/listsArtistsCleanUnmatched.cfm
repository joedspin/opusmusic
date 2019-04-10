<cfquery name="cleanUnmatched" datasource="#DSN#">
select artists.*
FROM artists LEFT JOIN catItems ON artists.ID = catItems.artistID
WHERE (((catItems.artistID) Is Null)) AND artists.ID<>15387
</cfquery>
<cfloop query="cleanUnmatched">
	<cfquery name="deleteartist" datasource="#DSN#">
		delete *
		from artists
		where ID=#cleanUnmatched.ID#
	</cfquery>
</cfloop>