<cfquery name="DIInventory" datasource="#DSN#">
	select *
	from catItemsQuery
	where (shelfID=11) AND (dtID=0 or dtID='')
</cfquery>
<cfoutput query="DIInventory">
#catnum# | #artist# | #title# | #NRECSINSET# x #media#<br />
</cfoutput>