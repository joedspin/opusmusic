<cfsetting requesttimeout="6000">
<cfset pageName="CATALOG">
<cfparam name="form.search" default="">
<cfparam name="form.sTitle" default="">
<cfparam name="form.sArtist" default="">
<cfparam name="form.sLabel" default="">
<cfparam name="form.sCatnum" default="">
<cfparam name="form.sID" default="">
<cfparam name="Cookie.sTitle" default="">
<cfparam name="Cookie.sArtist" default="">
<cfparam name="Cookie.sLabel" default="">
<cfparam name="Cookie.sCatnum" default="">
<cfparam name="Cookie.sID" default="">
<cfparam name="Cookie.sortOrder" default="ASC">
<cfparam name="Cookie.orderBy" default="ID">
<cfparam name="url.showAll" default="false">
<cfparam name="url.sTitle" default="">
<cfparam name="url.sArtist" default="">
<cfparam name="url.sLabel" default="">
<cfparam name="url.sCatnum" default="">
<cfparam name="url.sID" default="">
<cfparam name="url.so" default="">
<cfparam name="url.ob" default="">
<cfparam name="url.emailsent" default="">
<cfif url.sTitle NEQ ""><cfset form.sTitle=url.sTitle></cfif>
<cfif url.sArtist NEQ ""><cfset form.sArtist=url.sArtist></cfif>
<cfif url.sLabel NEQ ""><cfset form.sLabel=url.sLabel></cfif>
<cfif url.sCatnum NEQ ""><cfset form.sCatnum=url.sCatnum></cfif>
<cfif url.sID NEQ ""><cfset form.sID=url.sID></cfif>
<cfif form.sTitle NEQ "" OR form.search NEQ ""><cfset Cookie.sTitle=form.sTitle></cfif>
<cfif form.sArtist NEQ "" OR form.search NEQ ""><cfset Cookie.sArtist=form.sArtist></cfif>
<cfif form.sLabel NEQ "" OR form.search NEQ ""><cfset Cookie.sLabel=form.sLabel></cfif>
<cfif form.sCatnum NEQ "" OR form.search NEQ ""><cfset Cookie.sCatnum=form.sCatnum></cfif>
<cfif form.sID NEQ "" OR form.search NEQ ""><cfset Cookie.sID=form.sID></cfif>
<cfif url.so NEQ ""><cfset Cookie.sortOrder=url.so></cfif>
<cfif url.ob NEQ ""><cfset Cookie.orderBy=url.ob></cfif>
<cfset urlParam="sArtist=#Cookie.sArtist#&sTitle=#Cookie.sTitle#&sLabel=#Cookie.sLabel#&sCatnum=#Cookie.sCatnum#&sID=#form.sID#">
<cfinclude template="pageHead.cfm">
			<form id="sForm" name="sForm" method="post" action="#URLSessionFormat("catalogDTPreRelease.cfm")#"></cfoutput>
			<table border="1" cellpadding="2" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse:collapse;">
				<tr bgcolor="#000000">
					<td>ID</td>
					<td>ARTIST</td>
					<td>TITLE</td>
					<td>LABEL</td>
					<td>CAT#</td>
					<td>&nbsp;</td>
				</tr>
				<cfoutput>
					<tr>
						<td><input type="text" name="sID" size="10" maxlength="10" value="#Cookie.sID#"></td>
						<td><input type="text" name="sArtist" size="18" maxlength="30" value="#Cookie.sArtist#"></td>
						<td><input type="text" name="sTitle" size="18" maxlength="30" value="#Cookie.sTitle#"></td>
						<td><input type="text" name="sLabel" size="18" maxlength="30" value="#Cookie.sLabel#"></td>
						<td><input type="text" name="sCatnum" size="12" maxlength="20" value="#Cookie.sCatnum#"></td>
						<td><input type="submit" name="search" value=" SEARCH " /></td>
					</tr>
				</cfoutput>
			</table>
		</form>
		<p><font color="#FFCC00">You are browsing Pre-Releases</font> <a href="catalog.cfm">Click here</a> to browse the full catalog</p>
<cfform name="catResultsForm" action="#URLSessionFormat("catalogAction.cfm")#" method="post">
<cfif url.showAll><cfset showRows="-1"><cfelse><cfset showRows="100"></cfif>
<p><cfinput type="submit" name="save" value="Save Changes"></p>
	<cfquery name="catalogFind" datasource="#DSN#">
		select *
		from catItemsQuery
		where artist LIKE <cfqueryparam value="%#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
			label LIKE <cfqueryparam value="%#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
			title LIKE <cfqueryparam value="%#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
			catnum LIKE <cfqueryparam value="%#Cookie.sCatnum#%" cfsqltype="cf_sql_char"> AND
			ID LIKE <cfqueryparam value="%#Cookie.sID#%" cfsqltype="cf_sql_char"> AND
			albumStatusID=148
			order by #Cookie.orderBy# #Cookie.sortOrder#
	</cfquery>
	<table bgcolor="#CCCCCC" border="1" bordercolor="#999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<cfoutput>
		<tr valign="middle">
			<td align="center" bgcolor="##000000" class="catDisplayHead"><img src="images/email06.gif" width="14" height="11" /></td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">ART</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">MP3</td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalogDTPreRelease.cfm?#urlParam#&ob=ID&so=ASC&showAll=#url.showAll#">^</a>&nbsp;ID&nbsp;<a href="catalogDTPreRelease.cfm?ob=ID&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalogDTPreRelease.cfm?#urlParam#&ob=label&so=ASC&showAll=#url.showAll#">^</a>&nbsp;LABEL&nbsp;<a href="catalogDTPreRelease.cfm?ob=label&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalogDTPreRelease.cfm?#urlParam#&ob=catnum&so=ASC&showAll=#url.showAll#">^</a>&nbsp;CAT##&nbsp;<a href="catalogDTPreRelease.cfm?ob=catnum&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalogDTPreRelease.cfm?#urlParam#&ob=artist&so=ASC&showAll=#url.showAll#">^</a>&nbsp;ARTIST&nbsp;<a href="catalogDTPreRelease.cfm?ob=artist&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalogDTPreRelease.cfm?#urlParam#&ob=title&so=ASC&showAll=#url.showAll#">^</a>&nbsp;TITLE&nbsp;<a href="catalogDTPreRelease.cfm?ob=title&so=DESC&showAll=#url.showAll#">v</a></td>
			<td align="center" bgcolor="##000000" class="cat">ACTIVE<br />
				<a href="##" onclick="javascript:SelectAll();">ALL</a> <a href="##" onclick="javascript:SelectNone();">NONE</a></td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">SHELF</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">ONHAND</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">MEDIA</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead"><a href="catalogDTPreRelease.cfm?#urlParam#&ob=price&so=ASC&showAll=#url.showAll#">^</a>&nbsp;PRICE&nbsp;<a href="catalogDTPreRelease.cfm?ob=price&so=DESC&showAll=#url.showAll#">v</a></td>
			<td align="center" bgcolor="##000000">&nbsp;</td>
		</tr></cfoutput>
	<cfoutput query="catalogFind">
		<tr bgcolor="##666666">
			<cfset mp3Status="false">
			<cfquery name="tracks" datasource="#DSN#">
				select *
				from catTracks
				where catID=#catalogFind.ID#
			</cfquery>
			<cfif tracks.RecordCount NEQ 0>
				<cfset trackStatus="true">
				<cfdirectory directory="d:\media" filter="oT#tracks.ID#.mp3" name="trackCheck" action="list">
				<cfif trackCheck.recordCount NEQ 0>
					<cfset mp3Status="true">
				</cfif>
			</cfif>
			<td align="center" bgcolor="##000000" class="catDisplayHead"><cfif mp3Status><a href="DTItemEmail.cfm?ID=#ID#&pageBack=catalogDTPreReleases.cfm"><img src="images/email06.gif" width="14" height="11" border="0"></a><cfif url.emailsent EQ ID><br /><font size="1" color="white">SENT</font></cfif><cfelse>&nbsp;</cfif></td>
			<cfif ONHAND LTE 0><cfset oos='OOS'><cfelse><cfset oos=''></cfif>
			<cfset imagefile="labels/label_WhiteLabel.gif">
			<cfset imagefolder="">
			<cfdirectory directory="#serverPath#\images\items" filter="oI#catalogFind.ID#.jpg" name="imageCheck" action="list">
			<cfif imageCheck.recordCount NEQ 0>
				<cfset imagefile="items/" & imageCheck.name>
			<cfelseif logofile NEQ "">
				<cfdirectory directory="#serverPath#\images\labels" filter="#logofile#" name="logoCheck" action="list">
				<cfif logoCheck.recordCount NEQ 0>
					<cfset imagefile="labels/" & logoCheck.name>
				</cfif>
			</cfif>
			
  			<td align="center" valign="middle"><a href="artLoad.cfm?ID=#ID#"><img src="images/#imagefile#" width="25" height="25" border="0" /></a></td>
			<td class="catDisplay"><a href="trackLoad.cfm?ID=#ID#">LOAD</a></td>
			<td class="catDisplay"><a href="catalogEdit.cfm?ID=#ID#&pageBack=catalogDTPreReleases.cfm">#NumberFormat(ID,"0000000")#</a></td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#label#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#catnum#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#artist#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#title#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#"><input type="hidden" name="allIDs" value="#ID#" /><cfinput type="checkbox" name="activeIDs" checked="#YesNoFormat(active)#" value="#ID#"></td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#shelfCode#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#ONHAND#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#media#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#DollarFormat(price)#</td>
			<td align="center" class="catDisplay#oos#">
				<cfif ONHAND LTE 0>
					<a href="catalogBackinStock.cfm?ID=#ID#&sTitle=#Cookie.sTitle#&sArtist=#Cookie.sArtist#&sLabel=#Cookie.sLabel#&sCatnum=#Cookie.sCatnum#&pageBack=catalogDTPreReleases.cfm">MARK IN STOCK</a>
				<cfelse>
					<a href="catalogOutOfStock.cfm?ID=#ID#&sTitle=#Cookie.sTitle#&sArtist=#Cookie.sArtist#&sLabel=#Cookie.sLabel#&sCatnum=#Cookie.sCatnum#pageBack=catalogDTPreReleases.cfm">MARK OUT OF STOCK</a>
					</cfif></td>
		</tr>
	</cfoutput>
	</table>
	<cfoutput>
		<!---<input type="hidden" name="sTitle" value="#Cookie.sTitle#" />
		<input type="hidden" name="sArtist" value="#Cookie.sArtist#" />
		<input type="hidden" name="sLabel" value="#Cookie.sLabel#" />
		<input type="hidden" name="sCatnum" value="#Cookie.sCatnum#" />//--->
		
		<!---<cfif url.showAll EQ false>
			<a href="#URLSessionFormat("catalogDTPreRelease.cfm?showAll=true")#">Show All Results</a>
		<cfelse>
			<a href="#URLSessionFormat("catalogDTPreRelease.cfm?showAll=false")#">Show Max 100 Results</a>
		</cfif>//--->
	</cfoutput>
</cfform>
		<p>&nbsp; </p>
		<p>&nbsp;</p>
		<cfinclude template="pageFoot.cfm">