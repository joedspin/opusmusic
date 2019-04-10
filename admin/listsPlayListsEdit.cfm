<cfset pageName="LISTS">
<cfparam name="url.ID" default="0">
<cfparam name="form.ID" default="0">
<cfparam name="url.staff" default="false">
<cfif form.ID NEQ 0><cfset url.ID=form.ID></cfif>
<cfif url.ID NEQ 0><cfset form.ID=url.ID></cfif>
<cfparam name="form.search" default="">
<cfparam name="form.sTitle" default="">
<cfparam name="form.sArtist" default="">
<cfparam name="form.sLabel" default="">
<cfparam name="form.sCatnum" default="">
<cfparam name="form.active" default="no">
<cfparam name="form.removeItem" default="">
<cfparam name="form.insertItem" default="">
<cfparam name="form.insertTrack" default="">
<cfparam name="form.save" default="">
<cfparam name="form.done" default="">
<cfparam name="url.sTitle" default="">
<cfparam name="url.sArtist" default="">
<cfparam name="url.sLabel" default="">
<cfparam name="url.sCatnum" default="">
<cfparam name="url.so" default="">
<cfparam name="url.ob" default="">
<cfparam name="Cookie.sTitle" default="">
<cfparam name="Cookie.sArtist" default="">
<cfparam name="Cookie.sLabel" default="">
<cfparam name="Cookie.sCatnum" default="">
<cfparam name="Cookie.sID" default="">
<cfparam name="Cookie.sortOrder" default="ASC">
<cfparam name="Cookie.orderBy" default="ID">
<cfif url.sTitle NEQ ""><cfset form.sTitle=url.sTitle></cfif>
<cfif url.sArtist NEQ ""><cfset form.sArtist=url.sArtist></cfif>
<cfif url.sLabel NEQ ""><cfset form.sLabel=url.sLabel></cfif>
<cfif url.sCatnum NEQ ""><cfset form.sCatnum=url.sCatnum></cfif>
<cfif form.sTitle NEQ "" OR form.search NEQ ""><cfset Cookie.sTitle=form.sTitle></cfif>
<cfif form.sArtist NEQ "" OR form.search NEQ ""><cfset Cookie.sArtist=form.sArtist></cfif>
<cfif form.sLabel NEQ "" OR form.search NEQ ""><cfset Cookie.sLabel=form.sLabel></cfif>
<cfif form.sCatnum NEQ "" OR form.search NEQ ""><cfset Cookie.sCatnum=form.sCatnum></cfif>
<cfif url.so NEQ ""><cfset Cookie.sortOrder=url.so></cfif>
<cfif url.ob NEQ ""><cfset Cookie.orderBy=url.ob></cfif>
<cfset urlParam="sArtist=#Cookie.sArtist#&sTitle=#Cookie.sTitle#&sLabel=#Cookie.sLabel#&sCatnum=#Cookie.sCatnum#">
<cfif url.staff>
	<cfquery name="staffList" datasource="#DSN#" maxrows="1" cachedWithin="#CreateTimeSpan(1,0, 0, 0)#">
		select *
		from artistListsQuery
		where artistID=15387
		order by listDate DESC 
	</cfquery>
	<cfset thisListID=staffList.ID>
<cfelse>
	<cfset thisListID=url.ID>
</cfif>
<cfif form.done NEQ "">
	<cflocation url="listsPlayLists.cfm">
<cfelseif form.removeItem NEQ "">
	<cfquery name="removeItem" datasource="#DSN#">
		delete
		from arrtistListItems
		where ID=#form.removeItem#
	</cfquery>
<cfelseif form.insertItem NEQ "">
	<cfquery name="addItem" datasource="#DSN#">
		insert into arrtistListItems (listID, itemID, sort)
		values (
			#form.ID#, #form.insertItem#, #form.listCt+1#
		)
	</cfquery>
	<cflocation url="listsPlayListsEdit.cfm?ID=#form.ID#">
<cfelseif form.insertTrack NEQ "">
	<cfquery name="addTrack" datasource="#DSN#">
		insert into arrtistListItems (listID, trackID, sort)
		values (
			#form.ID#, #form.insertTrack#, #form.listCt+1#
		)
	</cfquery>
	<cflocation url="listsPlayListsEdit.cfm?ID=#form.ID#">
<cfelseif form.save NEQ "" OR form.removeItem NEQ "">
	<cfquery name="updateList" datasource="#DSN#">
		update artistLists
		set
			listName=<cfqueryparam value="#form.listName#" cfsqltype="cf_sql_char">,
			listDate=<cfqueryparam value="#form.listDate#" cfsqltype="cf_sql_date">,
			active=<cfqueryparam value="#form.active#" cfsqltype="cf_sql_bit">
		where ID=#form.ID#
	</cfquery>
	<cfquery name="listItems" datasource="#DSN#">
		select *
		from artistListsItemsQuery
		where listID=#form.ID#
		order by sort
	</cfquery>
	<cfloop query="listItems">
		<cfif sort NEQ Evaluate("form.listSort" & ID)>
			<cfquery name="updateItem" datasource="#DSN#">
				update arrtistListItems
				set sort=<cfqueryparam value="#Evaluate("form.listSort" & ID)#" cfsqltype="cf_sql_char">
				where ID=#listItems.ID#
			</cfquery>
		</cfif>
	</cfloop>
	<cflocation url="listsPlayListsEdit.cfm?ID=#form.ID#">
</cfif>
<cfinclude template="pageHead.cfm">
<cfquery name="thisList" datasource="#DSN#">
	select *
	from artistListsQuery
	where ID=#thisListID#
</cfquery>
<cfquery name="thisListItems" datasource="#DSN#">
	select *
	from artistListsItemsQuery
	where listID=#thisListID#
	order by sort
</cfquery>
<!---<cfquery name="allArtists" datasource="#DSN#">
	select *
	from artists
	order by sort, name
</cfquery>//--->
<cfform name="chooseArtist" method="post" action="#URLSessionFormat("listsPlayListsEdit.cfm")#">
<cfoutput query="thisList">
	<p><b>Artist</b><br /><font size="3">#artist#</font>
	<!---<cfselect query="allArtists" display="name" value="ID" name="artistID" selected="#thisList.artistID#"></cfselect>//---><br />
	<b>List Name: </b><br />
	<cfinput type="text" name="listName" size="40" maxlength="50" value="#thisList.listName#"><br />
	<b>List Date: </b><cfinput type="text" name="listDate" size="15" maxlength="10" value="#DateFormat(thisList.listDate,"mm/dd/yy")#"><br />
	<b>Active: </b><br />
	<cfinput type="checkbox" name="active" value="yes" checked="#YesNoFormat(thisList.active)#"></p>
</cfoutput>
<table border=0 cellpadding=10 cellspacing=0 style="border-collapse:collapse;">
	<tr>
		<td width="50%" valign="top">
			<cfoutput>
			<table width="100%" border="1" cellpadding="2" cellspacing="0" bordercolor="##FFFFFF" style="border-collapse:collapse;">
				<tr bgcolor="##000000">
					<td>artist<br />
						<input type="text" name="sArtist" size="18" maxlength="30" value="#Cookie.sArtist#"></td>
					<td>title<br />
					<input type="text" name="sTitle" size="18" maxlength="30" value="#Cookie.sTitle#"></td>
					<td rowspan="2" align="center"><input type="submit" name="search" value=" SEARCH " /></td>
				</tr>
				<tr bgcolor="##000000">
					<td>label<br />
						<input type="text" name="sLabel" size="18" maxlength="30" value="#Cookie.sLabel#"></td>
					<td>CAT##<br />
						<input type="text" name="sCatnum" size="12" maxlength="20" value="#Cookie.sCatnum#"></td>
				</tr>
			</table>
			</cfoutput>
			<cfquery name="catalogFind" datasource="#DSN#" maxrows="100">
				select *
				from catItemsQuery
				where artist LIKE <cfqueryparam value="%#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
					label LIKE <cfqueryparam value="%#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
					title LIKE <cfqueryparam value="%#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
					catnum LIKE <cfqueryparam value="%#Cookie.sCatnum#%" cfsqltype="cf_sql_char"> AND
					 ONSIDE<>999
					order by #Cookie.orderBy# #Cookie.sortOrder#
			</cfquery>
			<table border=1 cellpadding=3 cellspacing=0 style="border-collapse:collapse;" width="100%">
			<cfoutput query="catalogFind">
				<tr>
					<td>#artist#</td>
					<td>#title#</td>
					<td>#label#</td>
					<td>#catnum#</td>
					<td>add item <input type="submit" name="insertItem" value="#ID#" />
				</tr>
				<cfquery name="tracks" datasource="#DSN#">
					select *
					from catTracks
					where catID=#catalogFind.ID#
					order by tSort
				</cfquery>
				<cfloop query="tracks">
				<tr>
					<td>&nbsp;</td>
					<td colspan="2" align="left">#tName#</td>
					<td>add track <input type="submit" name="insertTrack" value="#tracks.ID#" /></td>
					<td>&nbsp;</td>
				</tr>
			  </cfloop>
			</cfoutput>
			</table>
		</td>
		<td width="50%" valign="top">
			<table border=1 cellpadding=3 cellspacing=0 style="border-collapse:collapse;">
			<tr>
				<td colspan="4">LIST CONTENTS</td>
			</tr>
			<cfset listCt=0>
			<cfoutput query="thisListItems">
			<cfif jpgLoaded EQ 1>
				<cfset imagefile="items/oI#itemID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
    		<cfelseif itemLogofile NEQ "">
				<cfset imagefile="labels/"&itemLogofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
				<cfset listCt=listCt+1>
				<tr>
					<td><cfinput type="text" name="listSort#thisListItems.ID#" size="8" maxlength="2" value="#listCt#">
					<td><img src="../images/#imagefile#" width="25" height="25" border="0" alt=""></td>
					<td><cfif trackID NEQ 0><b>#trackArtist#</b><br />#tName#<cfelse><b>#itemArtist#</b><br />#itemTitle#</cfif></b></td>
					<td>REMOVE <input type="submit" name="removeItem" value="#thisListItems.ID#" />
				</tr>
				</cfoutput>
			</table>
			<cfoutput>
				<input type="hidden" name="listCt" value="#listCt#" />
				<input type="hidden" name="ID" value="#thisListID#">
				<p><cfinput type="submit" name="save" value=" Save List "> <cfinput type="submit" name="done" value=" Done "></p>
			</cfoutput>
		</td>
	</tr>
</table>
	
</cfform>
<cfinclude template="pageFoot.cfm">