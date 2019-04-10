<h1>Downtown 304</h1>
<h2>INVENTORY VALUE</h2>
<cfquery name="invValue" datasource="#DSN#">
	select Sum(ONHAND) As InvCount, Sum(ONHAND*COST) As InvValue, Sum(ONHAND*price) As InvLessOf
    from catItemsQuery where albumStatusID<25 AND ONHAND>0 AND isVendor=1 AND left(shelfCode,1)<>'D' AND cost<price
</cfquery>
<cfquery name="invValue2" datasource="#DSN#">
	select Sum(ONHAND) As InvCount, Sum(ONHAND*COST) As InvValue, Sum(ONHAND*price) As InvLessOf
    from catItemsQuery where albumStatusID<25 AND ONHAND>0 AND isVendor=1 AND left(shelfCode,1)<>'D' AND price<=cost
</cfquery>
<cfoutput query="invValue">
<p>Where cost is less than price:<br>
#NumberFormat(InvCount)# Units in stock<br />
#DollarFormat(InvValue)# cost<br><cfset totalCost=InvValue>
#DollarFormat(InvLessOf)# price</p>
</cfoutput>
<cfoutput query="invValue2">
<p>Where price is less than cost:<br>
#NumberFormat(InvCount)# Units in stock<br />
#DollarFormat(InvValue)# cost<br>
#DollarFormat(InvLessOf)# price<cfset totalCost=totalCost+InvLessOf></p>
</cfoutput>
<cfquery name="allInv" datasource="#DSN#">
	select *
    from catItemsQuery where albumStatusID<25 AND ONHAND>0 AND isVendor=1 AND left(shelfCode,1)<>'D'
</cfquery>
<cfoutput><p>#NumberFormat(allInv.recordCount)# different titles</p>
<p>Value (lesser of cost or value): #DollarFormat(totalCost)#</cfoutput></p>

<cfquery name="invValue3" datasource="#DSN#">
	select Sum(ONHAND) As InvCount, Sum(ONHAND*COST) As InvValue
    from catItemsQuery where albumStatusID<25 AND ONHAND>0 AND isVendor=1 AND left(shelfCode,1)<>'D' AND cost<price AND ONHAND<21
</cfquery>
<cfquery name="invValue4" datasource="#DSN#">
	select Sum(ONHAND) As InvCount, Sum(ONHAND*price) As InvValue
    from catItemsQuery where albumStatusID<25 AND ONHAND>0 AND isVendor=1 AND left(shelfCode,1)<>'D' AND price<=cost AND ONHAND<21
</cfquery>
<cfquery name="invValue5" datasource="#DSN#">
	select Sum(ONHAND) As InvCount, Sum(ONHAND*COST) As InvValue
    from catItemsQuery where albumStatusID<25 AND ONHAND>0 AND isVendor=1 AND left(shelfCode,1)<>'D' AND cost<price AND ONHAND>20
</cfquery>
<cfquery name="invValue6" datasource="#DSN#">
	select Sum(ONHAND) As InvCount, Sum(ONHAND*price) As InvValue
    from catItemsQuery where albumStatusID<25 AND ONHAND>0 AND isVendor=1 AND left(shelfCode,1)<>'D' AND price<=cost AND ONHAND>20
</cfquery>
<p>Value when overstock is treated as having $0.20 value per item<br>
<cfset overstockValue=invValue3.InvValue+invValue4.invValue+((invValue5.invCount+invValue6.invCount)*.20)>
<cfoutput>#DollarFormat(overstockValue)#</cfoutput></p>
<!--- This code block outputs all of the items included in the sum above ...
<cfoutput query="allInv">#shelfCode# #catnum# #label# #DollarFormat(cost)# #ONHAND# #DollarFormat(cost*ONHAND)#<br></cfoutput>
//--->