<cfquery name="getminusone" datasource="#DSN#">
	select *
	from catItems
	where ONHAND=-1
</cfquery>
<cfoutput>#getminusone.recordCount#</cfoutput>
<cfoutput query="getminusone">
#catnum#<br>
</cfoutput>
<cfquery name="fixminusone" datasource="#DSN#">
	update
	catItems
	set ONHAND=1
	where ONHAND=-1
</cfquery>