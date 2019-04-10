<!---<cfsetting requesttimeout="6000">//--->
<cfset pageName="CATALOG">
<cfparam name="form.search" default="">
<cfparam name="form.sTitle" default="">
<cfparam name="form.sArtist" default="">
<cfparam name="form.sLabel" default="">
<cfparam name="form.sCatnum" default="">
<cfparam name="form.sActive" default="">
<cfparam name="form.sID" default="">
<cfparam name="Cookie.sTitle" default="">
<cfparam name="Cookie.sArtist" default="">
<cfparam name="Cookie.sLabel" default="">
<cfparam name="Cookie.sCatnum" default="">
<cfparam name="Cookie.sActive" default="true">
<cfparam name="Cookie.sID" default="">
<cfparam name="Cookie.sortOrder" default="DESC">
<cfparam name="Cookie.orderBy" default="ID">
<cfparam name="url.showAll" default="false">
<cfparam name="url.sTitle" default="">
<cfparam name="url.sArtist" default="">
<cfparam name="url.sLabel" default="">
<cfparam name="url.sCatnum" default="">
<cfparam name="url.sActive" default="">
<cfparam name="url.sID" default="">
<cfparam name="url.so" default="">
<cfparam name="url.ob" default="">
<cfparam name="url.emailsent" default="">
<cfif url.sTitle NEQ ""><cfset form.sTitle=url.sTitle></cfif>
<cfif url.sArtist NEQ ""><cfset form.sArtist=url.sArtist></cfif>
<cfif url.sLabel NEQ ""><cfset form.sLabel=url.sLabel></cfif>
<cfif url.sCatnum NEQ ""><cfset form.sCatnum=url.sCatnum></cfif>
<cfif url.sActive NEQ ""><cfset form.sActive=url.sActive></cfif>
<cfif url.sID NEQ ""><cfset form.sID=url.sID></cfif>
<cfif form.sTitle NEQ "" OR form.search NEQ ""><cfset Cookie.sTitle=form.sTitle></cfif>
<cfif form.sArtist NEQ "" OR form.search NEQ ""><cfset Cookie.sArtist=form.sArtist></cfif>
<cfif form.sLabel NEQ "" OR form.search NEQ ""><cfset Cookie.sLabel=form.sLabel></cfif>
<cfif form.sCatnum NEQ "" OR form.search NEQ ""><cfset Cookie.sCatnum=form.sCatnum></cfif>
<cfif form.sActive NEQ "" OR form.search NEQ ""><cfset Cookie.sActive=form.sActive></cfif>
<cfif form.sID NEQ "" OR form.search NEQ ""><cfset Cookie.sID=form.sID></cfif>
<cfif url.so NEQ ""><cfset Cookie.sortOrder=url.so></cfif>
<cfif url.ob NEQ ""><cfset Cookie.orderBy=url.ob></cfif>
<cfset urlParam="sArtist=#Cookie.sArtist#&sTitle=#Cookie.sTitle#&sLabel=#Cookie.sLabel#&sCatnum=#Cookie.sCatnum#&sActive=#Cookie.sActive#&sID=#form.sID#">
<cfif url.showAll><cfset showRows="-1"><cfelse><cfset showRows="100"></cfif>
<cfif Cookie.sActive EQ "true"><cfset activeString=" AND (ONHAND>0 OR ONSIDE>0)"><cfelse><cfset activeString=""></cfif>
<cfquery name="staffList" datasource="#DSN#" maxrows="1" cachedWithin="#CreateTimeSpan(1,0, 0, 0)#">
	select *
	from artistListsQuery
	where artistID=15387
	order by listDate DESC 
</cfquery>
<cfinclude template="pageHead.cfm">
<!--- If the gridEntered form field exists, the form was submitted.
		Perform gridupdate. --->
		<cfquery name="catalogFind" datasource="#DSN#" maxrows="#showRows#">
		select *
		from ((((catItemsQuery LEFT JOIN sumBought ON catItemIDBought=ID) LEFT JOIN sumSold ON catItemIDSold=ID) LEFT JOIN sumPending ON catItemIDPending=ID) LEFT JOIN sumBackorder ON catItemIDBackorder=ID)
		where catItemsQuery.artist LIKE <cfqueryparam value="%#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.label LIKE <cfqueryparam value="%#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.title LIKE <cfqueryparam value="%#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.catnum LIKE <cfqueryparam value="%#Cookie.sCatnum#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.dtID LIKE <cfqueryparam value="%#Cookie.sID#%" cfsqltype="cf_sql_char"> #activeString#
			order by catItemsQuery.#Cookie.orderBy# #Cookie.sortOrder#
	</cfquery>
<!---<cfif IsDefined("form.gridEntered") is True>
	<cfgridupdate grid = "FirstGrid" dataSource = "#DSN#" Keyonly="true" tableName = "catItems">
 </cfif>
 <cfform name="gridForm">
		<cfquery name="displayableCat" maxrows="50" dbtype="query">
			select ID, label, catnum, artist, title, releaseDate, DTdateUpdated, ONHAND, ONSIDE, NRECSINSET, media from catalogFind
		</cfquery>
	<cfgrid name = "FirstGrid" format="applet"
			height="320" width="1000"
		font="Helvetica" fontsize="10"
		gridLines="yes"
		selectMode="edit"
		query = "displayableCat"
		sort="yes"
		sortAscendingButton="A -> Z" sortdescendingbutton="Z -> A"
		autoWidth="yes" hrefkey="ID" appendkey="yes">
	</cfgrid><br>
<cfinput type="submit" name="gridEntered" value="Submit Data">
</cfform>//--->

		<h1>Catalog <font color=yellow>RESEARCH MODE</font></h1>
		<cfoutput><p><a href="#URLSessionFormat("catalogAdd.cfm")#">ADD ITEM</a>&nbsp;&nbsp;&nbsp;
		<a href="#URLSessionFormat("listsLabelsAdd.cfm")#">ADD LABEL</a>&nbsp;&nbsp;&nbsp;
		<a href="#URLSessionFormat("catalogDTHistory.cfm")#">Downtown Import History</a>&nbsp;&nbsp;&nbsp;
		<a href="#URLSessionFormat("catalogDTPreReleases.cfm")#">Downtown Pre-Releases</a>&nbsp;&nbsp;&nbsp;
		<a href="#URLSessionFormat("catalogReview.cfm")#">Catalog Review</a>&nbsp;&nbsp;&nbsp;
		<a href="#URLSessionFormat("catalogNewReleases.cfm")#" target="_blank">New Release Report</a>&nbsp;&nbsp;&nbsp;
		<!---<a href="catalog.cfm?zeroes=yes">Minuses</a>&nbsp;&nbsp;&nbsp;//--->
		<a href="listsPlayListsEdit.cfm?ID=#staffList.ID#">Staff Picks</a>&nbsp;&nbsp;&nbsp;
		<!---<a href="catalog.cfm?ob=ID&so=DESC">Fix Sort</a>&nbsp;&nbsp;&nbsp;
		<a href="http://www.downtown304.com/opussitelayout07main.cfm?group=new&clearit=flush">Flush NR Cache</a>//--->
		<a href="#URLSessionFormat("catalogSales.cfm")#">RESEARCH</a></p>
       
<cfquery name="allShelves" datasource="#DSN#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	select *
    from shelf
    order by code
</cfquery>
        <!---<cfform action="catalogCheckIn.cfm" method="post" name="checkin"><cfselect query="allShelves" name="shelfID" display="code" value="ID"></cfselect><cfinput type="submit" name="checkinsubmit" value="Check In"> </cfform>//--->
			<form id="sForm" name="sForm" method="post" action="#URLSessionFormat("catalogSales.cfm")#"></cfoutput>
			<table border="1" cellpadding="2" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse:collapse;">
				<tr bgcolor="#000000">
					<td>dtID</td>
					<td>CAT#</td>
                    <td>LABEL</td>
                    <td>ARTIST</td>
					<td>TITLE</td>
					<td>ACTIVE</td>
					<td>&nbsp;</td>
				</tr>
				<cfoutput>
					<tr>
						<td><input type="text" name="sID" size="10" maxlength="10" value="#Cookie.sID#"></td>
						<td><input type="text" name="sCatnum" size="12" maxlength="20" value="#Cookie.sCatnum#"></td>
						<td><input type="text" name="sLabel" size="18" maxlength="30" value="#Cookie.sLabel#"></td>
						<td><input type="text" name="sArtist" size="18" maxlength="30" value="#Cookie.sArtist#"></td>
						<td><input type="text" name="sTitle" size="18" maxlength="30" value="#Cookie.sTitle#"></td>
						<td align="center"><input type="radio" name="sActive" value="true"<cfif Cookie.sActive EQ "true"> checked</cfif>> Active <input type="radio" name="sActive" value="false"<cfif Cookie.sActive EQ "false"> checked</cfif>> All</td>
						<td><input type="submit" name="search" value=" SEARCH " /></td>
					</tr>
				</cfoutput>
			</table>
		</form>
<!---<cfform name="catResultsForm" action="#URLSessionFormat("catalogAction.cfm")#" method="post">
<p><cfinput type="submit" name="save" value="Save Changes"></p>//--->
	<cfif Cookie.sArtist NEQ "" OR Cookie.sLabel NEQ "" OR Cookie.sTitle NEQ "" OR Cookie.sCatnum NEQ "" OR Cookie.sID NEQ "">
	<table bgcolor="#CCCCCC" border="1" bordercolor="#999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<cfoutput>
		<tr valign="middle">
			<td align="center" bgcolor="##000000" class="catDisplayHead"><img src="../images/email06.gif" width="14" height="11" /></td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">ART</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">MP3</td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=ID&so=ASC&showAll=#url.showAll#">^</a>&nbsp;ID&nbsp;<a href="catalog.cfm?ob=ID&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=label&so=ASC&showAll=#url.showAll#">^</a>&nbsp;LABEL&nbsp;<a href="catalog.cfm?ob=label&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=catnum&so=ASC&showAll=#url.showAll#">^</a>&nbsp;CAT##&nbsp;<a href="catalog.cfm?ob=catnum&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=artist&so=ASC&showAll=#url.showAll#">^</a>&nbsp;ARTIST&nbsp;<a href="catalog.cfm?ob=artist&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=title&so=ASC&showAll=#url.showAll#">^</a>&nbsp;TITLE&nbsp;<a href="catalog.cfm?ob=title&so=DESC&showAll=#url.showAll#">v</a></td>
			<!---<td align="center" bgcolor="##000000" class="cat">ACTIVE<br />
				<a href="##" onclick="javascript:SelectAll();">ALL</a> <a href="##" onclick="javascript:SelectNone();">NONE</a></td>//--->
			<td align="center" bgcolor="##000000" class="catDisplayHead">SHELF</td>
			<td colspan="2" align="center" bgcolor="##000000" class="catDisplayHead">ONHAND</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">MEDIA</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=price&so=ASC&showAll=#url.showAll#">^</a>&nbsp;PRICE&nbsp;<a href="catalog.cfm?ob=price&so=DESC&showAll=#url.showAll#">v</a></td>
			<td align="center" bgcolor="##000000">BUY</td>
			<td align="center" bgcolor="##000000">SEL</td>
			<td align="center" bgcolor="##000000">PEN</td>
			<td align="center" bgcolor="##000000">BAC</td>
		</tr></cfoutput>
		
	<cfoutput query="catalogFind">
		<tr bgcolor="##666666">
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
			<td align="center" bgcolor="##000000" class="catDisplayHead"><cfif mp3Loaded><a href="DTItemEmail.cfm?ID=#ID#&pageBack=catalog.cfm"><img src="../images/email06.gif" width="14" height="11" border="0"></a><cfif url.emailsent EQ ID><br /><font size="1" color="white">SENT</font></cfif><cfelse>&nbsp;</cfif></td>
			<cfif (ONHAND LT 1 AND ONSIDE LT 1) OR albumStatusID GT 24><cfset oos='OOS'><cfelseif ONSIDE EQ 999><cfset oos='999'><cfelse><cfset oos=''></cfif>
			<!---<cfset imagefile="labels/label_WhiteLabel.gif">
			<cfset imagefolder="">
			<cfdirectory directory="#serverPath#\images\items" filter="oI#catalogFind.ID#.jpg" name="imageCheck" action="list">
			<cfif imageCheck.recordCount NEQ 0>
				<cfset imagefile="items/" & imageCheck.name>
			<cfelseif logofile NEQ "">
				<cfdirectory directory="#serverPath#\images\labels" filter="#logofile#" name="logoCheck" action="list">
				<cfif logoCheck.recordCount NEQ 0>
					<cfset imagefile="labels/" & logoCheck.name>
				</cfif>
			</cfif>//--->
			<cfif catalogFind.jpgLoaded>
				<cfset imagefile="items/oI#catalogFind.ID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><a href="artLoad.cfm?ID=#ID#"><img src="../images/#imagefile#" width="25" height="25" border="0" /></a></td>
			<td class="catDisplay"><a href="trackLoad.cfm?ID=#ID#">LOAD</a></td>
			<td class="catDisplay"> <a href="catalogEdit.cfm?ID=#ID#">EDIT</a> </td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#label#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#catnum#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#artist#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#title#</td>
			<!---<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#"><input type="hidden" name="allIDs" value="#ID#" /><cfinput type="checkbox" name="activeIDs" checked="#YesNoFormat(active)#" value="#ID#"></td>//--->
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#shelfCode#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#ONHAND#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#ONSIDE#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#DollarFormat(price)#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#qtyBought#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#qtySold#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#qtyPending#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#qtyBackordered#</td>
		</tr>
	</cfoutput>
	</table>
	
</cfif>
<!---</cfform>//--->
		<p>&nbsp; </p>
<cfoutput>
		<!---<input type="hidden" name="sTitle" value="#Cookie.sTitle#" />
		<input type="hidden" name="sArtist" value="#Cookie.sArtist#" />
		<input type="hidden" name="sLabel" value="#Cookie.sLabel#" />
		<input type="hidden" name="sCatnum" value="#Cookie.sCatnum#" />//--->
		<cfif url.showAll EQ false>
			<a href="#URLSessionFormat("catalog.cfm?showAll=true")#">Show All Results</a>
		<cfelse>
			<a href="#URLSessionFormat("catalog.cfm?showAll=false")#">Show Max 100 Results</a>
		</cfif>
	</cfoutput>		

		<p>&nbsp;</p>
		<cfinclude template="pageFoot.cfm">