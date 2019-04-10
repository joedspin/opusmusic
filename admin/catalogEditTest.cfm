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
<cfif url.addOS NEQ 0>
	<cfquery name="addOS" datasource="#DSN#">
    	update catItems
        set ONSIDE=ONSIDE+#url.addOS#
        where ID=#url.ID#
    </cfquery>
</cfif>
<cfinclude template="pageHead.cfm">
<cfif url.dtID NEQ 0>
<cfquery name="thisItem" datasource="#DSN#">
	select catItems.*, artists.name AS artist, labels.name AS label
	from ((catItems LEFT JOIN artists ON catItems.artistID=artists.ID) LEFT JOIN labels ON catItems.labelID=labels.ID)
	where dtID=#url.dtID#
</cfquery>
<cfelse>
<cfquery name="thisItem" datasource="#DSN#">
	select catItems.*, artists.name AS artist, labels.name AS label, labels.sort AS labelsort, shelf.code as shelfCode
	from (((catItems LEFT JOIN artists ON catItems.artistID=artists.ID) LEFT JOIN labels ON catItems.labelID=labels.ID) LEFT JOIN shelf ON catItems.shelfID=shelf.ID)
	where catItems.ID=#url.ID#
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
<cfquery name="backendShelfs" datasource="#DSN#">
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
</cfquery>
<cfquery name="tracks" datasource="#DSN#">
	select *
	from catTracks
	where catID=#thisItem.ID#
	order by tSort
</cfquery>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%">
<td valign="top" align="left">
<cfif url.dup><h1><b><font color="yellow">DUPLICATE</font></b></h1></cfif>
<cfform name="catEditForm" action="catalogEditAction.cfm" method="post">
<cfoutput query="thisItem">
	<table border="0" cellpadding="10" cellspacing="0"><tr><td bgcolor="##999999">
		<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="##CCCCCC">
      <tr>
        <td align="center" bgcolor="##000000" style="color:##CC3300; font-size:medium; padding:5px;"><span style="color:##FFFFFF; font-size:medium; padding:5px;"><b>#ID#</b></span></td>
        <td bgcolor="##000000" colspan="3"><table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%"><tr>
			<td style="padding: 5px;"><font color="##FFCC33" style="font-size:small;"><b><cfif albumStatusID LT 25 AND (ONHAND+ONSIDE GT 0)>IN-STOCK<cfelseif (albumStatusID GTE 21 AND albumStatusID LTE 24) AND (ONHAND+ONSIDE EQ 0)>NO INVENTORY<cfelseif albumStatusID EQ 148>PRE-RELEASE<cfelse>OUT OF STOCK</cfif></b></font></td>
			<td align="right" class="dataLabel">Put on the side: <input type="text" size="5" name="addONSIDE" value="0" style="text-align: center; padding: 0;"/> &nbsp;&nbsp;&nbsp; Active&nbsp;<cfinput type="checkbox" name="active" value="Yes" checked="#YesNoFormat(thisItem.active)#"></td></tr></table></td>
        </tr>
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
		  	<td class="dataLabel">DT ID / Status</td>
			<td bgcolor="##FFFFFF"><cfinput type="text" name="dtID" class="inputBox" value="#thisItem.dtID#" size="10" maxlength="10"><cfselect name="albumStatusID" query="backendAlbumStatuses" value="ID" display="album_Status_Name" selected="#albumStatusID#" class="inputBox"></cfselect></td>
			<td class="dataLabel">Genre</td>
			<td bgcolor="##FFFFFF"><cfselect query="backendGenres" name="genreID" value="ID" display="name" selected="#thisItem.genreID#" class="inputBox">
				<option value="0"<cfif thisItem.genreID EQ 0> selected="yes"</cfif>>Choose a genre...</option>
			</cfselect></td>
		</tr>
		<tr>
			<td class="dataLabel">Price / Cost</td>
         	<td bgcolor="##FFFFFF"><cfinput type="text" name="price" message="PRICE is required" validate="float" required="yes" class="inputBox" value="#DollarFormat(thisItem.price)#" size="10" maxlength="10"><cfinput type="text" name="cost" class="inputBox" value="#DollarFormat(thisItem.cost)#" size="10" maxlength="10"></td>
			<td class="dataLabel">Shelf / Country</td>
			<td bgcolor="##FFFFFF"><cfselect query="backendShelfs" name="shelfID" value="ID" display="code" selected="#thisItem.shelfID#" class="inputBox"></cfselect><cfselect query="backendCountries" name="countryID" value="ID" display="name" selected="#thisItem.countryID#" class="inputBox"></cfselect></td>
		</tr>
	   <tr>
          	<td class="dataLabel">On Hand / On Side</td>
			<td bgcolor="##FFFFFF"><cfif shelfID EQ 7 OR shelfID EQ 11><cfinput type="text" name="ONHAND" message="## ON HAND is required" required="yes" class="inputBox" value="#thisItem.ONHAND#" size="10" maxlength="10"><cfelse><cfinput type="text" name="ONHAND" message="## ON HAND is required" required="yes" class="inputBox" value="#thisItem.ONHAND#" size="10" maxlength="10" readonly></cfif><cfinput type="text" name="ONSIDE" required="no" class="inputBox" value="#thisItem.ONSIDE#" size="10" maxlength="10" readonly></td>
			<td class="dataLabel">Hide Tracks / No Reorder / Special</td>
			<td bgcolor="##FFFFFF" style="color:##000000;"><!---<cfselect name="CONDITION_MEDIA_ID" query="backendCondition" value="ID" display="condition" selected="#CONDITION_MEDIA_ID#" class="inputBox"></cfselect><cfselect name="CONDITION_COVER_ID" query="backendCondition" value="ID" display="condition" selected="#CONDITION_COVER_ID#" class="inputBox"></cfselect>//--->
			  <cfinput type="checkbox" name="hideTracks" id="hideTracks" value="Yes" checked="#YesNoFormat(thisItem.hideTracks)#" /><cfinput type="checkbox" name="noReorder" id="noReorder" value="Yes" checked="#YesNoFormat(thisItem.noReorder)#" /><cfinput type="checkbox" name="specialItem" id="specialItem" value="Yes" checked="#YesNoFormat(thisItem.specialItem)#" /></td>
		</tr>
          <tr>
            <td class="dataLabel">Release Date / DT Date Updated <cfinput type="checkbox" name="releaseDateLock" id="releaseDateLock" value="Yes" checked="#YesNoFormat(thisItem.releaseDateLock)#" /></td>
			<td bgcolor="##FFFFFF"><cfinput type="text" name="releaseDate" maxlength="10" size="10" class="inputBox" value="#DateFormat(thisItem.releaseDate,"mm/dd/yyyy")#"><cfinput type="text" name="releaseYear" maxlength="10" size="10" class="inputBox" value="#DateFormat(DTdateUpdated,"mm/dd/yyyy")#"></td>
			<td class="dataLabel">Weight Exception</td>
        	<td bgcolor="##FFFFFF" style="color:##000000;"><cfinput type="text" name="weightException" class="inputBox" value="#thisItem.weightException#" size="3" maxlength="3">
              <cfinput type="checkbox" name="reissue" value="Yes" checked="#YesNoFormat(thisItem.reissue)#">
Reissue</td>
	   </tr>
       <tr>
            <td class="dataLabel">Blue Date - 99&cent;<cfinput type="checkbox" name="blue99" value="yes" checked="#YesNoFormat(blue99)#" > / Discogs ID</td>
			<td bgcolor="##FFFFFF"><cfinput type="text" name="blueDate" maxlength="10" size="10" class="inputBox" value="#DateFormat(thisItem.blueDate,"mm/dd/yyyy")#"><cfinput type="text" name="discogsID" maxlength="10" size="10" class="inputBox" value="#discogsID#" required="yes" message="Discogs ID is required, if not known, put 0"></td>
			<td class="dataLabel">DT161 Sell Price</td>
        	<td bgcolor="##FFFFFF" style="color:##000000;"><cfinput type="text" name="buy" message="DT161 Sell Price is required" validate="float" required="yes" class="inputBox" value="#DollarFormat(thisItem.buy)#" size="10" maxlength="10"></td>
	   </tr>
			<tr>
				<td class="dataLabel">Item Description<br />(for Merchandise only)</td>
				<td bgcolor="##FFFFFF" colspan="3"><textarea name="description" cols="90" rows="6" class="inputBox">#descrip#</textarea></td>
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
		<input type="submit" name="dup" tabindex=4 value=" Duplicate " />
		<input type="submit" name="promo" tabindex=5 value=" Promo " />
		<input type="submit" name="deleteItem" tabindex=6 value=" DELETE " />
		<input type="hidden" name="pageBack" value="#url.pageBack#" />
		<input type="hidden" name="ID" value="#thisItem.ID#" /><input type="hidden" name="tCt" value="#tCt#" /></p>
		<p style="margin-top: 8px; margin-bottom: 8px;"><input type="submit" name="loadTracks" value=" Load MP3s " tabindex="9" />
		  <input type="submit" name="loadArt" value=" Load Art " tabindex="21" />
		  <input name="fixTitleCase" type="submit" id="fixTitleCase" tabindex="22" value=" Fix Title Case " />
		  <input name="calcPrice" type="submit" id="calcPrice" tabindex="23" value=" Calculate Price " />
		</p></td>
		</tr>
	
	  <td height="50" colspan="4" align="center" bgcolor="##003366">
	    <p>RECEIVE: 
	      <input name="addONHAND" type="text" value="0" size="3" maxlength="4" style="text-align: center; padding: 0;" /> <input type="checkbox" name="sendBackorder" value="yes"  /> BO
          <cfquery name="vendors" dbtype="query">
          	select *
            from backendShelfs
            where isVendor=1
            order by partner
          </cfquery>
          <cfquery name="storeCusts" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
          	select *
            from custAccounts
            where isStore=1
            order by username
          </cfquery>
	      Vendor: <cfselect query="vendors" name="addONHANDshelfID" value="ID" display="partner" class="inputBox"selected="#thisItem.shelfID#"></cfselect>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;ADD TO P.O.: <cfselect query="vendors" name="addONORDERshelfID" value="ID" display="partner" class="inputBox" selected="#thisItem.shelfID#"></cfselect> 
	      <input name="ONORDER" type="text" size="3" maxlength="4" style="text-align: center; padding: 0;" value="0" /> for <cfselect query="storeCusts" name="ONORDERcustID" value="ID" display="username" class="inputBox"><option value="0" selected>downtown304</option></cfselect></td>
	  </tr>
<cfquery name="onPurchOrder" datasource="#DSN#">
	select *
    from purchaseOrderDetailsQuery
    where catItemID=#url.ID# <!---AND completed=0 AND qtyRequested>qtyReceived//--->
    order by dateRequested DESC
</cfquery>
<cfif onPurchOrder.recordCount GT 0>
	
    <tr>
    	<td colspan="4" bgcolor="##9999CC">
        <table cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;" align="right">
        <tr><td><p style="margin-top: 4px; margin-bottom: 3px; font-size: small; color:black;"><b>On Purchase Order:</b></p></td>
    </tr>
    <cfset poCt=0>
    <cfloop query="onPurchOrder">
    	<cfset poCt=poCt+1>
    	<tr>
            <cfif completed NEQ 1><td bgcolor="##000000"><cfelseif qtyReceived LT qtyRequested><td bgcolor="##999966"><cfelse><td bgcolor="##999999"></cfif>&nbsp;&nbsp;Requested <input type="text" name="onPurchOrder#poCt#" value="#qtyRequested#" size="2" readonly style="text-align:center;" /> &nbsp;Received <input type="text" name="onPurchOrderR#poCt#" value="#qtyReceived#" size="2" readonly style="text-align:center;" /><input type="text" name="onPurchOrderDate#poCt#" value="#DateFormat(dateRequested,"mmm d, yyyy")#" size="20" readonly /><!---<input type="text" name="onPurchOrderUser#poCt#" value="#requestedUser#" size="20" readonly />//---><input type="text" name="onPurchOrderVendor#poCt#" value="#partner#" size="15" readonly /><input type="text" name="onPurchOrderCust#poCt#" value="#username#" size="15" readonly /><cfif completed EQ 0 OR qtyReceived LT qtyRequested><cfif completed NEQ 1> <a href="poRowComplete.cfm?ID=#POItem_ID#&itemID=#url.ID#">Complete</a></cfif> &nbsp;<a href="poRowDelete.cfm?ID=#POItem_ID#&itemID=#url.ID#" title="Delete"><font color="red">X</font></a></cfif>&nbsp;&nbsp;</td>
        </tr>
    </cfloop>
    </table></td></tr>
</cfif>
		</table>
		</td></tr>
		
		</table>
    <p><a href="catalogBuyHistory.cfm?ID=#url.ID#">Buy History</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="catalogONSIDEHistory.cfm?ID=#url.ID#">ONSIDE History</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfif left(shelfCode,1) NEQ 'D'><a href="catalogBS.cfm?ID=#ID#">BS</a></cfif> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="catalogAdd.cfm">ADD</a></p>
	</cfoutput>
	</cfform>
</td>
<td width="20">&nbsp;</td>
<td valign="top">
<cfif url.showhist>
<cfquery name="sellHistoryItem" datasource="#DSN#">
	select firstName, lastName, email, qtyOrdered, catItemID, adminAvailID, statusID, dateStarted, dateUpdated, datePurchased, orderID, ignoreSales
    from orderItemsQuery 
    where catItemID=#thisItem.ID# AND ((adminAvailID IN (0,2) AND statusID<>7 AND dateDiff(day,dateUpdated,getDate())<90) OR adminAvailID NOT IN (0,2)) 
</cfquery>
<cfquery name="sellHistory" dbtype="query">
	select *
	from sellHistoryItem
	where adminAvailID=6 AND statusID<>7 AND ignoreSales=0
	order by datePurchased DESC
</cfquery>
<h1>Sell History</h1>
<cfif sellHistory.recordCount GT 0>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
		<cfoutput query="sellHistory">
			<tr>
				<td width="60"><a href="ordersEdit.cfm?ID=#orderID#">#DateFormat(datePurchased,"yyyy-mm-dd")#</a></td>
				<td>#firstName# #lastName#</td>
				<td align="center" width="20">#qtyOrdered#</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total:</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
<cfelse>
<p>None</p>
</cfif>

<cfquery name="sellHistory" dbtype="query">
	select *
	from sellHistoryItem
	where adminAvailID=6 AND statusID<>7 AND ignoreSales=1
	order by datePurchased DESC
</cfquery>
<h1>Return AND 161 Sell History</h1>
<cfif sellHistory.recordCount GT 0>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
		<cfoutput query="sellHistory">
			<tr>
				<td width="60"><a href="ordersEdit.cfm?ID=#orderID#">#DateFormat(datePurchased,"yyyy-mm-dd")#</a></td>
				<td>#firstName# #lastName#</td>
				<td align="center" width="20">#qtyOrdered#</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total:</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
<cfelse>
<p>None</p>
</cfif>

<cfquery name="sellHistory" dbtype="query">
	select *
	from sellHistoryItem
	where (adminAvailID=4 OR adminAvailID=5) AND statusID<>7
	order by dateUpdated DESC
</cfquery>
<h1>Open Orders</h1>
<cfif sellHistory.recordCount GT 0>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
		<cfoutput query="sellHistory">
			<tr>
				<td width="60"><a href="ordersEdit.cfm?ID=#orderID#">#DateFormat(dateUpdated,"yyyy-mm-dd")#</a></td>
				<td><a href="mailto:#email#">#firstName# #lastName#</a></td>
				<td align="center" width="20">#qtyOrdered#</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total:</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
<cfelse>
<p>None</p>
</cfif>
<cfquery name="sellHistory" dbtype="query">
	select *
	from sellHistoryItem
	where (adminAvailID=2 OR adminAvailID=0) AND statusID<>7
	order by dateUpdated DESC
</cfquery>
<h1>Pending Orders</h1>
<cfif sellHistory.recordCount GT 0>
	<cfset checkedOutCount=0>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
		<cfoutput query="sellHistory">
			<cfset oRowColor="1F1A17">
			<cfif statusID GT 1 AND statusID LT 6><cfset oRowColor="6666CC"><cfset checkedOutCount=checkedOutCount+1></cfif>
			<tr bgcolor="###oRowColor#">
				<td width="60"><a href="ordersEdit.cfm?ID=#orderID#">#DateFormat(dateUpdated,"yyyy-mm-dd")#</a></td>
				<td><a href="mailto:#email#">#firstName# #lastName#</a></td>
				<td align="center" width="20">#qtyOrdered#</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2"><cfoutput><font color="##FF9900">(#checkedOutCount# Checked Out)</font>&nbsp;&nbsp;</cfoutput> Total:</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
<cfelse>
<p>None</p>
</cfif>
<cfquery name="sellHistory" dbtype="query">
	select *
	from sellHistoryItem
	where adminAvailID=3 AND statusID<>7
	order by dateStarted DESC
</cfquery>
<cfif sellHistory.recordCount GT 0>
	<h1>Backorders</h1>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
		<cfoutput query="sellHistory">
			<tr>
				<td width="60"><a href="ordersEdit.cfm?ID=#orderID#">#DateFormat(dateStarted,"yyyy-mm-dd")#</a></td>
				<td><a href="mailto:#email#">#firstName# #lastName#</a></td>
				<td align="center" width="20">#qtyOrdered#</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total:</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
</cfif>
<cfquery name="sellHistory" dbtype="query">
	select *
	from sellHistoryItem
	where adminAvailID=1
	order by dateStarted DESC
</cfquery>
<cfif sellHistory.recordCount GT 0>
<h1>Marked as 'Not Available'</h1>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
		<cfoutput query="sellHistory">
			<tr>
				<td width="60">#DateFormat(dateStarted,"yyyy-mm-dd")#</td>
				<td><a href="mailto:#email#">#firstName# #lastName#</a></td>
				<td align="center" width="20">#qtyOrdered#</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total:</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
</cfif><cfelse><cfoutput><a href="catalogEdit.cfm?ID=#url.ID#&showhist=true">Show History</a></cfoutput></cfif>
</td>
</tr>
</table>
<cfinclude template="pageFoot.cfm">