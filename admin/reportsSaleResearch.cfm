<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
<style>
h3 {font-size: x-small; margin-top: 3px; margin-bottom: 3px;}
h4 {font-size: x-small; color:#FFFFFF; margin-top: 3px; margin-bottom: 3px;}
td {color: #333333;}
</style>
<cfquery name="catalogFind" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0, 1, 0, 0)#">
    select *
    from catItemsQuery
    where vendorID=5439 AND NRECSINSET=1 AND mediaID=1 AND artistID NOT IN (3062,3113) AND ((albumStatusID<25 AND ONHAND >0) OR ONSIDE>0) AND ONSIDE<>999
    order by catnum
</cfquery>
<table border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse;" bgcolor="#CCCCCC" align="center">
<cfloop query="catalogFind">
    <!---<cfquery name="thisItem" datasource="#DSN#">
        select *
        from catItemsQuery
        where ID=#ID#
    </cfquery>
    <cfoutput query="thisItem">//--->
	<cfoutput>
    <tr bgcolor="##003366">
    	<td valign="middle" style="color:##FFFFFF;"><h3>#shelfCode#</h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3>#UCase(Left(label,10))#</h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3>#catnum#</h3></td>
    	<td valign="middle" style="color:##FFFFFF;"><h3>#artist#</h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3>#title#</h3></td>
        <td valign="middle" style="color:##FFFFFF;">ONHAND: #ONHAND#<br />ONSIDE: #ONSIDE#</td>
    </tr>
    </cfoutput>
    <tr><td colspan="6" valign="top" bgcolor="#CCCCCC"><table width="100%" border="1" cellpadding="4" cellspacing="4" style="border-collapse: collapse;"><tr>
    <cfquery name="sellHistory" datasource="#DSN#">
        select dateStarted, firstName, lastName, qtyOrdered, email, statusID, adminAvailID, catItemID, datePurchased, dateUpdated
        from orderItemsQuery
        where catItemID=#ID# AND adminAvailID IN (4,5,6) AND statusID<>7
        order by datePurchased DESC
    </cfquery>
    <td valign="top" width="33%">
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
        	<tr bgcolor="#000033"><td colspan="3"><h4>Sell History</h4></td></tr>
            <cfset totalSold=0>
            <cfoutput query="sellHistory">
                <tr>
                    <td width="60">#DateFormat(datePurchased,"yyyy-mm-dd")#</td>
                    <td>#firstName# #lastName#</td>
                    <td align="center" width="20">#qtyOrdered#</td>
                </tr>
                <cfset totalSold=totalSold+qtyOrdered>
            </cfoutput>
            <tr>
            	<td width="60">&nbsp;</td>
                <td align="right">Total:</td>
                <td align="center" width="20"><cfoutput>#totalSold#</cfoutput>
            </tr>
        </table>
    </td>
    <!---<cfquery name="sellHistory" datasource="#DSN#">
        select *
        from orderItemsQuery
        where catItemID=#thisItem.ID# AND (adminAvailID=4 OR adminAvailID=5) AND statusID<>7
        order by dateStarted DESC
    </cfquery>
    <td valign="top" width="20%"><h4>Open Orders</h4>
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
            <cfset totalSold=0>
            <cfoutput query="sellHistory">
                <cfquery name="thisCust" datasource="#DSN#">
                    select firstName, lastName, email
                    from custAccounts
                    where ID=#custID#
                </cfquery>
                <tr>
                    <td width="60"><a href="ordersEdit.cfm?ID=#orderID#">#DateFormat(dateStarted,"yyyy-mm-dd")#</a></td>
                    <td><cfloop query="thisCust"><a href="mailto:#email#">#firstName# #lastName#</a></cfloop></td>
                    <td align="center" width="20">#qtyOrdered#</td>
                </tr>
                <cfset totalSold=totalSold+qtyOrdered>
            </cfoutput>
            <tr>
                <td align="right" colspan="2">Total:</td>
                <td align="center"><cfoutput>#totalSold#</cfoutput>
            </tr>
        </table>
    </td>//--->
    <cfquery name="sellHistory" datasource="#DSN#">
        select dateStarted, firstName, lastName, qtyOrdered, email, statusID, adminAvailID, catItemID, datePurchased, dateUpdated
        from orderItemsQuery
        where catItemID=#ID# AND (adminAvailID=2 OR adminAvailID=0) AND statusID<>7 AND dateDiff(day,dateUpdated,getDate())<90
        order by dateUpdated DESC
    </cfquery>
    <td valign="top" width="33%">
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
			<tr bgcolor="#000033"><td colspan="3"><h4>Pending Orders</h4></td></tr>
            <cfset totalSold=0>
            <cfoutput query="sellHistory">
                <tr>
                    <td width="60">#DateFormat(dateUpdated,"yyyy-mm-dd")#</td>
                    <td>#firstName# #lastName#</td>
                    <td align="center" width="20">#qtyOrdered#</td>
                </tr>
                <cfset totalSold=totalSold+qtyOrdered>
            </cfoutput>
            <tr>
            	<td width="60">&nbsp;</td>
                <td align="right">Total:</td>
                <td align="center" width="20"><cfoutput>#totalSold#</cfoutput>
            </tr>
        </table>
	</td>
    <cfquery name="sellHistory" datasource="#DSN#">
        select dateStarted, firstName, lastName, qtyOrdered, email, statusID, adminAvailID, catItemID, datePurchased, dateUpdated
        from orderItemsQuery
        where catItemID=#ID# AND (adminAvailID=3 OR adminAvailID=1) AND statusID<>7
        order by dateStarted DESC
    </cfquery>
    <td valign="top" width="33%">
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
            <tr bgcolor="#000033"><td colspan="3"><h4>Backorders</h4></td></tr>
			<cfset totalSold=0>
            <cfoutput query="sellHistory">
                <tr>
                    <td width="60">#DateFormat(dateStarted,"yyyy-mm-dd")#</td>
                    <td>#firstName# #lastName#</td>
                    <td align="center" width="20">#qtyOrdered#</td>
                </tr>
                <cfset totalSold=totalSold+qtyOrdered>
            </cfoutput>
            <tr>
            	<td width="60">&nbsp;</td>
                <td align="right">Total:</td>
                <td align="center" width="20"><cfoutput>#totalSold#</cfoutput>
            </tr>
        </table>
    </td>
    <!---<cfquery name="sellHistory" datasource="#DSN#">
        select *
        from orderItemsQuery
        where catItemID=#thisItem.ID# AND adminAvailID=1
        order by dateStarted DESC
    </cfquery>
    <td valign="top" width="20%"><h4>Marked as 'Not Available'</h4>
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
            <cfset totalSold=0>
            <cfoutput query="sellHistory">
                <cfquery name="thisCust" datasource="#DSN#">
                    select firstName, lastName, email
                    from custAccounts
                    where ID=#custID#
                </cfquery>
                <tr>
                    <td width="60">#DateFormat(dateStarted,"yyyy-mm-dd")#</td>
                    <td><cfloop query="thisCust"><a href="mailto:#email#">#firstName# #lastName#</a></cfloop></td>
                    <td align="center" width="20">#qtyOrdered#</td>
                </tr>
                <cfset totalSold=totalSold+qtyOrdered>
            </cfoutput>
            <tr>
                <td align="right" colspan="2">Total:</td>
                <td align="center"><cfoutput>#totalSold#</cfoutput>
            </tr>
        </table>
    </td>//---></tr></table></td></tr>
</cfloop></table>
<cfinclude template="pageFoot.cfm">
