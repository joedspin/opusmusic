<cfquery name="fixMariannesFuckup" datasource="#DSN#">
	select catnum, qtyOrdered, catItemID
    from catItems LEFT JOIN orderItems ON catItems.ID=orderItems.catItemID
    where orderID=14333
</cfquery>
<cfoutput query="fixMariannesFuckup">
#catnum# #qtyOrdered#<br />
<cfquery name="fixMariannesFuckupAction" datasource="#DSN#">
	update catItems
    set ONHAND=ONHAND+(#qtyOrdered#*-1)
    where ID=#catItemID#
</cfquery>
</cfoutput>