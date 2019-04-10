
<cfquery name="saleUndo" datasource="#DSN#">
	update catItems
	set price=saleSave, saleSave=0 where saleSave<>0
</cfquery>


<cfabort></cfabort>


<cfquery name="importSale" datasource="#DSN#">
	select *, (cost+3)*.60 as whouse from catItemsQuery
	where mediaID=1 AND NRECSINSET=1 AND shelfID NOT IN (11,2140,1057,2147,2148,2127,1064,2080,1052,2114,2149,2105,1059,1072,1066,40) AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<table>
	<cfoutput query="importSale">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td>#DollarFormat(whouse)#</td>
		</tr>
	</cfoutput>
</table>
	<cfabort><!---<cfquery name="salePrep" datasource="#DSN#">
	update catItems
	set saleSave=price where price<>0 AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01' 
</cfquery>
<cfquery name="importSale" datasource="#DSN#">
	update catItems
	set price=(cost+3)*.60 where mediaID=1 AND NRECSINSET=1 AND shelfID NOT IN (11,2140,1057,2147,2148,2127,1064,2080,1052,2114,2149,2105,1059,1072,1066,40) AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
<cfquery name="LPSale" datasource="#DSN#">
	update catItems
	set price=(cost+3)*.50 where mediaID=5 AND shelfID NOT IN (11,2140,1057,2147,2148,2127,1064,2080,1052,2114,2149,2105,1059,1072,1066,40)  AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<cfquery name="CDSale" datasource="#DSN#">
	update catItems
	set price=(cost+3)*.40 where mediaID=2 AND shelfID NOT IN (11,2140,1057,2147,2148,2127,1064,2080,1052,2114,2149,2105,1059,1072,1066,40)  AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
		<cfquery name="sevenInchSale" datasource="#DSN#">
	update catItems
	set price=(cost+3)/2 where mediaID=11 AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
<cfquery name="161two" datasource="#DSN#">
	update catItems
	set price=2 where mediaID=1 AND NRECSINSET=1 AND shelfID=11 AND cost=0.10 AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01' 
</cfquery>
<cfquery name="whitelabels" datasource="#DSN#">
	update catItems
	set price=5 where mediaID=1 AND NRECSINSET=1 AND shelfID<>11 AND (labelID IN (796,8998,9256) OR shelfID IN (2080,1064,2131)) AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<cfquery name="PNDSale" datasource="#DSN#">
	update catItems
	set price=5 where mediaID=1 AND NRECSINSET=1 AND shelfID=14 AND  albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
		<cfabort>//--->


<cfquery name="sevenInchSale" datasource="#DSN#">
	select *, (cost+3)/2 as whouse from catItemsQuery
	where mediaID=11 AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<table>
	<cfoutput query="sevenInchSale">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td>#DollarFormat(whouse)#</td>
		</tr>
	</cfoutput>
</table>
<cfquery name="161two" datasource="#DSN#">
	select *, 2 as whouse from catItemsQuery
	where mediaID=1 AND NRECSINSET=1 AND shelfID=11 AND cost=0.10 AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<table>
	<cfoutput query="161two">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td>#DollarFormat(whouse)#</td>
		</tr>
	</cfoutput>
</table>
<cfquery name="whitelabels" datasource="#DSN#">
	select *, 5 as whouse from catItemsQuery
	where mediaID=1 AND NRECSINSET=1 AND shelfID<>11 AND (labelID IN (796,8998,9256) OR shelfID IN (2080,1064,2131)) AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<table>
	<cfoutput query="whitelabels">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td>#DollarFormat(whouse)#</td>
		</tr>
	</cfoutput>
</table>
<cfquery name="importSale" datasource="#DSN#">
	select *, (cost+3)*.60 as whouse from catItemsQuery
	where mediaID=1 AND NRECSINSET=1 AND shelfID NOT IN (11,2140,1057,2147,2148,2127,1064,2080,1052,2114,2149,2105,1059,1072,1066,40) AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<table>
	<cfoutput query="importSale">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td>#DollarFormat(whouse)#</td>
		</tr>
	</cfoutput>
</table>
<cfquery name="LPSale" datasource="#DSN#">
	select *, (cost+3)*.50 as whouse from catItemsQuery
	where mediaID=5 AND shelfID NOT IN (11,2140,1057,2147,2148,2127,1064,2080,1052,2114,2149,2105,1059,1072,1066,40)  AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<table>
	<cfoutput query="LPSale">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td>#DollarFormat(whouse)#</td>
		</tr>
	</cfoutput>
</table>
	<cfquery name="CDSale" datasource="#DSN#">
	select *, (cost+3)*.40 as whouse from catItemsQuery
		where mediaID=2 AND shelfID NOT IN (11,2140,1057,2147,2148,2127,1064,2080,1052,2114,2149,2105,1059,1072,1066,40)  AND albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<table>
	<cfoutput query="CDSale">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td>#DollarFormat(whouse)#</td>
		</tr>
	</cfoutput>
</table>
	<cfquery name="PNDSale" datasource="#DSN#">
	select *, 5 as whouse from catItemsQuery 
		where mediaID=1 AND NRECSINSET=1 AND shelfID=14 AND  albumStatusID<25 AND ONHAND>0 AND releaseDate<'2018-09-01'
</cfquery>
	<table>
	<cfoutput query="PNDSale">
		<tr>
			<td>#catnum#</td>
			<td>#label#</td>
			<td>#artist#</td>
			<td>#title#</td>
			<td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td>#DollarFormat(whouse)#</td>
		</tr>
	</cfoutput>
</table>