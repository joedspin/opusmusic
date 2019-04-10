<cfquery name="fixUnder3" datasource="#DSN#">
	select *
    from catItemsQuery
    where price=0.00
</cfquery>
<cfset count=0>
<cfoutput query="fixUnder3">
<cfset count=count+1>
#count# - #catnum# #label# #artist# #title#<br />
</cfoutput>