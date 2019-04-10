<cfquery name="listInactive" datasource="#DSN#">
	select *
	from catItemsQuery
	where albumStatusID>24
</cfquery>
<cfoutput query="listInactive">
#catnum# | #label# | #artist# | #title# | #ONHAND# | #YesNoFormat(active)#<br>
</cfoutput>
<cfquery name="fixInactive" datasource="#DSN#">
 update catItems
 set ONHAND=0, active=0
 where albumStatusID>24
</cfquery>