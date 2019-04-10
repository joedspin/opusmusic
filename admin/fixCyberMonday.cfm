<cfquery name="undoCyber" datasource="#DSN#">
	update catItems
	set price=priceSave, specialItem=0, priceSave=0
	where specialItem=1 and priceSave>0
</cfquery>
<cfquery name="undoCyber" datasource="#DSN#">
	update catItems
	set priceSave=0
	where priceSave<=price
</cfquery>
<cfabort><!---//--->
	
	
	
	
<!--- $1.99 select DT161 items //--->
<cfquery name="fixCyber1" datasource="#DSN#">
	update catItems
	set priceSave=price, price=1.99, specialItem=1	where ONHAND>0 AND albumStatusID<25 AND shelfID=11 AND mediaID IN (1,9) AND cost<2 AND price>1.99
</cfquery>
<!--- 50% off DT304 12" imports //--->
<cfquery name="fixCyber2" datasource="#DSN#">
	update catItems
	set priceSave=price, price=price*.5, specialItem=1
	where ONHAND>0 AND albumStatusID=24 AND shelfID NOT IN (11,2127,2136,2132,2130,2121,1072) AND mediaID IN (1,9) AND countryID<>1 AND specialItem=0
</cfquery>
<!--- 50% off CDs and 7" //--->
<cfquery name="fixCyber3" datasource="#DSN#">
	update catItems
	set priceSave=price, price=price*.5, specialItem=1
	where ONHAND>0 AND albumStatusID=24 AND shelfID NOT IN (2127,2136,2132,2130,2121,1072) AND mediaID IN (2,11) AND specialItem=0
</cfquery>
	<!--- 35% off LPs //--->
<cfquery name="fixCyber4" datasource="#DSN#">
	update catItems
	set priceSave=price, price=price*.65, specialItem=1
	where ONHAND>0 AND albumStatusID=24 AND shelfID NOT IN (2127,2136,2132,2130,2121,1072) AND mediaID IN (5,12) AND specialItem=0
</cfquery>
	<cfabort>
<cfquery name="fixCyber1" datasource="#DSN#">y
	select * from catItemsQuery
	where ONHAND>0 AND albumStatusID<25 AND shelfID=11 AND mediaID IN (1,9) AND cost<2 AND price>1.99
</cfquery>
<p>$1.99 Select DT161 items</p>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="fixCyber1">
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
		<td align="right">$1.99</td>
	</tr>
</cfoutput>
</table>
<!--- 30% off DT304 12" imports except CDs and 7" //--->
<cfquery name="fixCyber2" datasource="#DSN#">
	select * from catItemsQuery
	where ONHAND>0 AND albumStatusID<25 AND shelfID NOT IN (11,2127,2136,2132,2130,2121,1072) AND mediaID IN (1,9) AND countryID<>1
</cfquery>
<p>30% Off DT304 12" imports</p>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="fixCyber2">
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
		<td align="right">#DollarFormat(price*.7)#</td>
	</tr>
</cfoutput>
</table>
<!--- 40% off CDs and 7" //--->
<cfquery name="fixCyber3" datasource="#DSN#">
	select * from catItemsQuery
	where ONHAND>0 AND albumStatusID<25 AND shelfID NOT IN (2127,2136,2132,2130,2121,1072) AND mediaID IN (2,11)
</cfquery>
<p>40% Off CDs and 7"<p>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="fixCyber3">
	<tr>
        <td>#UCase(genre)#</td>
		<td>#UCase(catnum)#</td>
		<td>#UCase(label)#</td>
		<td>#UCase(artist)#</td>
		<td>#UCase(title)#</td>
        <td>#UCase(media)#</td>
        <td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
		<td align="right">#DollarFormat(price)#</td>
		<td align="right">#DollarFormat(price*.6)#</td>
	</tr>
</cfoutput>
</table>
<!--- 25% off LPs //--->
<cfquery name="fixCyber4" datasource="#DSN#">
	select * from catItemsQuery
	where ONHAND>0 AND albumStatusID<25 AND shelfID NOT IN (2127,2136,2132,2130,2121,1072) AND mediaID IN (5,12)
</cfquery>
	<p>25% Off LPs<p>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="fixCyber4">
	<tr>
        <td>#UCase(genre)#</td>
		<td>#UCase(catnum)#</td>
		<td>#UCase(label)#</td>
		<td>#UCase(artist)#</td>
		<td>#UCase(title)#</td>
        <td>#UCase(media)#</td>
        <td><cfif reissue>REISSUE<cfelse>&nbsp;</cfif></td>
		<td align="right">#DollarFormat(price)#</td>
		<td align="right">#DollarFormat(price*.75)#</td>
	</tr>
</cfoutput>
</table>