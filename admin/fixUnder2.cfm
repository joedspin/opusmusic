<cfquery name="fixUnder4" datasource="#DSN#">
	update catItems
    set cost=buy, price=cost+1.8
    where shelfID IN (11,9,7,13) AND cost<4
</cfquery>

<cfquery name="under4" datasource="#DSN#">
	select *
    from catItemsQuery
    where buy<4 AND ((albumStatusID<25 AND ONHAND>0) OR ONSIDE>0)
</cfquery>

<cfoutput query="under4">
	#catnum# #label# #artist# #title# [#shelfID#]<br>
</cfoutput>

<!---<cfquery name="checkNonDT" datasource="#DSN#">
	select *
    from catItemsQuery
    where ((labelID=719 ) AND ((catnum IN ('SR12622','SR1251R','SR12265R','SR12179R','SR12380R','SR12403R','SR12539R','SR12564R','SR12569R','SR12578R','SR12232R','SR12611R','SR12196R','SR12576R') AND shelfID IN (11,9,7,13)) OR (shelfID NOT IN (11,9,7,13) AND NRECSINSET=1))) OR catnum='SRG1'
     order by catnum
</cfquery>
<cfoutput query="checkNonDT">
	#catnum# #artist# #title# [#shelfID#]<br>
</cfoutput>


<cfquery name="under2" datasource="#DSN#">
	update catItems
    set price=5.99, cost=3.99
    where ((labelID=719 ) AND ((catnum IN ('SR12622','SR1251R','SR12265R','SR12179R','SR12380R','SR12403R','SR12539R','SR12564R','SR12569R','SR12578R','SR12232R','SR12611R','SR12196R','SR12576R') AND shelfID IN (11,9,7,13)) OR (shelfID NOT IN (11,9,7,13) AND NRECSINSET=1))) OR catnum='SRG1'
</cfquery>//--->
<!---
<cfquery name="bssale" datasource="#DSN#">
	update catItems
    set price=3.99
    where shelfID=29
</cfquery>

//--->