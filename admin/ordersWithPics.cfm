<cfparam name="url.ID" default="0">
<cfset pageName="ORDERS">
<cfset pageSub="EPICS">

<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>


<cfquery name="thisItems" datasource="#DSN#">
    SELECT *
    FROM orderItemsQuery
    where shelfID=11 AND orderID=#ID# AND ONSIDE<1
    order by label, catnum
</cfquery>

	<cfoutput query="thisOrder">
   <cfquery name="thisCust" datasource="#DSN#">
				select *
				from custAccounts
				where ID=#custID#
			</cfquery><cfloop query="thisCust">
            	<p style="font-size: medium; font-weight: bold; color:black;"><b>Order ###NumberFormat(url.ID,"00000")#</b> - <a href="customersOpusEdit.cfm?ID=#thisOrder.custID#">#firstName# #lastName#</a> [#username#]</p>
            </cfloop>
<cfquery name="iStat" datasource="#DSN#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
    select *
    from orderItemStatus
    where ID>1
</cfquery>	
<style>
h1 {margin-top: 6px; margin-bottom: 6px; margin-left: 6px; font-size: small; font-weight: bold;}
</style>
  <!---<cfquery name="thisItems" datasource="#DSN#">
				SELECT *
				FROM orderItemsQuery
				where orderID=#ID#
				order by adminAvailID, label, catnum
			</cfquery>//--->		
	<cfset totalItemCount=0>		
		<table cellpadding="3" cellspacing="0" border="1" style="border-collapse:collapse;">
						
                        <tr><td colspan="18"><h1>Downtown 161</h1></td></tr>
                       
          <cfset DT161total=0>
							<cfloop query="thisItems">
                            <cfset onlyImports=false>
                            <cfset totalItemCount=totalItemCount+1>
							<tr>
								<cfset thisItemID=orderItemID>
								<cfset thisItemStatID=adminAvailID>
								<cfset thisONSIDE=ONSIDE>
                               <cfif fullImg NEQ "">
            	<cfset imagefile="items/oI#catItemID#full.jpg">
			<cfelseif jpgLoaded>
				<cfset imagefile="items/oI#catItemID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><img src="../images/#imagefile#" width="70" height="70" border="0" /></a></td>
                                <!---
									<cfloop query="iStat"><td nowrap<cfif thisItemStatID EQ iStat.ID> style="background-color:##FFFFFF; color: ##000000; border-color:##000000;"</cfif>><span style="font-size: xx-small;"><cfinput type="radio" name="stat#thisItemID#" value="#iStat.ID#" checked="#YesNoFormat(thisItemStatID EQ iStat.ID)#"><cfif thisONSIDE GT 0 and iStat.name EQ "Available ONSIDE"><font color="cyan"><b> Available ONSIDE</b></font></cfif>#iStat.name#</span></cfloop>//---></td>
									
							
								<td nowrap valign="top"><a href="catalogEdit.cfm?ID=#catItemID#" target="_blank">#catnum#</a></td>
								<td nowrap valign="top">#label#</td>
								<td nowrap valign="top">#artist#</td>
								<td nowrap valign="top">#title#</td>
                                <td nowrap valign="top"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
                                <td nowrap valign="top">#shelfCode#</td>
                                
							
					</tr>
                  
			</cfloop>
        
            
            
            
            <tr><td colspan="18"><h1>Downtown 304</h1></td></tr>
                        <cfquery name="thisItems" datasource="#DSN#">
                            SELECT *
                            FROM orderItemsQuery
                            where shelfID<>11 AND orderID=#ID#
                            order by label, catnum
                        </cfquery>
          
							<cfloop query="thisItems">
							<cfif price EQ 0><tr bgcolor="red"><cfelse><tr></cfif>
								<cfset thisItemID=orderItemID>
								<cfset thisItemStatID=adminAvailID>
								<cfset thisONSIDE=ONSIDE>
							<cfif fullImg NEQ "">
            	<cfset imagefile="items/oI#catItemID#full.jpg">
			<cfelseif jpgLoaded>
				<cfset imagefile="items/oI#catItemID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><img src="../images/#imagefile#" width="70" height="70" border="0" /></a></td>
									
								<td nowrap valign="top"><a href="catalogEdit.cfm?ID=#catItemID#" target="_blank">#catnum#</a></td>
								<td nowrap valign="top">#label#</td>
								<td nowrap valign="top">#artist#</td>
								<td nowrap valign="top">#title#</td>
                                <td nowrap valign="top"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
                                <td nowrap valign="top">#shelfCode#</td>
                                
					</tr>
			</cfloop>
            
          </table>
         </cfoutput>