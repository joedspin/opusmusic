<cfparam name="form.vendorID" default="0">
<cfparam name="url.vendorID" default="0">
<cfparam name="url.nozeroes" default="false">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 . George T. Inventory</title>
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size:small;}
//-->
</style>
</head>

<body>


<cfquery name="inven" datasource="#DSN#">
	select *
    from catItemsQuery
    where (vendorID=5439 OR shelfCode='GT' OR shelfCode='GG')
    	AND albumStatusID<25 AND ONHAND>0
   	order by catnum
</cfquery><!---order by label, catnum//--->
<table border='1' cellpadding='3' cellspacing='0' style="border-collapse:collapse;">
<tr>
    	<!---<td>VND</td>//--->
        <!---<td>LABEL</td>//--->
    	<td>CATNUM</td>
        <td>ARTIST</td>
        <td>TITLE</td>
        <td>MEDIA</td>
        <!---<td>REL DATE</td>
        <td>ONHAND</td>//--->
     </tr>
<cfoutput query="inven">
	<tr>
    	<!---<td>#shelfCode#</td>//--->
        <!---<td>#label#</td>//--->
    	<td>#catnum#</td>
        <td>#artist#</td>
        <td>#title#</td>
        <td><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
        <!---<td>#DateFormat(releaseDate,"yyyy-mm-dd")#</td>
        <td align="center">#ONHAND#</td>//--->
     </tr>
</cfoutput>
</table>
</body>
</html>
