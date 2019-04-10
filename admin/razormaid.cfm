<cfquery name="razormaid" datasource="#DSN#">
	update catItems
set ONHAND=1, albumStatusID=25, dtID=0, shelfID=3, price=75.00
where labelID=8492
</cfquery>