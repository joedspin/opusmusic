<cfset trackChoice="Application.allTracks">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Special</title>
</head>

<body>
<cfquery name="Application.allTracks" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,8,1,0)#">
	select *
	from catTracksQuery
    where albumStatusID=148 OR ((albumStatusID=30) OR (ONHAND>0 and albumStatusID<25) OR (ONSIDE>0 AND ONSIDE<>999) OR (albumStatusID=26 AND ONHAND>0)) OR (ONHAND=0 AND ONSIDE=0 AND albumStatusID>25  AND left(shelfCode,1)<>'D' AND
			dtDateUpdated>'#DateFormat(DateAdd('d',-30,varDateODBC),"yyyy-mm-dd")#' AND itemID IN (select catItemID from purchaseOrderDetails where completed=0 AND qtyRequested>qtyReceived))
</cfquery>
<cfset trackChoice="Application.allTracks">
<cfparam name="form.searchString" default="">
<cfform name="searchspecial" action="reports_Special.cfm" method="post">
<cfoutput><input type="text" name="searchString" size="40" value="#form.searchString#"/><input type="submit" name="submit" value="Search" /></cfoutput>
</cfform>
<cfif form.searchString NEQ "">
<cfquery name="trackFind" dbtype="query">
        	select DISTINCT itemID from #trackChoice#
            where (LOWER(artist) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(title) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(label) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(tName) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(catnum) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char">)
                AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0 OR albumStatusID=30) AND ONSIDE<>999
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
        <cfquery name="catFind" dbtype="query">
            select * from allItems where ID IN (#trackFindList#) OR 
            	((LOWER(artist) LIKE <cfqueryparam value='%#LCase(form.searchString)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(title) LIKE <cfqueryparam value='%#LCase(form.searchString)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(label) LIKE <cfqueryparam value='%#LCase(form.searchString)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(catnum) LIKE <cfqueryparam value='%#LCase(form.searchString)#%' cfsqltype="cf_sql_char">)
                    AND (((ONHAND>0 AND albumStatusID<25) OR ONSIDE> 0 OR albumStatusID=30) AND ONSIDE<>999))
                order by releaseDate DESC
        </cfquery>

<cfset lastcatnum="">
<cfoutput query="catFind">
<cfif catnum NEQ lastcatnum>
<cfset lastcatnum=catnum>
<table border="1" style="border-collapse:collapse;" cellpadding="10" cellspacing="0" width="600">
	<cfset activeItemID=ID>
    <cfif catFind.jpgLoaded>
		<cfset imagefile="items/oI#catFind.ID#.jpg">
    <cfelseif catFind.jpgLoaded AND logofile EQ "">
    	<cfset imagefile="items/oI#catFind.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
	<cfquery name="tracksdj"  datasource="#DSN#">
		select *
		from catTracks
		where catID=#activeItemID#
		order by tSort
	</cfquery>
    <cfif shelfCode EQ 'DT'><cfset thisPrice=buy><cfelse><cfset thisPrice=wholesalePrice></cfif>
    <tr>
    	<td rowspan="2" valign="top" width="75"><img src="http://www.downtown304.com/images/#imageFile#" /></td>
        <td valign="top" nowrap><strong>#Ucase(artist)#<br />#title#<br>#CATNUM# #DollarFormat(thisPrice)#</strong>
        <td valign="top" nowrap width="25"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
    </tr>
    <tr>
    	<td colspan="2" nowrap>
        <cfset tstart=false>
        <cfloop query="tracksdj"><cfif tstart><br /></cfif><cfset tstart=true>#tName#</cfloop>&nbsp;</td>
    </tr>
</table><img src="images/spacer.gif" width="600" height="10" />
</cfif>
</cfoutput>
</cfif>
</body>
</html>