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
<cfparam name="url.white" default="">
<cfparam name="url.findReissue" default="">
<cfparam name="url.newest" default="">
<cfparam name="url.hidetracks" default="false">
<cfparam name="Cookie.pushReleaseDate" default="no">
<cfparam name="findThisID" default="0">
<cfparam name="url.showCatRcvd" default="no">
<cfinclude template="pageHead.cfm">
<!---<cfif url.addOS NEQ 0>
	<cfquery name="addOS" datasource="#DSN#">
    	update catItems
        set ONSIDE=ONSIDE+#url.addOS#
        where ID=#url.ID#
    </cfquery>
</cfif>
<cfif url.dtID NEQ 0>
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
<cfelseif url.findReissue NEQ "">
<cfquery name="thisItem" datasource="#DSN#" maxRows="1">
	select *
    from catItemsQuery
    where genreID=7 AND albumStatusID<25 AND ONHAND>0
    order by ID DESC
</cfquery>
<cfelse>
<cfset findThisID=url.ID>
<cfif url.newest EQ "find">
	<cfquery name="newestentry" datasource="#DSN#">
    	select Max(ID) as newID
        from catItems
    </cfquery>
    <cfset findThisID=newestentry.newID>
</cfif>
<cfquery name="thisItem" datasource="#DSN#">
	select *
    from catItemsQuery
	where ID=#findThisID#
</cfquery>
</cfif>
<cfif thisItem.recordCount EQ 0>NOT FOUND<cfabort></cfif>
<cfif url.artists EQ "showAll">
	<cfquery name="artists" dbtype="query">
		select ID, name
		from Application.adminAllArtists
		order by name
	</cfquery>
<cfelse><!--- where Left(name,1)='#Left(thisItem.artist,"1")#'//--->
	<cfquery name="artists" dbtype="query">
		select ID, name
		from Application.adminAllArtists
		where name LIKE '#Left(thisItem.artist,"1")#%'
		order by name
	</cfquery>
</cfif>
<cfif url.labels EQ "showAll" OR url.white EQ "edit">
	<cfquery name="labels" dbtype="query">
		select ID, name
		from Application.adminAllLabels
		order by sort
	</cfquery>
<cfelse>
	<cfif Left(thisItem.labelSort,1) EQ "">
		<cfset thisLetter=Left(thisItem.label,1)>
	<cfelse>
		<cfset thisLetter=Left(thisItem.labelSort,1)>
	</cfif><!--- where Left(sort,1)='#thisLetter#' OR (sort='' OR sort Is Null AND Left(name,1)='#thisLetter#')//--->
	<cfquery name="labels" dbtype="query">
		select ID, name
		from Application.adminAllLabels
		where sort LIKE '#thisLetter#%' OR (sort='' OR (sort Is Null AND name LIKE '#thisLetter#%'))
		order by sort
	</cfquery>
</cfif>
<cfquery name="backendCountries" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,6,0)#">
	select ID, name
	from country
	order by name
</cfquery>
<cfquery name="backendGenres" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,15,0)#">
	select ID, name
	from genres
	order by name
</cfquery>
<cfquery name="backendMediaTypes" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,20,0)#">
	select ID, name
	from media
	order by name
</cfquery>
<cfquery name="backendShelfs" datasource="#DSN#">
	select *
	from shelf
	order by partner
</cfquery>
<cfquery name="backendCondition" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,25,0)#">
	select ID, condition
	from condition
	order by ID
</cfquery>
<cfquery name="backendAlbumStatuses" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,45,0)#">
	select *
	from DTAlbumStatus
</cfquery>
<cfquery name="tracks" datasource="#DSN#">
	select *
	from catTracks
	where catID=#thisItem.ID#
	order by tSort
</cfquery>
<cfquery name="calcBought" datasource="#DSN#">
	select Sum(qtyRcvd) AS qtyBought
    from catRcvd
    where catItemID=#url.ID# AND rcvdShelfID<>24
</cfquery>
<cfquery name="calcSold" datasource="#DSN#">
	select Sum(qtyOrdered) As qtySold
    from catSold
    where catItemID=#url.ID#
</cfquery>
<cfif calcBought.recordCount GT 0 AND isNumeric(calcBought.qtyBought)><cfset cBought=calcBought.qtyBought><cfelse><cfset cBought=0></cfif>
<cfif calcSold.recordCount GT 0 AND isNumeric(calcSold.qtySold)><cfset cSold=calcSold.qtySold><cfelse><cfset cSold=0></cfif>
<cfset calcQty=cBought-cSold>

<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%">
<td valign="top" align="left">
<cfif url.dup><h1><b><font color="yellow">DUPLICATE</font></b></h1></cfif>
<cfform name="catEditForm" action="catalogEditAction.cfm" method="post">
<cfinput type="hidden" name="white" value="#url.white#">
<cfinput type="hidden" name="findReissue" value="#url.findReissue#">
<cfoutput query="thisItem">
<script>
function tdrDo()
{
var tdate="#DateFormat(varDateODBC,'mm/dd/yyyy')#";
document.getElementById("tdrfield").value=tdate;
}
function tduDo()
{
var tdate="#DateFormat(varDateODBC,'mm/dd/yyyy')#";
document.getElementById("tdufield").value=tdate;
}
function tdlDo()
{
var tdate="#DateFormat(varDateODBC,'mm/dd/yyyy')#";
document.getElementById("tdlfield").value=tdate;
}
function tdpDo()
{
var tdate="#DateFormat(varDateODBC,'mm/dd/yyyy')#";
document.getElementById("tdpfield").value=tdate;
}
function psaveDo()
{
var tprice="#DollarFormat(price)#";
document.getElementById("psave").value=tprice;
}
function ssaveDo()
{
var sprice="#DollarFormat(saleSave)#";
var zprice="#DollarFormat(0)#";
document.getElementById("rprice").value=sprice;
document.getElementById("ssave").value=zprice;
}
	function csaveDo()
{
var tcost="#DollarFormat(cost)#";
document.getElementById("csave").value=tcost;
}
</script>
	<table border="0" cellpadding="10" cellspacing="0"><tr><td>
		<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;">
      <tr>
        <td align="center"  style="color:##CC3300; font-size:medium; padding:5px;"><span style="font-size:medium; padding:5px;"><b><a href="http://www.downtown304.com/dt161news.cfm?sid=#ID#" target="_blank">#ID#</a></b></span><cfinput type="text" name="dtID" class="inputBox" value="#thisItem.dtID#" size="7" maxlength="10" style="text-align:center"></td>
        <td colspan="3"><table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%"><tr>
			<td style="padding: 5px;"><cfif discogsID GT 0><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">Discogs</a><cfelse><a href="http://www.discogs.com/search/?q=#catnum#&type=all" target="discogsFrame">Discogs</a></cfif> ID <cfinput type="text" name="discogsID" maxlength="10" size="10" class="inputBox" value="#discogsID#" required="yes" message="Discogs ID is required, if not known, put 0"> &nbsp;&nbsp;<cfinput type="hidden" name="blueDate" value="#DateFormat(thisItem.dtOLDID,"mm/dd/yyyy")#"><font color="##FFCC33" style="font-size:small;"><b><cfif albumStatusID LT 25 AND (ONHAND GT 0)>IN-STOCK<cfelseif (albumStatusID GTE 21 AND albumStatusID LTE 24) AND (ONHAND EQ 0)>NO INVENTORY<cfelseif albumStatusID EQ 148>PRE-RELEASE<cfelse>OUT OF STOCK</cfif></b></font></td>
			<td align="right" class="dataLabel"><a href="catalogEdit.cfm?ID=#ID#&hidetracks=true">Skip Tracks</a> <a href="catalogEdit.cfm?ID=#ID#">Reload</a></td></tr></table></td>
        </tr>
      <tr>
	  	<td><table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%"><tr><td align="left" class="dataLabel">Artist</td>
        <td align="right" class="dataLabel"><input type="submit" name="showAllArtists" value="Show All"></td></tr></table></td>
        <td colspan="3" valign="middle"><cfselect query="artists" name="artistID" value="ID" display="name" selected="#thisItem.artistID#" class="inputBox">
					<option value="0"<cfif thisItem.artistID EQ "0"> selected</cfif>>Choose an artist...</option>
					<!---<option value="0">Add a New Artist</option> //--->
				</cfselect>
				<input type="submit" name="editArtist" value="Edit"></td>
			</tr>
			<tr>
				<td class="dataLabel">Title</td>
				<td colspan="3" nowrap="nowrap" style="color:##000000; vertical-align:middle;"><cfinput type="text" name="itemTitle" message="RELEASE TITLE is required" required="yes" class="inputBox" value="#thisItem.title#" size="80" maxlength="255"></td>
				</tr>
			<!---<tr>
				<td class="dataLabel">Comment</td>
				<td colspan="3"><cfinput type="text" name="comment" maxlength="150" size="75" class="inputBox" value="#thisItem.comment#"></td>
			</tr>//--->
            <tr><td><table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="100%"><tr><td align="left" class="dataLabel">Label</td>
			<td align="right" class="dataLabel"><input type="submit" name="showAllLabels" value="Show All"></td></tr></table></td>
			  <td colspan="3"><cfselect query="labels" name="labelID" value="ID" display="name" selected="#thisItem.labelID#" class="inputBox"></cfselect>
			<input type="submit" name="editLabel" value="Edit"></td>
          </tr>
			<tr>
				<td class="dataLabel">Catalog ##</td>
				<td><cfinput type="text" name="catnum" maxlength="30" size="25" class="inputBox" required="yes" message="CATALOG ## is required" value="#thisItem.catnum#"></td>
                <td class="dataLabel">Media</td>
				<td><cfinput type="text" name="NRECSINSET" class="inputBox" value="#thisItem.NRECSINSET#" size="2" maxlength="2">
				<cfselect query="backendMediaTypes" name="mediaID" value="ID" display="name" selected="#thisItem.mediaID#"></cfselect></td>
                
            	
          </tr>
          <tr>
          	<td class="dataLabel">Vendor</td>
			<td><cfselect query="backendShelfs" name="shelfID" value="ID" display="partner" selected="#thisItem.shelfID#" class="inputBox"></cfselect></td>
                <td class="dataLabel">Genre</td>
			<td><cfselect query="backendGenres" name="genreID" value="ID" display="name" selected="#thisItem.genreID#" class="inputBox">
				<option value="0"<cfif thisItem.genreID EQ 0> selected="yes"</cfif>>Choose a genre...</option>
			</cfselect></td>
          </tr>
		  <tr>
		  	<td class="dataLabel" nowrap> On Hand / Status / Calc</td>
			<td nowrap><cfif shelfID EQ 11><cfinput type="text" name="ONHAND" message="## ON HAND is required" required="yes" class="inputBox" value="#thisItem.ONHAND#" size="2" maxlength="10"><cfelse><cfinput type="text" name="ONHAND" message="## ON HAND is required" required="yes" class="inputBox" value="#thisItem.ONHAND#" size="2" maxlength="10" readonly></cfif><cfselect name="albumStatusID" query="backendAlbumStatuses" value="ID" display="album_Status_Name" selected="#albumStatusID#" class="inputBox"><cfinput type="hidden" name="oldAlbumStatusID" value="#albumStatusID#"></cfselect><cfinput type="hidden" name="notNew304" value="#YesNoFormat(thisItem.notNew304)#"><cfinput type="text" name="CALCQTY" required="no" class="inputBox" value="#calcQty#" size="2" maxlength="10" readonly></td>
			<td class="dataLabel">Country (Fix)</td>
			<td><cfinput type="hidden" name="weightException" value="#thisItem.weightException#">
              <cfselect query="backendCountries" name="countryID" value="ID" display="name" selected="#thisItem.countryID#" class="inputBox"></cfselect><cfinput type="checkbox" name="fixCountry" value="yes" checked="no"></td>
		</tr>
		<tr>
			<td class="dataLabel">Price / Cost / Wholesale</td>
         	<td><cfinput type="text" id="rprice" name="price" message="PRICE is required" validate="float" required="yes" class="inputBox" value="#DollarFormat(thisItem.price)#" size="5" maxlength="10"><cfinput type="text" name="cost" class="inputBox" value="#DollarFormat(thisItem.cost)#" size="5" maxlength="10"><cfinput type="text" name="wholesalePrice" class="inputBox" value="#DollarFormat(thisItem.wholesalePrice)#" size="5" maxlength="10"></td>
			<td class="dataLabel" nowrap>Save Price / Cost / Original</td>
         	<td nowrap><cfinput type="text" id="psave" name="priceSave" message="Price Save is required" validate="float" required="yes" class="inputBox" value="#DollarFormat(thisItem.priceSave)#" size="5" maxlength="10"><cfinput type="text" id="csave" name="costSave" message="Cost Save is required" validate="float" required="yes" class="inputBox" value="#DollarFormat(thisItem.costSave)#" size="5" maxlength="10"><cfinput type="text" name="originalPrice" message="Original Price is required" validate="float" required="yes" class="inputBox" value="#DollarFormat(thisItem.originalPrice)#" size="5" maxlength="10"><input type="button" name="makePriceSavePrice" onclick="psaveDo()" value="P"><input type="button" name="makeCostSaveCost" onclick="csaveDo()" value="C"></td>
			
		</tr>
   <tr>
            <td class="dataLabel" nowrap>List Date / Updated <cfinput type="hidden" name="releaseDateLock" id="releaseDateLock" value="#YesNoFormat(thisItem.releaseDateLock)#" /></td>
			<td><cfinput type="text" id="tdlfield" name="releaseDate" maxlength="10" size="10" class="inputBox" value="#DateFormat(thisItem.releaseDate,"mm/dd/yyyy")#"><cfinput type="text" name="releaseYear" id="tdufield" maxlength="10" size="10" class="inputBox" value="#DateFormat(thisItem.dtDateUpdated,"mm/dd/yyyy")#"><input type="button" name="tdl" value="T" id="tdl" onclick="tdlDo()"><input type="button" name="tdu" value="T" id="tdu" onclick="tduDo()"><cfinput type="checkbox" name="pushReleaseDate" id="pushReleaseDate" value="Yes" checked="#YesNoFormat(Cookie.pushReleaseDate)#" /> Push</td>
            <td class="dataLabel">Release / Pre-Order </td>
			<td><cfinput type="text" name="realReleaseDate" id="tdrfield" maxlength="10" size="10" class="inputBox" value="#DateFormat(realReleaseDate,"mm/dd/yyyy")#"><cfinput type="text" name="preOrderCutoffDate" id="tdpfield" maxlength="10" size="10" class="inputBox" value="#DateFormat(preOrderCutoffDate,"mm/dd/yyyy")#"><cfinput type="checkbox" name="canPreorder" id="canPreorder" value="Yes" checked="#YesNoFormat(canPreorder)#" /><input type="button" name="tdr" value="T" id="tdr" onclick="tdrDo()"><input type="button" name="tdp" value="T" id="tdp" onclick="tdpDo()"></td>
	   </tr>
	   <tr>
       	<td>&nbsp;</td>
          	<td class="dataLabel" colspan="3">
            <table border="0" style="border-collapse:collapse;" cellpadding="4" cellspacing="0">
                <tr>   
                    <td valign="top" style="font-size: 12px">
                    	<cfinput type="checkbox" name="specialItem" id="specialItem" value="Yes" checked="#YesNoFormat(thisItem.specialItem)#" /> Special<br>
                        <cfinput type="checkbox" name="blue99" value="yes" checked="#YesNoFormat(blue99)#" > Sale
                    <td valign="top" style="font-size: 12px">
                        <cfinput type="checkbox" name="reissue" value="Yes" checked="#YesNoFormat(thisItem.reissue)#"> Reissue<br>
                        <cfinput type="checkbox" name="remastered" value="Yes" checked="#YesNoFormat(thisItem.remastered)#"> Remastered
                    </td>
                    <td valign="top" style="font-size: 12px">
                        <cfinput type="checkbox" name="warehouseFind" value="Yes" checked="#YesNoFormat(thisItem.warehouseFind)#"> Warehouse Find<br>
                        <cfinput type="checkbox" name="repress" value="Yes" checked="#YesNoFormat(thisItem.repress)#"> Re-press
                    </td>
                    <td valign="top" style="font-size: 12px">
                        <cfinput type="checkbox" name="notched" value="Yes" checked="#YesNoFormat(thisItem.notched)#"> Notched<br>
                        <cfinput type="checkbox" name="vinyl180g" id="vinyl180g" value="Yes" checked="#YesNoFormat(thisItem.vinyl180g)#" /> 180g Vinyl
                    <td valign="top" style="font-size: 12px">
                        <cfinput type="checkbox" name="limitedEdition" value="Yes" checked="#YesNoFormat(thisItem.limitedEdition)#"> Limited Edition<br>
                        <cfinput type="checkbox" name="dt304exclusive" value="Yes" checked="#YesNoFormat(thisItem.dt304exclusive)#"> Exclusive
                    </td>
                     <td valign="top" style="font-size: 12px">
                        <cfinput type="hidden" name="dtOLDID" value="#dtOLDID#">
                        <cfinput type="hidden" name="hideTracks" id="hideTracks" value="#YesNoFormat(thisItem.hideTracks)#" />
                        <cfinput type="checkbox" name="noReorder" id="noReorder" value="Yes" checked="#YesNoFormat(thisItem.noReorder)#" /> No Reorder<br>
                        <cfinput type="checkbox" name="active" value="Yes" checked="#YesNoFormat(thisItem.active)#"> Active</td>
                </tr>
            </table>
            </td>
		</tr>

       <tr>
       	<td class="dataLabel">Keywords<br>
        	<div style="font-size:x-small">separate with semi-colons</div></td>
       	<td colspan="3"><cfinput type="text" name="keywords" value="#keywords#" size="100"></td>
       </tr>
			<tr>
				<td rowspan="2" height="75" class="dataLabel" style="vertical-align:middle; text-align:center;"><cfif fullImg NEQ ""><img src="../images/items/oI#thisItem.ID#full.jpg" width="200" height="200" /><cfelseif jpgLoaded><img src="../images/items/oI#thisItem.ID#.jpg"  /><cfelse>&nbsp;</cfif><br>Sale Save <cfinput type="text" name="saleSave" id="ssave" message="Sale Save is required" validate="float" required="yes" class="inputBox" value="#DollarFormat(thisItem.saleSave)#" size="5" maxlength="10"> <input type="button" name="undoSaleSave" onclick="ssaveDo()" value="S"></td>
				<td colspan="3">
                <cfset tCt=0>
                
	<cfif url.hidetracks NEQ true>
		<cfif tracks.recordCount+url.addtrx GT 0>
        
        <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
            
            <cfloop query="tracks">
                <cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
                <cfset tCt=tCt+1>
                <tr>
                    <td><cfinput type="text" name="tSort#tCt#" class="inputBox" style="text-align:center" value="#tSort#" size="2" maxlength="2" align="center"></td>
                    <td><cfinput type="text" name="tName#tCt#" class="inputBox" value="#tName#" size="75" maxlength="200">
                    <input type="hidden" name="tID#tCt#" value="#tracks.ID#" />
                    
                    <!---<cfdirectory directory="d:\media" filter="oT#trID#.mp3" name="trackCheck" action="list">
                        <cfif trackCheck.recordCount GT 0>//--->
                        
                            <cfif tracks.mp3Loaded OR mp3Alt NEQ 0><a href="#webPath#/media/oT#trID#.mp3"><img src="images/speaker.gif" width="16" height="14" border="0" target="mp3listenframe"></a></cfif></td>
                </tr>
            </cfloop>
            <cfif url.addtrx GT 0>
            <cfloop from="1" to="#url.addtrx#" index="x">
                <cfset tCt=tCt+1>
                <tr>
                    <td><cfinput type="text" name="tSort#tCt#" class="inputBox" style="text-align:center" value="#tCt#" size="2" maxlength="2" align="center"></td>
                    <td><cfinput type="text" name="tName#tCt#" class="inputBox" size="75" maxlength="200"> 
                    <input type="hidden" name="tID#tCt#" value="0" /></td>
                </tr>
            </cfloop>
            </cfif>
        </table>
        </cfif>
     <cfelse>
     	<input type="hidden" name="skiptracks" value="true">
    </cfif>
    <textarea name="createTracks" cols="100" rows="5" class="inputBox"></textarea></td>
			</tr>
	
	<tr>
		<td colspan="3" style="vertical-align:middle; text-align:center;">
		<p style="margin-top: 8px; margin-bottom: 8px;"><input type="submit" name="done" tabindex=1 value=" Done " />
		<input type="submit" name="loadTracks" value=" Load MP3s " tabindex="9" />
		  <input type="submit" name="loadArt" value=" Load Art " tabindex="21" />
		<input type="text" name="addtrx" size="4" maxlength="2" style="text-align:center" tabindex=2/> <input type="submit" name="submit" tabindex=3 value=" SAVE " /></p>
		</p></td>
		</tr>
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
	<tr>
	  <td colspan="4" align="left" valign="top">
	    <table border="0" style="border-collapse:collapse;" cellpadding="0" cellspacing="0" width="100%">
        <tr>
        	<td width="50%">
            <table border="0" style="border-collapse:collapse;" cellpadding="1" cellspacing="0">
        	<tr>
            	<td>RECEIVE: </td>
                <td><input name="addONHAND" type="text" value="0" size="3" maxlength="3" style="text-align: left; padding: 0;" onFocus="this.value=''; " /></td>
            </tr>
            <tr>
            	<td>Vendor: </td>
                <td><cfselect query="vendors" name="addONHANDshelfID" value="ID" display="partner" class="inputBox"selected="#thisItem.shelfID#"></cfselect></td>
            </tr>
            <tr>
            	<td colspan="2"><input type="checkbox" name="sendBackorder" value="yes" checked="checked" /> Notify Backorders On Receipt&nbsp;&nbsp;&nbsp;<input type="checkbox" name="forceBackorder" value="yes"  /> Notify Backorders Now</td>
            </tr>
            </table>
</td>
<td width="50%">
          <table border="0" style="border-collapse:collapse;" cellpadding="1" cellspacing="0">
        	<tr>
            	<td>ADD TO P.O.: </td>
                <td><input name="ONORDER" type="text" size="3" maxlength="3" style="text-align: left; padding: 0;" value="0" onFocus="this.value=''; "  /></td>
            </tr>
            <tr>
            	<td>Vendor: </td>
                <td><cfselect query="vendors" name="addONORDERshelfID" value="ID" display="partner" class="inputBox" selected="#thisItem.shelfID#"></cfselect></td>
            </tr>
            <tr>
            	<td>Order for: </td>
                <td><cfselect query="storeCusts" name="ONORDERcustID" value="ID" display="username" class="inputBox"><option value="0" selected>downtown304</option></cfselect></td>
            </tr>
            </table>
</td></tr></table>
          </td>
	  </tr>
     
<cfquery name="onPurchOrder" datasource="#DSN#">
	select *
    from purchaseOrderDetailsQuery
    where catItemID=#findThisID# <!---AND completed=0 AND qtyRequested>qtyReceived//--->
    order by dateRequested DESC, POItem_ID DESC
</cfquery>
<cfif onPurchOrder.recordCount GT 0>
	
    <tr>
    	<td colspan="4" align="center">
        <table cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;" align="center" width="100%">
        <tr><td><p style="margin-top: 4px; margin-bottom: 3px; font-size: small; color:black;"><b>On Purchase Order:</b></p></td>
    </tr>
    <cfset poCt=0>
    <cfloop query="onPurchOrder">
    	<cfset poCt=poCt+1>
    	<tr>
            <cfif completed NEQ 1><td><cfelseif qtyReceived LT qtyRequested><td bgcolor="##999966"><cfelse><td bgcolor="##999999"></cfif>&nbsp;&nbsp;Requested <input type="text" name="onPurchOrder#poCt#" value="#qtyRequested#" size="2" readonly style="text-align:center;" /> &nbsp;Received <input type="text" name="onPurchOrderR#poCt#" value="#qtyReceived#" size="2" readonly style="text-align:center;" /><input type="text" name="onPurchOrderDate#poCt#" value="#DateFormat(dateRequested,"mmm d, yyyy")#" size="20" readonly /><!---<input type="text" name="onPurchOrderUser#poCt#" value="#requestedUser#" size="20" readonly />//---><input type="text" name="onPurchOrderVendor#poCt#" value="#partner#" size="15" readonly /><input type="text" name="onPurchOrderCust#poCt#" value="#username#" size="15" readonly /><cfif completed EQ 0 OR qtyReceived LT qtyRequested><cfif completed NEQ 1> <input type="checkbox" name="pocomplete" value="#POItem_ID#"> Complete</cfif> &nbsp;<input type="checkbox" name="podelete" value="#POItem_ID#">X</cfif>&nbsp;&nbsp;</td>
        </tr>
    </cfloop>
    </table></td></tr>
</cfif>
 <tr>
      	<td colspan="4" align="center"><textarea name="description" cols="100" rows="2" class="inputBox">#descrip#</textarea><br>
		  <input name="fixTitleCase" type="submit" id="fixTitleCase" tabindex="22" value=" Fix Title Case " />
		  <input name="calcPrice" type="submit" id="calcPrice" tabindex="23" value=" Calculate Price " />
		<input type="submit" name="promo" tabindex=5 value=" Promo " />
          <input name="makeInactive" type="submit" id="makeInactive" tabindex="24" value=" Make Inactive " />
		<input type="hidden" name="pageBack" value="#url.pageBack#" />
		<input type="hidden" name="ID" value="#thisItem.ID#" /><input type="hidden" name="tCt" value="#tCt#" />
		<input type="submit" name="dup" tabindex=4 value=" Duplicate " />
		<input type="submit" name="deleteItem" tabindex=6 value=" DELETE " /></td>
      </tr>
		</table>
		</td></tr>
		
		</table>
        <p><cfif vendorID NEQ 0>Vendor ID: #vendorID#</cfif></p>
    <p><a href="catalogBuyHistory.cfm?ID=#findThisID#" target="history">Buy History</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <cfif left(shelfCode,1) NEQ 'D'><a href="catalogBS.cfm?ID=#ID#" target="history">BS</a></cfif> </p>
    <cfif url.showCatRcvd EQ "yes"><cfinclude template="reportsCatRcvd.cfm">
    <cfelse>
    <p><a href="catalogEdit.cfm?ID=#url.ID#&showCatRcvd=yes" target="history">Show Catalog Received History</a></p>
    </cfif>
	</cfoutput>
	</cfform>
</td>
<td width="20">&nbsp;</td>
<td valign="top">
<cfif url.showhist>
<cfquery name="sellHistoryItem" datasource="#DSN#">
	select firstName, lastName, email, qtyOrdered, catItemID, adminAvailID, statusID, dateStarted, dateUpdated, datePurchased, dateShipped, orderID, ignoreSales, isVinylmania, isStore, billingName, orderItemID, backorderNoticeSent
    from orderItemsQuery 
    where catItemID=#thisItem.ID# AND ((adminAvailID IN (0,2) AND statusID<>7 AND dateDiff(day,dateUpdated,getDate())<90) OR adminAvailID NOT IN (0,2)) 
</cfquery>
<cfquery name="sellHistory" dbtype="query">
	select *
	from sellHistoryItem
	where adminAvailID=6 AND statusID<>7 AND ignoresales=0 AND isStore=0
	order by dateShipped DESC
</cfquery>
<cfoutput><h1>Sell History Retail (<a href="catalogSellAudit.cfm?ID=#url.ID#" target="history">Audit</a>)</h1></cfoutput>
<cfif sellHistory.recordCount GT 0>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
        <cfset vmtotal=0>
		<cfoutput query="sellHistory">
			<tr>
				<td nowrap style="font-size:xx-small;"><a href="ordersEdit.cfm?ID=#orderID#" target="orderEdit">#DateFormat(dateShipped,"yyyy-mm-dd")#&nbsp;</a></td>
				<td><cfif isStore>#UCase(billingName)#<cfelse>#firstName# #lastName#</cfif></td>
				<td align="center" width="20">#qtyOrdered#</td>
                 
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total Sold:&nbsp;</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
<cfelse>
<p>None</p>
</cfif>
<cfquery name="sellHistory" dbtype="query">
	select *
	from sellHistoryItem
	where adminAvailID=6 AND statusID<>7 AND ignoresales=0 AND isStore=1
	order by dateShipped DESC
</cfquery>
<cfoutput><h1>Sell History Distro(<a href="catalogSellAudit.cfm?ID=#url.ID#" target="history">Audit</a>)</h1></cfoutput>
<cfif sellHistory.recordCount GT 0>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
        <cfset vmtotal=0>
		<cfoutput query="sellHistory">
			<tr>
				<td nowrap style="font-size:xx-small;"><a href="ordersEdit.cfm?ID=#orderID#" target="orderEdit">#DateFormat(dateShipped,"yyyy-mm-dd")#&nbsp;</a></td>
				<td><cfif isStore>#UCase(billingName)#<cfelse>#firstName# #lastName#</cfif></td>
				<td align="center" width="20">#qtyOrdered#</td>
                 
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total Sold:&nbsp;</td>
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
				<td nowrap style="font-size:xx-small;"><a href="ordersEdit.cfm?ID=#orderID#" target="orderEdit">#DateFormat(datePurchased,"yyyy-mm-dd")#</a></td>
				<td><cfif isStore>#UCase(billingName)#<cfelse>#firstName# #lastName#</cfif></td>
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
				<td nowrap style="font-size:xx-small;"><a href="ordersEdit.cfm?ID=#orderID#" target="orderEdit">#DateFormat(dateUpdated,"yyyy-mm-dd")#&nbsp;&nbsp;</a></td>
				<td><a href="mailto:#email#"><cfif isStore>#UCase(billingName)#<cfelse>#firstName# #lastName#</cfif></a></td>
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
			<cfset oRowColor="gray">
			<cfif statusID GT 1 AND statusID LT 6><cfset oRowColor="6699CC"><cfset checkedOutCount=checkedOutCount+1></cfif>
			<tr style="background-color: ###oRowColor#">
				<td nowrap style="font-size:xx-small;"><a href="ordersEdit.cfm?ID=#orderID#" target="orderEdit">#DateFormat(dateUpdated,"yyyy-mm-dd")#</a></td>
				<td><a href="mailto:#email#"><cfif isStore>#UCase(billingName)#<cfelse>#firstName# #lastName#</cfif></a></td>
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
	where adminAvailID=3 
	order by dateStarted DESC
</cfquery>
<cfif sellHistory.recordCount GT 0>
	<h1>Backorders</h1>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
		<cfoutput query="sellHistory">
			<tr>
				<td nowrap style="font-size:xx-small;"><a href="ordersEdit.cfm?ID=#orderID#" target="orderEdit">#DateFormat(dateStarted,"yyyy-mm-dd")#</a></td>
				<td><a href="mailto:#email#"><cfif isStore>#UCase(billingName)#<cfelse>#firstName# #lastName#</cfif></a></td>
				<td align="center" width="20">#qtyOrdered#</td>
                <!---<td><input type="checkbox" name="orderitemdelete" value="#orderItemID#">X</td>//--->
                <td><input type="checkbox" name="backordernoticesent" value="yes" <cfif backorderNoticeSent EQ 1>checked</cfif>>X</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total:</td>
			<td align="center" colspan="2"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
</cfif>
<cfquery name="sellHistory" datasource="#DSN#">
	select *
	from notifyMe LEFT OUTER JOIN custAccounts ON custAccounts.ID=notifyMe.custID
	where noticeSent=0 AND catItemID=<cfqueryparam value="#findThisID#" cfsqltype="cf_sql_integer">
    order by dateRequested DESC
</cfquery>
<cfif sellHistory.recordCount GT 0>
	<h1>Email Me</h1>
	<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse;" width="100%">
		<cfset totalSold=0>
		<cfoutput query="sellHistory">
			<tr>
				<td nowrap style="font-size:xx-small;">#DateFormat(dateRequested,"yyyy-mm-dd")#</td>
				<td><a href="mailto:#email#"><cfif isStore>#UCase(billingName)#<cfelse>#firstName# #lastName#</cfif></a></td>
				<td align="center" width="20">1</td>
                <td><input type="checkbox" name="orderitemdelete" value="#catItemID#">X</td>
			</tr>
			<cfset totalSold=totalSold+1>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total:</td>
			<td align="center" colspan="2"><cfoutput>#totalSold#</cfoutput></td>
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
				<td nowrap style="font-size:xx-small;">#DateFormat(dateStarted,"yyyy-mm-dd")#</td>
				<td><a href="mailto:#email#"><cfif isStore>#UCase(billingName)#<cfelse>#firstName# #lastName#</cfif></a></td>
				<td align="center" width="20">#qtyOrdered#</td>
			</tr>
			<cfset totalSold=totalSold+qtyOrdered>
		</cfoutput>
		<tr>
			<td align="right" colspan="2">Total:</td>
			<td align="center"><cfoutput>#totalSold#</cfoutput></td>
		</tr>
	</table>
</cfif><cfelse><cfoutput><a href="catalogEdit.cfm?ID=#findThisID#&showhist=true" target="history">Show History</a></cfoutput></cfif>
</td>
</tr>
</table>
<cfinclude template="pageFoot.cfm">