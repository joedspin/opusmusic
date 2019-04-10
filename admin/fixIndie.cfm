<cfquery name="fixIndie" datasource="#DSN#">
	select count(genreID) As cgid, genreID from catItems
    GROUP BY genreID
</cfquery>
<cfoutput query="fixIndie">#genreID# - #cgid#<br>
</cfoutput>