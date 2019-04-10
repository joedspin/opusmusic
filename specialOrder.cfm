<cfquery name="specialOrderItems" datasource="#DSN#">
	select * from catItemsQuery where albumStatusID=30
</cfquery>
<cfoutput query="specialOrderItems">#catnum# #artist# #title#<br /></cfoutput>