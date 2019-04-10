<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
<style>
h3 {font-size: x-small; margin-top: 3px; margin-bottom: 3px;}
h4 {font-size: x-small; color:#FFFFFF; margin-top: 3px; margin-bottom: 3px;}
td {color: #333333;}
</style><!--- AND reissue=0 AND genreID<>7 AND labelID<>2035 AND labelID<>1702//--->
<cfquery name="catalogFind" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0, 1, 0, 0)#">
    select *
    from catItemsQuery
    where albumStatusID<=22 
    AND DateDiff(day,releaseDate,#varDateODBC#)<14 AND ONSIDE<>999 AND shelfCode<>'DT'
    order by releaseDate DESC, ONHAND DESC
</cfquery>
<table border="0" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" bgcolor="#CCCCCC" align="center">
<cfloop query="catalogFind">
    <cfquery name="thisItem" datasource="#DSN#">
        select *
        from catItemsQuery
        where ID=#ID#
    </cfquery>
    <cfoutput query="thisItem">
    <tr style="background-color: ##6699CC">
    	<td valign="middle" style="color:##FFFFFF;"><h3>#shelfCode#</h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3><a href="catalogEdit.cfm?ID=#ID#" target="_blank">#catnum#</a></h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3>#label#</h3></td>
    	<td valign="middle" style="color:##FFFFFF;"><h3>#artist#</h3></td>
        <td valign="middle" style="color:##FFFFFF;"><h3>#title#</h3></td>
        <td valign="middle" style="color:##FFFFFF;">ONHAND: #ONHAND#</td>
    </tr>
    </cfoutput>
    <tr><td colspan="6" valign="top" bgcolor="#CCCCCC"><table width="100%" border="0" cellpadding="2" cellspacing="2" style="border-collapse: collapse;">
      <tr>
    <cfquery name="sellHistory" datasource="#DSN#">
        select dateStarted, firstName, lastName, qtyOrdered, email, statusID, adminAvailID, catItemID, datePurchased, dateUpdated
        from orderItemsQuery
        where catItemID=#thisItem.ID# AND adminAvailID=6 AND statusID<>7
        order by datePurchased DESC
    </cfquery>
    <td valign="top" width="25%">
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
        	<tr style="background-color: ##000033"><td colspan="3" bgcolor="#666666"><h4>Sell History</h4></td></tr>
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
    <cfquery name="sellHistory" datasource="#DSN#">
        select dateStarted, firstName, lastName, qtyOrdered, email, statusID, adminAvailID, catItemID, datePurchased, dateUpdated
        from orderItemsQuery
        where catItemID=#thisItem.ID# AND adminAvailID IN (2,4) AND statusID NOT IN (1,6,7) AND dateDiff(day,dateUpdated,getDate())<90
        order by dateUpdated DESC
    </cfquery>
    <td valign="top" width="25%">
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
			<tr style="background-color: #666666"><td colspan="3"><h4>Open Orders</h4></td></tr>
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
        where catItemID=#thisItem.ID# AND adminAvailID NOT IN (1,3,4,5,6) AND statusID=1 AND dateDiff(day,dateUpdated,getDate())<90
        order by dateUpdated DESC
    </cfquery>
    <td valign="top" width="25%">
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
			<tr style="background-color: #666666"><td colspan="3"><h4>Carts</h4></td></tr>
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
        where catItemID=#thisItem.ID# AND (adminAvailID=3 OR adminAvailID=1) AND statusID<>7
        order by dateStarted DESC
    </cfquery>
    <td valign="top" width="25%">
        <table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%" bgcolor="#FFFFFF">
            <tr style="background-color: #000033"><td colspan="3" style="background-color: #666666""><h4>Backorders</h4></td></tr>
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
