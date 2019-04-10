<cfquery name="fixReleaseDate" datasource="#DSN#">
	update catItems
	set releaseDate=dtDateUpdated
	where albumStatusID=21 OR albumStatusID=22
</cfquery>
<cfquery name="fixReleaseDate" datasource="#DSN#">
	select * from catItems
	where albumStatusID=21 OR albumStatusID=22
	order by dtDateUpdated DESC
</cfquery>
<cfoutput query="fixReleaseDate">
	#releaseDate# | #catnum# | #dtDateUpdated#<br />
</cfoutput>