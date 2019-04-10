<cfquery name="excludeBeggarsBanquet" datasource="#DSN#">
	update catItems
    set price=pricesave, pricesave=0
    where (shelfID=48 OR labelID IN (8459,8246,4421)) and pricesave>0
</cfquery>