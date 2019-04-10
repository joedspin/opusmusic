<cfquery name="labelsale" datasource="#DSN#">
	select count(labelID) as labelCount
    from catItems
    where ONHAND>0 AND albumStatusID<25
</cfquery>
<CFOUTPUT query="labelsale">
#labelCount#<br>
</CFOUTPUT>