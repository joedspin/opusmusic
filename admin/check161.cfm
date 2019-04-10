<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
</body>
</html>

<cfquery name="check161" datasource="#DSN#">
	select *
    from catItems
    where price<buy+3.20 AND shelfID=11 AND mediaID=1 AND vendorID IN (5650,6978,153)
</cfquery>
<cfoutput query="check161">
#catnum#<br />
</cfoutput>y