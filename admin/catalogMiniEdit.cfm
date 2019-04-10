<cfset pageName="CATALOG">
<cfparam name="url.addOS" default="0">
<cfparam name="url.ID" default="0">
<cfparam name="url.dtID" default="0">
<cfparam name="url.addtrx" default="0">
<cfparam name="url.dup" default="no">
<cfparam name="url.artists" default="showFew">
<cfparam name="url.labels" default="showFew">
<cfparam name="url.showhist" default="true">
<cfparam name="url.pageBack" default="catalog.cfm">

<!---<cfif url.dtID NEQ 0>
<cfquery name="thisItem" datasource="#DSN#">
	select catItems.*, artists.name AS artist, labels.name AS label, labels.sort AS labelsort, shelf.code as shelfCode
	from (((catItems LEFT JOIN artists ON catItems.artistID=artists.ID) LEFT JOIN labels ON catItems.labelID=labels.ID) LEFT JOIN shelf ON catItems.shelfID=shelf.ID)
	where dtID=#url.dtID#
</cfquery>
<cfelse>
<cfquery name="thisItem" datasource="#DSN#">
	select catItems.*, artists.name AS artist, labels.name AS label, labels.sort AS labelsort, shelf.code as shelfCode
	from (((catItems LEFT JOIN artists ON catItems.artistID=artists.ID) LEFT JOIN labels ON catItems.labelID=labels.ID) LEFT JOIN shelf ON catItems.shelfID=shelf.ID)
	where catItems.ID=#url.ID#
</cfquery>
</cfif>//--->
<cfif url.dtID NEQ 0>
<cfquery name="thisItem" datasource="#DSN#">
	select *
    from catItemsQuery
	where dtID=#url.dtID#
</cfquery>
<cfelse>
<cfquery name="thisItem" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID=#url.ID#
</cfquery>
</cfif>
<cfif thisItem.recordCount EQ 0>NOT FOUND<cfabort></cfif>
<cfif url.artists EQ "showAll">
	<cfquery name="artists" datasource="#DSN#">
		select ID, name
		from artists
		order by name
	</cfquery>
<cfelse>
	<cfquery name="artists" datasource="#DSN#">
		select ID, name
		from artists
		where Left(name,1)='#Left(thisItem.artist,"1")#'
		order by name
	</cfquery>
</cfif>
<cfif url.labels EQ "showAll">
	<cfquery name="labels" datasource="#DSN#">
		select ID, name
		from labels
		order by sort
	</cfquery>
<cfelse>
	<cfif Left(thisItem.labelSort,1) EQ "">
		<cfset thisLetter=Left(thisItem.label,1)>
	<cfelse>
		<cfset thisLetter=Left(thisItem.labelSort,1)>
	</cfif>
	<cfquery name="labels" datasource="#DSN#">
		select ID, name
		from labels
		where Left(sort,1)='#thisLetter#' OR (sort='' OR sort Is Null AND Left(name,1)='#thisLetter#')
		order by sort
	</cfquery>
</cfif>
<cfquery name="backendCountries" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select ID, name
	from country
	order by name
</cfquery>
<cfquery name="backendGenres" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select ID, name
	from genres
	order by name
</cfquery>
<cfquery name="backendMediaTypes" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select ID, name
	from media
	order by name
</cfquery>
<!---<cfquery name="backendShelfs" datasource="#DSN#">
	select *
	from shelf
	order by code
</cfquery>
<cfquery name="backendCondition" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select ID, condition
	from condition
	order by ID
</cfquery>
<cfquery name="backendAlbumStatuses" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select *
	from DTAlbumStatus
</cfquery>//--->
<cfquery name="tracks" datasource="#DSN#">
	select *
	from catTracks
	where catID=#thisItem.ID#
	order by tSort
</cfquery>
<html>
<head>
<title>Downtown 304 Mini Editor</title>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%">
<td valign="top" align="left">
<cfif url.dup><h1><b><font color="yellow">DUPLICATE</font></b></h1></cfif>
<cfform name="catEditForm" action="catalogMiniEditAction.cfm" method="post">
<cfoutput query="thisItem">
	<table border="0" cellpadding="10" cellspacing="0"><tr><td bgcolor="##999999">
		<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="##CCCCCC">
      <!---<tr>
        <td align="center" bgcolor="##000000" style="color:##CC3300; font-size:medium; padding:5px;"><span style="color:##FFFFFF; font-size:medium; padding:5px;"><b>#ID#</b></span></td>
        <td bgcolor="##000000" colspan="3"><table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%"><tr>
			<td style="padding: 5px;"><font color="##FFCC33" style="font-size:small;"><b><cfif albumStatusID LT 25 AND (ONHAND+ONSIDE GT 0)>IN-STOCK<cfelseif (albumStatusID GTE 21 AND albumStatusID LTE 24) AND (ONHAND+ONSIDE EQ 0)>NO INVENTORY<cfelseif albumStatusID EQ 148>PRE-RELEASE<cfelse>OUT OF STOCK</cfif></b></font></td>
			<td align="right" class="dataLabel">Put on the side: <input type="text" size="5" name="addONSIDE" value="0" style="text-align: center; padding: 0;"/> &nbsp;&nbsp;&nbsp; Active&nbsp;<cfinput type="checkbox" name="active" value="Yes" checked="#YesNoFormat(thisItem.active)#"></td></tr></table></td>
        </tr>//--->
      <tr>
	  	<td bgcolor="##000000"><table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%"><tr><td align="left" class="dataLabel">Artist</td>
        <td align="right" class="dataLabel"><a href="catalogEdit.cfm?ID=#thisItem.ID#&artists=showAll">Show All</a></td></tr></table></td>
        <td bgcolor="##FFFFFF" colspan="3" valign="middle"><cfselect query="artists" name="artistID" value="ID" display="name" selected="#thisItem.artistID#" class="inputBox">
					<option value="0"<cfif thisItem.artistID EQ "0"> selected</cfif>>Choose an artist...</option>
					<!---<option value="0">Add a New Artist</option> //--->
				</cfselect>
				<a href="listsArtistsEdit.cfm?ID=#thisItem.artistID#&editItem=#ID#" style="color:##000099;">EDIT</a></td>
			</tr>
			<tr>
				<td class="dataLabel">Title</td>
				<td bgcolor="##FFFFFF" colspan="3" nowrap="nowrap" style="color:##000000; vertical-align:middle;"><cfinput type="text" name="itemTitle" message="RELEASE TITLE is required" required="yes" class="inputBox" value="#thisItem.title#" size="80" maxlength="255"></td>
				</tr>
			<!---<tr>
				<td class="dataLabel">Comment</td>
				<td bgcolor="##FFFFFF" colspan="3"><cfinput type="text" name="comment" maxlength="150" size="75" class="inputBox" value="#thisItem.comment#"></td>
			</tr>//--->
            <tr><td bgcolor="##000000"><table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%"><tr><td align="left" class="dataLabel">Label</td>
			<td align="right" class="dataLabel"><a href="catalogEdit.cfm?ID=#thisItem.ID#&labels=showAll">Show All</a></td></tr></table></td>
			  <td bgcolor="##FFFFFF" colspan="3"><cfselect query="labels" name="labelID" value="ID" display="name" selected="#thisItem.labelID#" class="inputBox"></cfselect>
			<a href="listsLabelsEdit.cfm?ID=#thisItem.labelID#&editItem=#ID#" style="color:##000099;">EDIT</a></td>
          </tr>
			<tr>
				<td class="dataLabel">Catalog ##</td>
				<td bgcolor="##FFFFFF"><cfinput type="text" name="catnum" maxlength="30" size="25" class="inputBox" required="yes" message="CATALOG ## is required" value="#thisItem.catnum#"></td>
            	<td class="dataLabel">Media</td>
				<td bgcolor="##FFFFFF"><cfinput type="text" name="NRECSINSET" class="inputBox" value="#thisItem.NRECSINSET#" size="3" maxlength="2">
				<cfselect query="backendMediaTypes" name="mediaID" value="ID" display="name" selected="#thisItem.mediaID#"></cfselect></td>
          </tr>
		  <tr>
		  	<td class="dataLabel">Country</td>
			<td bgcolor="##FFFFFF"><cfselect query="backendCountries" name="countryID" value="ID" display="name" selected="#thisItem.countryID#" class="inputBox"></cfselect></td>
			<td class="dataLabel">Genre</td>
			<td bgcolor="##FFFFFF"><cfselect query="backendGenres" name="genreID" value="ID" display="name" selected="#thisItem.genreID#" class="inputBox">
				<option value="0"<cfif thisItem.genreID EQ 0> selected="yes"</cfif>>Choose a genre...</option>
			</cfselect></td>
		</tr>
		
          <tr>
            <td class="dataLabel">Release Date / DT Date Updated <cfinput type="checkbox" name="releaseDateLock" id="releaseDateLock" value="Yes" checked="#YesNoFormat(thisItem.releaseDateLock)#" /></td>
			<td bgcolor="##FFFFFF"><cfinput type="text" name="releaseDate" maxlength="10" size="10" class="inputBox" value="#DateFormat(thisItem.releaseDate,"mm/dd/yyyy")#"><cfinput type="text" name="releaseYear" maxlength="10" size="10" class="inputBox" value="#DateFormat(DTdateUpdated,"mm/dd/yyyy")#"></td>            
            <td class="dataLabel"><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">Discogs</a> ID</td>
			<td bgcolor="##FFFFFF" style="color:##000000;"><cfinput type="text" name="discogsID" maxlength="10" size="10" class="inputBox" value="#discogsID#" required="yes" message="Discogs ID is required, if not known, put 0"> <cfinput type="checkbox" name="reissue" value="Yes" checked="#YesNoFormat(thisItem.reissue)#"> Reissue</td>
	   </tr>

	<cfset tCt=0>
	<cfif tracks.recordCount+url.addtrx GT 0>
	<tr>
		<td valign="top" class="dataLabel" style="padding-top: 5px;"><p>Tracks</p></td>
		<td colspan="3" bgcolor="##FFFFFF">
    <!---</table>
		<h2 style="margin-top: 5px; margin-bottom: 5px; color:##000000;">Tracks</h2>//--->
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
		
		<cfloop query="tracks">
			<cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
			<cfset tCt=tCt+1>
			<tr>
				<td><cfinput type="text" name="tSort#tCt#" class="inputBox" style="text-align:center" value="#tSort#" size="2" maxlength="2" align="center"></td>
				<td><cfinput type="text" name="tName#tCt#" class="inputBox" value="#tName#" size="75" maxlength="100">
				<input type="hidden" name="tID#tCt#" value="#tracks.ID#" />
				
				<!---<cfdirectory directory="d:\media" filter="oT#trID#.mp3" name="trackCheck" action="list">
					<cfif trackCheck.recordCount GT 0>//--->
                    
						<cfif tracks.mp3Loaded OR mp3Alt NEQ 0><a href="#webPath#/media/oT#trID#.mp3"><img src="images/speaker.gif" width="16" height="14" border="0"></a></cfif></td>
			</tr>
		</cfloop>
		<cfif url.addtrx GT 0>
		<cfloop from="1" to="#url.addtrx#" index="x">
			<cfset tCt=tCt+1>
			<tr>
				<td><cfinput type="text" name="tSort#tCt#" class="inputBox" style="text-align:center" value="#tCt#" size="2" maxlength="2" align="center"></td>
				<td><cfinput type="text" name="tName#tCt#" class="inputBox" size="75" maxlength="100">
				<input type="hidden" name="tID#tCt#" value="0" /></td>
			</tr>
		</cfloop>
		</cfif>
	</table>	</td>
	</tr>
	</cfif>
	<tr>
		<td height="75" class="dataLabel" style="vertical-align:middle; text-align:center;" background="../images/items/oI#thisItem.ID#.jpg" style="background-repeat:no-repeat"><!---<cfdirectory directory="#serverPath#\images\items" filter="oI#thisItem.ID#.jpg" name="artCheck" action="list">
		<cfif artCheck.recordCount GT 0>//--->
			<img src="images/spacer.gif" width="75" height="75" border="0"><!---<cfelse>NO IMAGE</cfif>//---></td>
		<td colspan="3" bgcolor="##000000" style="vertical-align:middle; text-align:center;">
		<p style="margin-top: 8px; margin-bottom: 8px;"><input type="submit" name="done" tabindex=1 value=" Done " />&nbsp;
		<font color="##FFFFFF">Add Tracks:</font> 
		<input type="text" name="addtrx" size="4" maxlength="2" style="text-align:center" tabindex=2/> <input type="submit" name="submit" tabindex=3 value=" SAVE " />
		<input type="hidden" name="ID" value="#thisItem.ID#" /><input type="hidden" name="tCt" value="#tCt#" /></p></td>
		</tr></table></td></tr>
<!---</cfif>//--->
		</table>
		</td></tr>
		
		</table>
    
	</cfoutput>
	</cfform>
</td>

</tr>
</table>
</body>
</html>