<!---

the undo for this sale is already written, JUST UNCOMMENT IT AND RUN ONCE 
//--->
<cfquery name="bigimportsaleUNDO" datasource="#DSN#">
	update catItems
    set price=priceSave, priceSave=0, specialItem=0
    where specialItem=1 AND priceSave<>0
</cfquery>
<cfabort>
<!---<cfquery name="bigimportsale" datasource="#DSN#">
	UPDATE catItems
    set priceSave=price, price=price*.9, specialItem=1
    where priceSave=0 AND albumStatusID IN (23,24) AND ONHAND>0 AND shelfID<>11 AND releaseDate<<cfqueryparam value="2016-04-01"> AND releaseDate>=<cfqueryparam value="2016-01-01">
</cfquery>//--->
<cfquery name="bigimportsale" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID IN (23,24) AND ONHAND>0 AND shelfID<>11 AND releaseDate<<cfqueryparam value="2016-04-01"> AND releaseDate>=<cfqueryparam value="2016-01-01">
</cfquery>

<cfoutput>#bigimportsale.recordCount#</cfoutput>
<!---<cfquery name="bigimportsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost+1
    where countryID<>1 AND ONHAND>0 AND albumStatusID<25 AND price>cost+1 AND NRECSINSET=1
</cfquery>
<cfquery name="bigimportsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost+2
    where countryID<>1 AND ONHAND>0 AND albumStatusID<25 AND price>cost+2 AND NRECSINSET>1
</cfquery>//--->
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="bigimportsale">
	<tr>
		<!---<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>//--->
        <td>#UCase(genre)#</td>
		<td>#UCase(catnum)#</td>
		<td>#UCase(label)#</td>
		<td>#UCase(artist)#</td>
		<td>#UCase(title)#</td>
        <td>#UCase(media)#</td>
        <td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
		<td align="right">#DollarFormat(price)#</td>
	</tr>
</cfoutput>
</table>
<!---<cfquery name="bigimportsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=price*.7, specialItem=1
    where priceSave=0 AND albumStatusID IN (23,24) AND ONHAND>0 AND shelfID<>11 AND releaseDate<<cfqueryparam value="2016-01-01">
</cfquery>//--->
<cfquery name="bigimportsale" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID IN (23,24) AND ONHAND>0 AND shelfID<>11 AND releaseDate<<cfqueryparam value="2016-01-01">
</cfquery>

<cfoutput>#bigimportsale.recordCount#</cfoutput>
<!---<cfquery name="bigimportsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost+1
    where countryID<>1 AND ONHAND>0 AND albumStatusID<25 AND price>cost+1 AND NRECSINSET=1
</cfquery>
<cfquery name="bigimportsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost+2
    where countryID<>1 AND ONHAND>0 AND albumStatusID<25 AND price>cost+2 AND NRECSINSET>1
</cfquery>//--->
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="bigimportsale">
	<tr>
		<!---<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>//--->
        <td>#UCase(genre)#</td>
		<td>#UCase(catnum)#</td>
		<td>#UCase(label)#</td>
		<td>#UCase(artist)#</td>
		<td>#UCase(title)#</td>
        <td>#UCase(media)#</td>
        <td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
		<td align="right">#DollarFormat(price)#</td>
	</tr>
</cfoutput>
</table>
<!---<cfquery name="bigimportsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=price*.5, specialItem=1
    where albumStatusID<25 AND ONHAND>0 AND shelfID=11 AND vendorID NOT IN (6978, 2811, 5650, 5439) AND labelID<>1586 AND price>2.99
</cfquery>//--->
<cfquery name="bigimportsale" datasource="#DSN#">
	select *
    from catItemsQuery
    where albumStatusID<25 AND ONHAND>0 AND shelfID=11 AND vendorID NOT IN (6978, 2811, 5650, 5439) AND labelID<>1586 AND price>2.99
</cfquery>

<cfoutput>#bigimportsale.recordCount#</cfoutput>
<!---<cfquery name="bigimportsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost+1
    where countryID<>1 AND ONHAND>0 AND albumStatusID<25 AND price>cost+1 AND NRECSINSET=1
</cfquery>
<cfquery name="bigimportsale" datasource="#DSN#">
	update catItems
    set priceSave=price, price=cost+2
    where countryID<>1 AND ONHAND>0 AND albumStatusID<25 AND price>cost+2 AND NRECSINSET>1
</cfquery>//--->
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="bigimportsale">
	<tr>
		<!---<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>//--->
        <td>#UCase(genre)#</td>
		<td>#UCase(catnum)#</td>
		<td>#UCase(label)#</td>
		<td>#UCase(artist)#</td>
		<td>#UCase(title)#</td>
        <td>#UCase(media)#</td>
        <td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
		<td align="right">#DollarFormat(price)#</td>
	</tr>
</cfoutput>
</table>