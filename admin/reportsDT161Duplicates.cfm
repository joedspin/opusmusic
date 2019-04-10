<style>td {font-family:Arial, Helvetica, sans-serif; font-size:xx-small;}</style><cfquery name="findDuplicateDT161" datasource="#DSN#">
SELECT dtID, catnum, label, artist, title, COUNT(dtID) AS NumOccurrences
FROM catItemsQuery
GROUP BY dtID, catnum, label, artist, title 
HAVING ( COUNT(dtID) > 1 ) AND dtID<>0
order by catnum
</cfquery>
<table border="1">
<cfoutput query="findDuplicateDT161">
<tr><td>#NumOccurrences#</td><td>#catnum#</td><td>#label#</td><td>#artist#</td><td>#title#</td></tr>
</cfoutput>
</table>
