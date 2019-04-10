<cfquery name="findMissingLabels" datasource="#DSN#">
	select *
	from catItems
	where labelID=0 or labelID IS Null
</cfquery>
<cfoutput query="findMissingLabels">
#ID# | #artist# | #title#<br />
</cfoutput>