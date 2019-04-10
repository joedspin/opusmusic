<cfquery name="clearSpecial" datasource="#DSN#">
	update catItems
    set specialItem=1, price=cost-1
    where ID IN (select catItemID from orderItems where orderID=24727)
</cfquery>
<cfquery name="listSpecial" datasource="#DSN#">
	select *
    from catItems
    where specialItem=1
    order by catnum
</cfquery>
<cfoutput query="listSpecial">
#catNum#<br />
</cfoutput>