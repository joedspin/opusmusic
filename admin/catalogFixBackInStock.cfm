<cfquery name="fixBackInStock" datasource="#DSN#">
	select *, DateDiff(day,dtDateUpdated,#varDateODBC#) As ddCalc
    from catItemsQuery
    where albumStatusID=23 AND DateDiff(day,dtDateUpdated,#varDateODBC#)>90 AND isVendor
</cfquery>
<cfoutput query="fixBackInStock">
	#catnum# - #label# - #artist# - #title# - #ddCalc#<br>
</cfoutput>
<cfquery name="fixBackInStock" datasource="#DSN#">
	update catItemsQuery
    set albumStatusID=24
    where albumStatusID=23 AND DateDiff(day,dtDateUpdated,#varDateODBC#)>90 AND isVendor
</cfquery>
