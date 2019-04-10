<cfquery name="checkNonDT" datasource="#DSN#">
	select *
    from catItemsQuery
    where cost IN (1.89,2.89,3.89) AND shelfID IN (7,11,13)
</cfquery>
<cfset itemCount=1>
<cfoutput query="checkNonDT">
#itemCount# - 	#catnum# #artist# #title# [#shelfID#]<br>
<cfset itemCount=itemCount+1>
</cfoutput>


<cfquery name="under2" datasource="#DSN#">
	update catItems
    set specialItem=1, dateUpdated=#varDateODBC#
    where cost IN (1.89,2.89,3.89) AND shelfID IN (7,11,13)
</cfquery>
<cfquery name="fixDT" datasource="#DSN#">
	update catItems
	set shelfID=11
	where shelfID IN (7,13)
</cfquery>
<cfquery name="killDother" datasource="#DSN#">
	delete
	from shelf
	where ID IN (7,13)
</cfquery>
<cfquery name="fixDI" datasource="#DSN#">
	update shelf
	set code='DT', partner='Downtown 161'
	where code='DI'
</cfquery>
<!---
<cfquery name="bssale" datasource="#DSN#">
	update catItems
    set price=3.99
    where shelfID=29
</cfquery>

//--->