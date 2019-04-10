<cfquery name="fixKSSKNG" datasource="#DSN#">
 update catItems
 set releaseDate=DTdateUpdated
 where DTdateUpdated<releaseDate
 AND labelID IN (574,499,599)
</cfquery>
done KSS KNG