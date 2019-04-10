<cfquery name="catFind" dbtype="query">
                select *
                from Application.dt304Items
                where price=0
            </cfquery><cfoutput>#catFind.recordCount#</cfoutput>