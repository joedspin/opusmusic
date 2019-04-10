<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Inventory Checker</title>
<style>
body, td {font-family:Arial, Helvetica, sans-serif; font-size: 12px;}
table {
  width: 100%;
  border: none;
}
td {
  vertical-align: top; 
  border: 1px solid #000;
  border-collapse: collapse;
  }
 a {text-decoration:none;}
 a:hover {text-decoration:underline;}
</style>
</head>
<cfparam name="url.sb" default="ONHAND">
<cfparam name="url.invType" default="Downtown 304 - Main">
<cfparam name="url.startAfterLabel" default="">
<cfparam name="form.invType" default="#url.invType#">
<body>
<cfform name="chooseType" action="reportsImportInventoryOPEN.cfm" id="chooseType" method="post" enctype="multipart/form-data">
	<select name="invType" id="invType" onChange="document.chooseType.submit();">
    	<cfif form.invType EQ "Downtown 304 - Main"><option selected="selected"><cfelse><option></cfif>Downtown 304 - Main</option>
        <cfif form.invType EQ "Downtown 304 - Ten Inch"><option selected="selected"><cfelse><option></cfif>Downtown 304 - Ten Inch</option>
        <cfif form.invType EQ "Downtown 304 - CDs"><option selected="selected"><cfelse><option></cfif>Downtown 304 - CDs</option>
        <cfif form.invType EQ "Downtown 161"><option selected="selected"><cfelse><option></cfif>Downtown 161</option>
        <cfif form.invType EQ "Downtown 161 - CDs"><option selected="selected"><cfelse><option></cfif>Downtown 161 - CDs</option>
        <cfif form.invType EQ "George T"><option selected="selected"><cfelse><option></cfif>George T</option>
        <cfif form.invType EQ "Metro"><option selected="selected"><cfelse><option></cfif>Metro</option>
        <cfif form.invType EQ "Polite"><option selected="selected"><cfelse><option></cfif>Polite</option>
        <cfif form.invType EQ "Seven Inch"><option selected="selected"><cfelse><option></cfif>Seven Inch</option>
    </select>
</cfform>
<cfif url.startAfterLabel NEQ "">
	    <cfswitch expression="#form.invType#">
        <cfcase value="Downtown 304 - Main">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID<>11 AND ONHAND>0 AND mediaID IN (1,12,5)
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Downtown 304 - Ten Inch">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID<>11 AND ONHAND>0 AND mediaID=9
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Downtown 161">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID=11 AND ONHAND>0 AND mediaID IN (1,12,5,9) AND vendorID NOT IN (5650,6978,2811)
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Downtown 161 - CDs">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID=11 AND ONHAND>0 AND mediaID IN (25,2,6)
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="George T">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID IN (2080,1064) AND ONHAND>0
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Metro">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID=11 AND ONHAND>0 AND mediaID IN (1,12,5,9) AND vendorID IN (5650,6978,2811)
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Polite">
            y
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID=1059 AND ONHAND>0
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Downtown 304 - CDs">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID<>11 AND ONHAND>0 AND mediaID IN (25,2,6)
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Seven Inch">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where ONHAND>0 AND mediaID=11
                	AND label>='#Trim(url.startAfterLabel)#'
                order by label, catnum
            </cfquery>
        </cfcase>
    </cfswitch>
<cfelse>
    <cfswitch expression="#form.invType#">
        <cfcase value="Downtown 304 - Main">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID<>11 AND ONHAND>0 AND mediaID IN (1,12,5)
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Downtown 304 - Ten Inch">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID<>11 AND ONHAND>0 AND mediaID=9
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Downtown 161">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID=11 AND ONHAND>0 AND mediaID IN (1,12,5,9) AND vendorID NOT IN (5650,6978,2811)
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Downtown 161 - CDs">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID=11 AND ONHAND>0 AND mediaID IN (25,2,6)
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="George T">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID IN (2080,1064) AND ONHAND>0
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Metro">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID=11 AND ONHAND>0 AND mediaID IN (1,12,5,9) AND vendorID IN (5650,6978,2811)
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Polite">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID=1059 AND ONHAND>0
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Downtown 304 - CDs">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where shelfID<>11 AND ONHAND>0 AND mediaID IN (25,2,6)
                order by label, catnum
            </cfquery>
        </cfcase>
        <cfcase value="Seven Inch">
            <cfquery name="invList" datasource="#DSN#">
                select *
                from catItemsQuery
                where ONHAND>0 AND mediaID=11
                order by label, catnum
            </cfquery>
        </cfcase>
    </cfswitch>
</cfif>
<cfquery name="openOrders" datasource="#DSN#">
select firstName, lastName, email, qtyOrdered, catItemID, adminAvailID, statusID, dateStarted, dateUpdated, datePurchased, orderID, ignoreSales
    from orderItemsQuery 
    where adminAvailID IN (4,5) AND statusID<>7
</cfquery>
<table cellpadding="2" cellspacing="0">
<cfoutput query="invList">
<cfquery name="getOpenOrders" dbtype="query">
	select sum(qtyOrdered) As numOnOrder
	from openOrders
	where catItemID=#ID#
</cfquery>
<cfif getOpenOrders.recordCount GT 0><cfset thisOnhand=ONHAND-getOpenOrders.numOnOrder><cfelse><cfset thisOnhand=ONHAND></cfif>
<tr>
<td width="25">&nbsp;</td>
<td align="center">#thisOnhand#</td>
<td><a href="reportsImportInventoryOPEN.cfm?startAfterLabel=#Trim(label)#"><span style="text-decoration:none; color:black;">#label#</span></a></td>
<td><a href="catalogEdit.cfm?ID=#ID#" target="itemEdit"><span style="text-decoration:none; color:black;">#catnum#</span></a></td>
<td>#artist#</td>
<td>#title#</td>
<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
</tr>
</cfoutput>
</table>
</body>
</html>
