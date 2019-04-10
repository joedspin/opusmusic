<cfquery name="duplicateDT" datasource="#DSN#">
SELECT catnum, dtID,
 COUNT(dtID) AS NumOccurrences
FROM catItems
where dtID<>0
GROUP BY dtID, catnum
HAVING ( COUNT(dtID) > 1 )
</cfquery>	
<cfoutput query="duplicateDT">
#catnum# [#dtID#] x #NumOccurrences# <br>
</cfoutput>