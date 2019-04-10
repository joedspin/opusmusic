<cfquery name="trackFind" datasource="#DSN#">
        select DISTINCT itemID from catTracksQuery
            where (LOWER(artist) LIKE '%kerri chandler%' OR
            LOWER(title) LIKE '%kerri chandler%' OR
            LOWER(tName) LIKE '%kerri chandler%')
            AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
        </cfquery>
        <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<cfif tfStart><cfset trackFindList=trackFindList&","&itemID><cfelse><cfset trackFindList=itemID></cfif>
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
		<cfquery name="catFind" datasource="#DSN#">
            select DISTINCT ID from catItemsQuery where ID IN (#trackFindList#) OR ((LOWER(artist) LIKE '%kerri chandler%' OR
                    LOWER(title) LIKE '%kerri chandler%')
                    AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999) AND catnum<>'MT2222CD'
        </cfquery>
        <cfif catFind.recordCount GT 0>
        	<cfset cfStart=false>
            <cfloop query="catFind">
            	<cfif cfStart><cfset catFindList=catFindList&","&ID><cfelse><cfset catFindList=ID></cfif>
				<cfset cfStart=true>
            </cfloop>
        <cfelse>
        	<cfset catFindList="0">
        </cfif>
        <cfquery name="makeKerriSpecial" datasource="#DSN#">
        	update catItems
            set specialItem=1
            where ID IN (#catFindList#)
        </cfquery>