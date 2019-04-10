<cfquery name="checkInactive" datasource="#DSN#">
	update
	catItemsQuery
	set active=true
	where active=false AND Left(shelfCode,1)='D' AND ONHAND>0 AND albumStatusID<25
</cfquery>
<!---<cfoutput query="checkInactive">
#title# | #artist# | #label# | #catnum# | #shelfCode# | #ONHAND# | #albumStatusID#<br />
</cfoutput>//--->
Done.