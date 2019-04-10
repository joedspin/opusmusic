<cfquery name="labelHide" datasource="#DSN#">
	update catItems
    set albumStatusID=25, ONHAND=0
    where labelID IN (2035, 1702, 2054, 2038, 2239, 706)
</cfquery>