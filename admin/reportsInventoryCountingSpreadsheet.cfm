<cfparam name="url.shelfFilter" default="0">
<cfparam name="url.vendorFilter" default="0">
<cfparam name="url.includeImports" default="false">
<cfparam name="url.showAll" default="false">
<style>
<!--
h1 {font-family:Arial, Helvetica, sans-serif; font-size: 18px;}
td {font-family:Arial, Helvetica, sans-serif; font-size: 12px; line-height: 100%; vertical-align:top;}
//-->
</style>
<!---<cfquery name="imports" datasource="#DSN#">
	SELECT * from catItemsQuery
	where shelfCode='DT' AND albumStatusID<25 AND ONHAND>0 AND mediaID NOT IN (6,19,20,21,22,23,24)
	order by artist, title
</cfquery>
<h1>Downtown 161 - Inventory</h1>
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse;">
<cfoutput query="imports">
	<tr>
		<!---<td>#DateFormat(releaseDate,"mm/dd/yy")#</td>//--->
        <td>#UCase(artist)#</td>
		<td><a href="http://www.downtown304.com/index.cfm?sID=#ID#">#UCase(title)#</a></td>
        <td>#UCase(media)#<cfif NRECSINSET GT 1>x#NRECSINSET#</cfif></td>
		<td>#UCase(label)#</td>
        <td>#UCase(catnum)#</td>
		<td>#UCase(genre)#</td>
		<td align="right">#DollarFormat(wholesalePrice)#</td>
	</tr>
</cfoutput>
</table>//--->
<cfif url.shelfFilter NEQ "0"><cfset shelfFilterString="AND shelfID=#url.shelfFilter#"><cfelse><cfset shelfFilterString=""></cfif>
<cfif url.vendorFilter NEQ "0"><cfset vendorFilterString="AND vendorID=#url.vendorFilter#"><cfelse><cfset vendorFilterString=""></cfif>
<cfif url.includeImports><cfset importFilterString=""><cfelse><cfset importFilterString="AND (shelfID=11 OR shelfID=14 OR countryID=1)"></cfif>
<cfquery name="distro" datasource="#DSN#">
	SELECT * from catItemsQuery
	where albumStatusID<25 AND ONHAND<>0  AND shelfID NOT IN (15) #shelfFilterString# #vendorFilterString# #importFilterString#
	order by label, catnum
</cfquery>
<!--<h1>Downtown 304 - Inventory</h1>
<p><cfif url.includeImports><a href="reportsDT304DistributionInventory.cfm">Exclude Imports</a><cfelse><a href="reportsDT304DistributionInventory.cfm?includeImports=true">Include Imports</a></cfif></p>
<p>To filter by shelf, add url parameter shelfFilter=; To filter by vendor, add url parameter vendorFilter=.</p>//-->
<table border="1" bordercolor="#999999" cellpadding="3" cellspacing="0" style="border-collapse:collapse;" width="100%">
		
		<!--<tr valign="middle">
			<td class="catDisplayHead">CAT##</td>
			<td class="catDisplayHead">LABEL</td>
			<td class="catDisplayHead">ARTIST</td>
			<td class="catDisplayHead">TITL</td>
			<td align="center" class="catDisplayHead">MEDIA</td>
			<td align="center" class="catDisplayHead">PRICE</td>
			
		</tr>//-->
        <cfset rowCount=0>
	<cfoutput query="distro">
    <cfif (ONHAND LT 1 AND ONSIDE LT 1) OR albumStatusID GT 24><cfset oos='OOS'><cfelseif ONSIDE EQ 999><cfset oos='999'><cfelse><cfset oos=''></cfif>
    <cfif oos EQ "" OR url.showAll>
		<tr>
			<!---<cfset mp3Status="false">
			<cfquery name="tracks" datasource="#DSN#">
				select *
				from catTracks
				where catID=#catalogFind.ID#
			</cfquery>
			<cfif tracks.RecordCount NEQ 0>
				<cfset trackStatus="true">
				<cfloop query="tracks">
					<cfdirectory directory="d:\media" filter="oT#tracks.ID#.mp3" name="trackCheck" action="list">
					<cfif trackCheck.recordCount NEQ 0>
						<cfset mp3Status="true">
					</cfif>
				</cfloop>
			</cfif>//--->
            <cfset rowCount=rowCount+1>
			
			<td>#UCase(catnum)#</td>
			<td class="catDisplay#oos#">#UCase(label)#</td>
			<td class="catDisplay#oos#">#UCase(artist)#</td>
			<td class="catDisplay#oos#">#UCase(title)#</td>
			<td align="center" class="catDisplay#oos#"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td align="center" class="catDisplay#oos#">#Replace(DollarFormat(wholesalePrice),'$','','all')#</td>
            
            
		</tr>
        </cfif>
	</cfoutput>
	</table>
