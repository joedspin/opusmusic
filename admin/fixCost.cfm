<!---<cfquery name="oldCost" datasource="#DSN#">
	select *
    from catItemsBackup
</cfquery>
<cfquery name="fixCost" datasource="#DSN#">
	select *
    from catItems where cost=0
</cfquery>
<cfloop query="fixCost">
	<cfquery name="costSave" dbtype="query">
    	select ID, cost
        from oldCost
        where ID=#ID#
    </cfquery>
    <cfquery name="costFixer" datasource="#DSN#">
    	update catItems
        set cost=#costSave.cost#
        where ID=#ID#
    </cfquery>
</cfloop>//--->
<cfquery name="fixCost" datasource="#DSN#">
    UPDATE catItems
    SET cost = catItemsBackup.cost
    FROM catItemsBackup
    WHERE catItemsBackup.ID = catItems.ID
</cfquery>