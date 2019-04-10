<cfquery name="lovestuff" datasource="#DSN#">
	select *
    from catItemsQuery
    where (genreID=23 OR mediaID=20) AND title NOT LIKE '%Shirt%' AND artist NOT LIKE '%shirt%' AND left(shelfCode,1)<>'D'
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<table>
<cfoutput query="lovestuff">
<tr>
	<td>#label#</td>
    <td>#catnum#</td>
    <td>#artist#</td>
    <td>#title#</td>
    <td>#DollarFormat(price)#</td>
    <td>#DollarFormat(cost)#</td>
</tr>
</cfoutput>
</table>
</body>
</html>
