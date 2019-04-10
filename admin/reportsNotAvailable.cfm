<cfquery name="notAvail" datasource="#DSN#" maxrows="300">
	select *
    from orderItemsQuery
    where orderItems_adminShipID<3 AND DateDiff(day,dateShipped,#varDateODBC#)<30 AND ONHAND<1
    order by catnum
</cfquery>
<style>
td {font-family: Arial, Helvetica, sans-serif; font-size: xx-small; border-color:black;}
</style>
<table border="2" cellpadding="4" cellspacing="0" style="border-collapse:collapse; border-color: black;">
<tr>
	<td>SHELF</td>
    <td>CATNUM</td>
    <td>LABEL</td>
    <td>ARTIST</td>
    <td>TITLE</td>
</tr>
<cfoutput query="notAvail">
<tr>
	<td>#shelfCode#</td>
    <td>#UCase(catnum)#</td>
    <td>#Ucase(Left(label,15))#</td>
    <td>#Ucase(Left(artist,30))#</td>
    <td>#Ucase(Left(title,25))#</td>
</tr>
</cfoutput>
</table>