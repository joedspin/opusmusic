<cfquery name="zfix" datasource="#DSN#">
	update catItems 
    set ONHAND=0, ONSIDE=0, albumStatusID=144 where shelfID IN (select ID from shelf where left(code,1)='Z')
</cfquery>