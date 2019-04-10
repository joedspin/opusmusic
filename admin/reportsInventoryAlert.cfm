<cfquery name="inventoryAlert" datasource="#DSN#">
	select catItemID, catnum, label, artist, title, media, NRECSINSET, ONHAND, adminAvailID, albumStatusID, Sum(qtyOrdered)
    from orderItemsQuery
    where adminAvailID IN (2,4) AND statusID NOT IN (1,6,7) AND albumStatusID<25
    group by qtyOrdered, ONHAND, catnum, label, artist, title, media, NRECSINSET, ONHAND, adminAvailID, albumStatusID, catItemID
    having Sum(qtyOrdered)>ONHAND
    order by label, catnum
</cfquery>
<cfoutput query="inventoryAlert">
<a href="catalogEdit.cfm?ID=#catItemID#" target="_blank">#catnum#</a> #label# | #artist# | #title# | <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#<br>
</cfoutput>