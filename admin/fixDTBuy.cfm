<cfquery name="fixDTBUY" datasource="#DSN#">
	update catItems
    set dtBuy=dt161Buy
	where dt161Buy Is Not Null
</cfquery>
