<cfquery name="findMissingArtists" datasource="#DSN#">
	select *
	from catItems
	where artistID=0 or artistID IS Null
</cfquery>
<cfoutput query="findMissingArtists">
#ID# | #artist# | #title#<br />
</cfoutput>