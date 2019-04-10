<!---Finalize orders //--->
<!---First, if quantity ONHAND is greater than QUANTITY ordered, substract //--->
<cfquery name="subtract1" datasource="#DSN#">
	update GEMMBatchProcessing, catItems
	set catItems.ONHAND=catItems.ONHAND-Val(GEMMBatchProcessing.Quantity) WHERE ((catItems.ONHAND>GEMMBatchProcessing.Quantity) AND (catItems.catnum=GEMMBatchProcessing.opCATNUM)) AND Processed <> 1 AND Processed Is Not Null
</cfquery>
<!---Second, if quantity ONHAND is less than QUANTITY ordered, set ONHAND to 0 //--->
<cfquery name="subtract2" datasource="#DSN#">
	update GEMMBatchProcessing, catItems
	set catItems.ONHAND=0 WHERE ((catItems.ONHAND<=GEMMBatchProcessing.Quantity) AND (catItems.catnum=GEMMBatchProcessing.opCATNUM)) AND Processed <> 1 AND Processed Is Not Null
</cfquery>
<!--- Set PROCESSED flag to 1 //--->
<cfquery name="markProcessed" datasource="#DSN#">
	update GEMMBatchProcessing
	set Processed=1
</cfquery>
<!--- Archive items where quantity ONHAND has reached 0 by setting them to inactive //--->
<cfquery name="archiveItems" datasource="#DSN#">
	update catItems
	set active=0
	where ONHAND=0
</cfquery>
<cflocation url="orders.cfm">
