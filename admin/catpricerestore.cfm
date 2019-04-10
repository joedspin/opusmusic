<cfquery name="catFind" dbtype="query">
                select *
                from Application.dt#siteChoice#Items
                where price=0
            </cfquery><cfoutput>#catFind.recordCount#</cfoutput>