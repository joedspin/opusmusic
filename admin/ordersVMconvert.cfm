<cfparam name="url.ID" default="0">
<cfquery name="VMmove" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#url.ID# AND left(shelfCode,1)='D' AND dtID<>0 AND dtID Is Not Null 
</cfquery>
<cfif VMmove.recordCount GT 0>
	<cfset itemList="">	
    <cfloop query="VMmove">
    	<cfif itemList NEQ ""><cfset itemList=itemList&","></cfif>
		<cfset itemList=itemList&orderItemID>
	</cfloop>
    <cflocation url="http://10.0.0.113/DT161/eGrid_Master/opusToolsVMInvoiceMove.php?itemList=#itemList#&orderID=#url.ID#">
</cfif>
<cflocation url="ordersMakeVM.cfm?orderID=#url.ID#&VMdone=true">