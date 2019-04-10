<cfquery name="lookupjoe" datasource="#DSN#">
	select *
    from wagamamaUsersHHG
</cfquery>
<cfoutput query="lookupjoe">
#username# #passcheck#<br>
</cfoutput>