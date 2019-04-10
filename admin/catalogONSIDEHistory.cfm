<cfparam name="url.ID" default="0">
<cfquery name="thisCatItem" datasource="#DSN#">
	select artist, title, label, catnum, media, NRECSINSET
    from catItemsQuery
    where ID=#url.ID#
</cfquery>
<cfif thisCatItem.recordCount EQ 0>Not Found<cfabort></cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 . Buy History</title>
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size:x-small;}
//-->
</style>
</head>

<body>
<h1>Downtown 304 . ONSIDE History</h1>
<cfoutput query="thisCatItem"><h2>#artist#<br />
#title#</h2>
<h3>#catnum# [#label#] <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#Left(media,4)#</cfoutput>
<cfquery name="catRcvd" datasource="#DSN#">
	select *
    from ((catRcvd LEFT JOIN shelf ON shelf.ID=catRcvd.rcvdShelfID) LEFT JOIN wagamamaUsersHHG ON wagamamaUsersHHG.ID=catRcvd.rcvdUserID) where 
    catItemID=#url.ID# AND (rcvdShelfID=7 OR left(code,1)='D')
    order by dateReceived
</cfquery>
<cfif catRcvd.recordCount GT 0>
<table border='1' cellpadding='2' cellspacing='0' style="border-collapse:collapse;">
<cfoutput query="catRcvd">
	<tr>
    	<td>#qtyRcvd#</td>
        <td>#username#</td>
        <td>#DateFormat(dateReceived,"mm/dd/yyyy")#</td>
     </tr>
</cfoutput>
</table>
<cfelse>
	<p>No ONSIDE History on record (ONSIDE history starts 10/23/2007)</p>
</cfif>
</body>
</html>
