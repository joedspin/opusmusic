<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt304Items
		</cfquery>
        <cfloop query="catFind">
        <cfquery name="fixfixfix" datasource="#DSN#">
        	update catItems
            set price=#catFind.price#, cost=#catFind.cost#, priceSave=#catFind.priceSave#, costSave=#catFind.costSave#
            where ID=#catFind.ID#
        </cfquery>
        </cfloop>