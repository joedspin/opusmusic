<cfquery name="catfixnew" datasource="#DSN#">
    select *
    from catItems 
    where ONHAND>0  AND albumStatusID=21
        AND releaseDate<='#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#'
        order by releaseDate DESC, ONHAND Desc
</cfquery>

<cfoutput query="catfixnew">
#CATNUM# | #dateformat(releasedate,'yyyy-mm-dd')#<br>
</cfoutput>
<!---
<cfquery name="catfixnewdo" datasource="#DSN#">
    update catItems
    set albumStatusID=24 where
    where ONHAND>0  AND albumStatusID=21
        AND releaseDate<='#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#'
</cfquery>//--->