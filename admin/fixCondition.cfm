<cfquery name="fixCondition" datasource="#DSN#">
	update catItems
	set CONDITION_MEDIA_ID=1
	where CONDITION_MEDIA_ID=0
</cfquery>
<cfquery name="fixCondition" datasource="#DSN#">
	update catItems
	set CONDITION_COVER_ID=1
	where CONDITION_COVER_ID=0
</cfquery>