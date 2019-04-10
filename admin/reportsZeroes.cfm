<cfquery name="zeroes" datasource="#DSN#">
	select *
	from catItemsQuery
	where left(shelfCode,1)='D' AND ONHAND<1 AND albumStatusID<25
</cfquery>
<cfoutput query="zeroes">
#catnum# | #label# | #artist# |#title# | #albumStatusID# | #ONHAND#<br />
</cfoutput>