<cfquery name="status" datasource="#DSN#">
	select *
	from orderStatus
</cfquery>
<cfoutput query="status">#ID# - #statusName#<br></cfoutput>