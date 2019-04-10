<cfparam name="url.ID" default="0">
<cfparam name="url.shelfID" default="0">
<style>
<!--
body, .cr {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
//-->
</style>

<cfparam name="url.crdate" default="#DateFormat(varDateODBC,"yyyy-mm-dd")#">
<cfparam name="url.cros" default="no">
<cfparam name="url.pushID" default="0">
<cfparam name="url.pushDate" default="">
<cfparam name="url.pushIDup" default="0">
<cfparam name="url.pushDateup" default="">
<cfif url.pushID NEQ 0 AND url.pushDate NEQ "">
	<cfquery name="pushItemRelease" datasource="#DSN#">
    	update catItems
        set releaseDate=<cfqueryparam value="#url.pushDate#" cfsqltype="cf_sql_date">
        where ID=<cfqueryparam value="#url.pushID#" cfsqltype="cf_sql_integer">
    </cfquery>
</cfif>
<cfif url.pushIDup NEQ 0 AND url.pushDateup NEQ "">
	<cfquery name="pushItemRelease" datasource="#DSN#">
    	update catItems
        set dtdateUpdated=<cfqueryparam value="#url.pushDateup#" cfsqltype="cf_sql_date">
        where ID=<cfqueryparam value="#url.pushIDup#" cfsqltype="cf_sql_integer">
    </cfquery>
</cfif>
<cfif url.ID NEQ 0 AND isNumeric(url.ID)>
	<cfquery name="catRcvd" datasource="#DSN#">
            select *
            from (((catRcvd Left JOIN catItemsQuery ON catItemsQuery.ID=catRcvd.catItemID) LEFT JOIN shelf ON shelf.ID=catRcvd.rcvdShelfID) LEFT JOIN wagamamaUsersHHG ON wagamamaUsersHHG.ID=catRcvd.rcvdUserID) where catRcvd.catItemID=#url.ID#
            order by dateReceived
        </cfquery>
<cfelseif url.shelfID NEQ 0>
   <cfquery name="catRcvd" datasource="#DSN#" maxrows="500">
            select *
            from (((catRcvd Left JOIN catItemsQuery ON catItemsQuery.ID=catRcvd.catItemID) LEFT JOIN shelf ON shelf.ID=catRcvd.rcvdShelfID) LEFT JOIN wagamamaUsersHHG ON wagamamaUsersHHG.ID=catRcvd.rcvdUserID) where 
            rcvdShelfID=<cfqueryparam cfsqltype="CF_SQL_CHAR" value="#url.shelfID#">
            order by dateReceived, catnum
        </cfquery>
<cfelse>
    <cfif url.cros>
        <cfquery name="catRcvd" datasource="#DSN#">
            select *
            from (((catRcvd Left JOIN catItemsQuery ON catItemsQuery.ID=catRcvd.catItemID) LEFT JOIN shelf ON shelf.ID=catRcvd.rcvdShelfID) LEFT JOIN wagamamaUsersHHG ON wagamamaUsersHHG.ID=catRcvd.rcvdUserID) where 
            CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, dateReceived)))=<cfqueryparam value="#url.crdate#" cfsqltype="cf_sql_date"> AND (rcvdShelfID=7 OR rcvdShelfID=11) order by rcvdShelfID, catnum
        </cfquery>
    <cfelse>
        <cfquery name="catRcvd" datasource="#DSN#">
            select *
            from (((catRcvd Left JOIN catItemsQuery ON catItemsQuery.ID=catRcvd.catItemID) LEFT JOIN shelf ON shelf.ID=catRcvd.rcvdShelfID) LEFT JOIN wagamamaUsersHHG ON wagamamaUsersHHG.ID=catRcvd.rcvdUserID) where 
            CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, dateReceived)))=<cfqueryparam value="#url.crdate#" cfsqltype="cf_sql_date"> AND rcvdShelfID<>7 order by rcvdShelfID, catnum
        </cfquery>
    </cfif>
</cfif>
<cfif url.ID EQ 0>
<h1>Downtown 304 . Catalog Received</h1>
<h2><cfoutput>#DateFormat(url.crdate,"mmmm d, yyyy")#</cfoutput></h2>
</cfif>
<cfset receivedCount=0>
<cfif url.ID EQ 0>
<table border='1' cellpadding='4' cellspacing='0' style="border-collapse:collapse;">
<cfelse>
<table border='1' cellpadding='4' cellspacing='0' style="border-collapse:collapse;" align="center">
</cfif>
<tr style="font-weight:bold; background-color:#CCCCCC;">
		<td class="cr" id="cr">QTY</td>
        <td class="cr" id="cr">CATNUM</td>
        <td class="cr" id="cr">LABEL</td>
        <td class="cr" id="cr">ARTIST</td>
        <td class="cr" id="cr">TITLE</td>
        <cfif url.ID EQ 0>
        <td class="cr" id="cr">MEDIA</td>
        <td class="cr" id="cr">DISCOGS</td>
        <td class="cr" id="cr">COST</td>
        <td class="cr" id="cr">PRICE</td>
        </cfif>
        <td class="cr" id="cr">USER</td>
        <td class="cr" id="cr">SHELF</td>
        <td class="cr" id="cr">ONHAND</td>
        <cfif url.ID EQ 0>
        <td class="cr" id="cr">STATUS</td>
        <td class="cr" id="cr">RLSDATE</td>
        <td class="cr" id="cr">UPDTD</td>
        <cfelse>
        <td class="cr" id="cr">RCVDATE</td>    
        </cfif>   
</tr>
<cfset IDlistBACK="">
<cfset IDlistNEW="">
<cfset prevRecdDate="">
<cfoutput query="catRcvd">
<cfif url.shelfID NEQ 0 AND dateReceived NEQ prevRecdDate>
	<tr style="font-weight:bold; background-color:##CCCCCC;"><td colspan="15">#DateFormat(dateReceived,"mmmm d, yyyy")#</td></tr>
	<cfset prevRecdDate=dateReceived>
</cfif>
<cfif Album_Status_Name EQ "BACK IN STOCK"><cfset IDlistBACK=IDlistBACK & catItemID & ","></cfif>
<cfif Album_Status_Name EQ "NEW RELEASE"><cfset IDlistNEW=IDlistNEW & catItemID & ","></cfif>
<cfset receivedCount=receivedCount+qtyRcvd>
	<tr>
    	<td class="cr" id="cr">#qtyRcvd#</td>
        <td class="cr" id="cr"><a href="catalogEdit.cfm?ID=#catItemID#" target="catedits">#catnum#</a></td>
        <td class="cr" id="cr">#label#</td>
        <td class="cr" id="cr">#artist#</td>
        <td class="cr" id="cr">#title#</td>
        <cfif url.ID EQ 0>
        <td class="cr" id="cr"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
        <td class="cr" id="cr"><cfif discogsID GT 0><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">#discogsID#</a><cfelse>&nbsp;</cfif></td>
        <td align="right">#DollarFormat(cost)#</td>
        <td align="right">#DollarFormat(price)#</td>
        </cfif>
        <td class="cr" id="cr">#username#</td>
        <td class="cr" id="cr" align="center">#code#</td>
        <cfif url.ID EQ 0>
        <td class="cr" id="cr"><cfif albumStatusID GT 24><font color="gray"><cfelse><font color="black"></font></cfif>#Album_Status_Name#</font></td>
        <td class="cr" id="cr">#ONHAND#</td>
        <cfif DateFormat(releaseDate,"yyyy-mm-dd") NEQ DateFormat(varDateODBC,"yyyy-mm-dd")>
        	<td style="font-weight: bold;"><cfelse><td style="background-color:##CCCCCC;"></cfif><a href="reportsCatRcvd.cfm?cros=#url.cros#&crdate=#url.crdate#&pushID=#catItemID#&pushdate=#DateFormat(DateAdd("d","1",releaseDate),"yyyy-mm-dd")#">#DateFormat(releaseDate,"mm/dd/yy")#</a><a href="reportsCatRcvd.cfm?cros=#url.cros#&crdate=#url.crdate#&pushID=#catItemID#&pushdate=#DateFormat(DateAdd("d","-1",releaseDate),"yyyy-mm-dd")#">-</a></td>
        <cfif DateFormat(dtDateUpdated,"yyyy-mm-dd") NEQ DateFormat(varDateODBC,"yyyy-mm-dd")>
        	<td style="font-weight: bold;"><cfelse><td style="background-color:##CCCCCC;"></cfif>
        <a href="reportsCatRcvd.cfm?cros=#url.cros#&crdate=#url.crdate#&pushIDup=#catItemID#&pushdateup=#DateFormat(DateAdd("d","1",dtDateUpdated),"yyyy-mm-dd")#">#DateFormat(dtDateUpdated,"mm/dd/yy")#</a><a href="reportsCatRcvd.cfm?cros=#url.cros#&crdate=#url.crdate#&pushIDup=#catItemID#&pushdateup=#DateFormat(DateAdd("d","-1",dtDateUpdated),"yyyy-mm-dd")#">-</a></td>
        <cfelse>
        <td class="cr" id="cr">#DateFormat(dateReceived,"yyyy-mm-dd")#</td>
        </cfif>
     </tr>
</cfoutput>
</table>
<cfoutput>
	Total  = #receivedCount#
    <cfif url.ID EQ 0>
		<cfif Len(IDListBACK) GT 0>
            <cfset IDListBACK=Left(IDlistBACK,Len(IDListBACK)-1)>
            <a href="http://www.downtown304.com/dt161news.cfm?sid=#IDlistBACK#" target="_blank">Back in Stock for Email</a>
        </cfif>
        <cfif Len(IDListNEW) GT 0>
            <cfset IDListNEW=Left(IDlistNEW,Len(IDListNEW)-1)>
            <a href="http://www.downtown304.com/dt161news.cfm?sid=#IDlistNEW#" target="_blank">New Releases for Email</a>
        </cfif>
    </cfif>
</cfoutput>
