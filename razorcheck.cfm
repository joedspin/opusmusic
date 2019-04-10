<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<cfquery name="razorZP" datasource="#DSN#">
	update catItems
    set shelfID=3, price=0
    where labelID=8492 AND price<0
</cfquery>
<cfquery name="razor" datasource="#DSN#">
	select *
    from catItemsQuery
    where labelID=8492 AND ONHAND>0 AND ONSIDE<>999 AND discogsID>0
</cfquery>
<cfoutput query="razor">#title#<br /></cfoutput>
<body>
</body>
</html>
