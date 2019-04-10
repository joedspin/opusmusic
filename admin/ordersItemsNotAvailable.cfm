<table cellpadding="3" cellspacing="0" border="1" style="border-collapse:collapse;">
						
                        <tr><td colspan="11"><h1><cfoutput>Order Number #NumberFormat(url.ID,'00000')#</cfoutput> - Unvailable Items</h1></td></tr>
                        <cfquery name="thisItems" datasource="#DSN#">
                            SELECT *
                            FROM orderItemsQuery
                            where orderID=#ID# AND (albumStatusID>24 AND ONHAND=0 AND ONSIDE=0)
                            order by albumStatusID, label, catnum
                        </cfquery>
          <cfset lastStatus=0>
							<cfoutput query="thisItems">
                            <cfif albumStatusID NEQ lastStatus>
                            <tr><td colspan="4">#albumStatusName#</td></tr>
                            </cfif>
                            <cfset lastStatus=albumStatusID>
                            <cfset thisItemID=orderItemID>
								<cfset thisItemStatID=adminAvailID>
								<cfset thisONSIDE=ONSIDE>
							<tr>
								<td>#catnum#</td><td>#label#</td><td>#artist#</td><td>#title#</td><td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
								
					</tr>
			</cfoutput>