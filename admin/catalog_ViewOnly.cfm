<!---<cfsetting requesttimeout="6000">//--->
<cfset pageName="CATALOG">
<cfparam name="form.vSubmit" default="">
<cfparam name="form.search" default="">
<cfparam name="form.sTitle" default="">
<cfparam name="form.sDiscogsID" default="">
<cfparam name="form.sArtist" default="">
<cfparam name="form.sLabel" default="">
<cfparam name="form.sCatnum" default="">
<cfparam name="form.sActive" default="">
<cfparam name="form.sDiscogs" default="">
<cfparam name="form.sID" default="">
<cfparam name="form.vID" default="">
<cfparam name="form.vendorID" default="0">
<cfparam name="Cookie.sDiscogsID" default="">
<cfparam name="Cookie.sTitle" default="">
<cfparam name="Cookie.sArtist" default="">
<cfparam name="Cookie.sLabel" default="">
<cfparam name="Cookie.sCatnum" default="">
<cfparam name="Cookie.sActive" default="Active">
<cfparam name="Cookie.sID" default="">
<cfparam name="Cookie.sortOrder" default="DESC">
<cfparam name="Cookie.vendorID" default="0">
<cfparam name="Cookie.orderBy" default="ID">
<cfparam name="Cookie.vID" default="">
<cfparam name="url.pricelist" default="">
<cfparam name="url.showAll" default="true">
<cfparam name="url.sDiscogsID" default="">
<cfparam name="url.sTitle" default="">
<cfparam name="url.sArtist" default="">
<cfparam name="url.sLabel" default="">
<cfparam name="url.sCatnum" default="">
<cfparam name="url.sActive" default="">
<cfparam name="url.sID" default="">
<cfparam name="url.vID" default="">
<cfparam name="url.so" default="">
<cfparam name="url.ob" default="">
<cfparam name="url.emailsent" default="">
<cfparam name="url.special" default="">
<cfparam name="url.backtoreg" default="">
<cfparam name="url.addOS" default="0">
<cfparam name="url.ID" default="0">
<cfparam name="url.findDT161Dups" default="false">
<cfparam name="url.dtdelete" default="0">
<cfparam name="url.dterase" default="0">
<cfparam name="url.stype" default="">
<cfparam name="url.showAll" default="no">
<!---<cfif url.dtdelete NEQ 0>
	<cfquery name="dtdelete" datasource="#DSN#">
    	delete
        from catItems
        where ID=#url.dtdelete#
    </cfquery>
</cfif>
<cfif url.dterase NEQ 0>
	<cfquery name="dterase" datasource="#DSN#">
    	update catItems
        set dtID=0
        where ID=#url.dterase#
    </cfquery>
</cfif>//--->
<cfif url.addOS NEQ 0>
	<cfquery name="addOS" datasource="#DSN#">
    	update catItems
        set ONSIDE=ONSIDE+#url.addOS#
        where ID=#url.ID#
    </cfquery>
</cfif>
<cfif url.sDiscogsID NEQ ""><cfset form.sDiscogsID=url.sDiscogsID></cfif>
<cfif url.sTitle NEQ ""><cfset form.sTitle=url.sTitle></cfif>
<cfif url.sArtist NEQ ""><cfset form.sArtist=url.sArtist></cfif>
<cfif url.sLabel NEQ ""><cfset form.sLabel=url.sLabel></cfif>
<cfif url.sCatnum NEQ ""><cfset form.sCatnum=url.sCatnum></cfif>
<cfif url.sActive NEQ ""><cfset form.sActive=url.sActive></cfif>
<cfif url.sID NEQ ""><cfset form.sID=url.sID></cfif>
<cfif url.vID NEQ ""><cfset form.vID=url.vID></cfif>
<cfif form.sDiscogsID NEQ "" OR form.search NEQ ""><cfset Cookie.sDiscogsID=form.sDiscogsID></cfif>
<cfif form.sTitle NEQ "" OR form.search NEQ ""><cfset Cookie.sTitle=form.sTitle></cfif>
<cfif form.sArtist NEQ "" OR form.search NEQ ""><cfset Cookie.sArtist=form.sArtist></cfif>
<cfif form.sLabel NEQ "" OR form.search NEQ ""><cfset Cookie.sLabel=form.sLabel></cfif>
<cfif form.sCatnum NEQ "" OR form.search NEQ ""><cfset Cookie.sCatnum=form.sCatnum></cfif>
<cfif form.sActive NEQ "" OR form.search NEQ ""><cfset Cookie.sActive=form.sActive></cfif>
<cfif form.vendorID NEQ "0"><cfset Cookie.vendorID=form.vendorID></cfif>
<cfif form.sID NEQ "" OR form.search NEQ ""><cfset Cookie.sID=form.sID></cfif>
<cfif form.vID NEQ "" OR form.search NEQ ""><cfset Cookie.vID=form.vID></cfif>
<cfif url.so NEQ ""><cfset Cookie.sortOrder=url.so></cfif>
<cfif url.ob NEQ ""><cfset Cookie.orderBy=url.ob></cfif>
<cfif url.ob EQ "label"><cfset orderString="label "&Cookie.sortOrder&", catnum "&Cookie.sortOrder><cfelse><cfset orderString=Cookie.orderBy&" "&Cookie.sortOrder></cfif>
<cfif form.vSubmit NEQ ""><cflocation url="vendorIDtest.cfm"></cfif>
<cfset urlParam="sArtist=#Cookie.sArtist#&sTitle=#Cookie.sTitle#&sLabel=#Cookie.sLabel#&sCatnum=#Cookie.sCatnum#&sActive=#Cookie.sActive#&sID=#Cookie.sID#&sDiscogsID=#Cookie.sDiscogsID#&vID=#Cookie.vID#">
<cfif url.showAll><cfset showRows="-1"><cfelse><cfset showRows="50"></cfif>
<cfif Cookie.sActive EQ "Active"><cfset activeString=" AND (ONHAND>0 OR ONSIDE>0) AND ONSIDE<>999"><cfelseif Cookie.sActive EQ "304"><cfset activeString=" AND shelfID NOT IN (7,11,13) AND (ONHAND>0 OR ONSIDE>0) AND ONSIDE<>999"><cfelseif Cookie.sActive EQ "161"><cfset activeString=" AND shelfID=11 AND (ONHAND>0 OR ONSIDE>0) AND albumStatusID<25"><cfelse><cfset activeString=""></cfif>

<cfinclude template="pageHead.cfm">
<style>
<!--//
input {font-size: small; }
td {font-size: small; }
body {font-size: small; }
//--->
</style>
<!---<cfquery name="DT161PriceZeroes" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select *
    from catItemsQuery
    where dtID<>0 AND buy=0 AND albumStatusID<>148
</cfquery>
<cfoutput query="DT161PriceZeroes">
<p><font color="red">WARNING: #catnum# has a $0.00 Sell Price for DT161 <a href="catalogEdit.cfm?ID=#ID#">CLICK HERE TO EDIT</a></font></p></cfoutput>//--->
<!--- If the gridEntered form field exists, the form was submitted.
		Perform gridupdate. --->
		<!---<cfquery name="catalogFind" datasource="#DSN#" maxrows="#showRows#">
		select DISTINCT ID, *
		from ((((catItemsQuery LEFT JOIN sumBought ON catItemIDBought=ID) LEFT JOIN sumSold ON catItemIDSold=ID) LEFT JOIN sumPending ON catItemIDPending=ID) LEFT JOIN sumBackorder ON catItemIDBackorder=ID)
		where catItemsQuery.artist LIKE <cfqueryparam value="%#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.label LIKE <cfqueryparam value="%#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.title LIKE <cfqueryparam value="%#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.catnum LIKE <cfqueryparam value="%#Cookie.sCatnum#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.dtID LIKE <cfqueryparam value="%#Cookie.sID#%" cfsqltype="cf_sql_char"> #activeString#
			order by catItemsQuery.#Cookie.orderBy# #Cookie.sortOrder#
	</cfquery>//--->
    <cfif url.special EQ "special">
    	<cfquery name="catalogFind" datasource="#DSN#">
        	select *, discogsID As oxID
            from catItemsQuery
            where specialItem=1
            order by #orderString#
        </cfquery>
    <cfelseif url.findDT161Dups EQ "true">
         <cfquery name="catalogFind" datasource="#DSN#">
        	select *, discogsID As oxID
            from catItemsQuery
            where dtID IN (SELECT dtID
            FROM catItems
            where dtID<>0
            GROUP BY dtID, catnum
            HAVING ( COUNT(dtID) > 1 ))
            order by catnum
        </cfquery>
    <cfelseif Cookie.vendorID NEQ 0 and form.search EQ "">
        <cfquery name="catalogFind" datasource="#DSN#">
            select *, discogsID As oxID
            from catItemsQuery where ID IN
            (select catItemID from purchaseOrderDetailsQuery
            where vendorID=#Cookie.vendorID# and completed<>1 AND qtyRequested<>0 AND qtyRequested>qtyReceived)
            order by catnum
        </cfquery>
    <cfelse>
    	<cfif Cookie.vID NEQ "">
            <cfquery name="catalogFind" datasource="#DSN#" maxrows="#showRows#">
                select  *, discogsID As oxID
                from catItemsQuery
                where vendorID=#Cookie.vID# AND 
                artist LIKE <cfqueryparam value="%#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
                    label LIKE <cfqueryparam value="%#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
                    title LIKE <cfqueryparam value="%#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
                    catnum LIKE <cfqueryparam value="%#Cookie.sCatnum#%" cfsqltype="cf_sql_char"> #activeString#
                order by #orderString#
            </cfquery>
        <cfelseif Cookie.sDiscogsID NEQ "" AND form.search NEQ " LEFT SEARCH " AND url.stype NEQ "left">
        	<cfset showRows=20>
            <cfquery name="catalogFind" datasource="#DSN#" maxrows="#showRows#">
                select  *, discogsID As oxID
                from catItemsQuery
                where discogsID=#Cookie.sDiscogsID# AND
                	artist LIKE <cfqueryparam value="%#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
                    label LIKE <cfqueryparam value="%#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
                    title LIKE <cfqueryparam value="%#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
                    catnum LIKE <cfqueryparam value="%#Cookie.sCatnum#%" cfsqltype="cf_sql_char"> #activeString#
                order by releaseDate
            </cfquery>
        <cfelseif Cookie.sDiscogsID NEQ "" AND (form.search EQ " LEFT SEARCH " OR url.stype EQ "left")>
        	<cfset showRows=20>
            <cfquery name="catalogFind" datasource="#DSN#" maxrows="#showRows#">
                select  *, discogsID As oxID
                from catItemsQuery 
                where discogsID=#Cookie.sDiscogsID# AND
                	artist LIKE <cfqueryparam value="#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
                    label LIKE <cfqueryparam value="#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
                    title LIKE <cfqueryparam value="#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
                    catnum LIKE <cfqueryparam value="#Cookie.sCatnum#%" cfsqltype="cf_sql_char">
                     #activeString#
                    order by releaseDate
            </cfquery>
        <cfelseif form.search EQ " LEFT SEARCH " OR url.stype EQ "left">
        	<cfquery name="catalogFind" datasource="#DSN#" maxrows="#showRows#">
                select  *, discogsID As oxID
                from catItemsQuery 
                where artist LIKE <cfqueryparam value="#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
                    label LIKE <cfqueryparam value="#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
                    title LIKE <cfqueryparam value="#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
                    catnum LIKE <cfqueryparam value="#Cookie.sCatnum#%" cfsqltype="cf_sql_char">
                     #activeString#
                    order by #OrderString#
            </cfquery>
        <cfelseif url.pricelist EQ "odd">
        	<cfquery name="catalogFind" datasource="#DSN#" maxrows="#showRows#">
                select  *, discogsID As oxID
                from catItemsQuery 
                where right(price,1)<>9 AND (ONHAND>0 OR ONSIDE>0) AND ONSIDE<>999 AND shelfID NOT IN (7,11,13)
                    order by #OrderString#
            </cfquery>
        <cfelse>
            <cfquery name="catalogFind" dbtype="query" maxrows="#showRows#">
                select  *, discogsID As oxID
                from allItems
                where LOWER(artist) LIKE '%#LCase(Cookie.sArtist)#%' AND
                    LOWER(label) LIKE '%#LCase(Cookie.sLabel)#%' AND
                    LOWER(title) LIKE '%#LCase(Cookie.sTitle)#%' AND
                    LOWER(catnum) LIKE '%#LCase(Cookie.sCatnum)#%'
                     #activeString#
                    order by #OrderString#
            </cfquery>
        </cfif>
        <cfset Cookie.vendorID=0>
    </cfif>
    <a href="catalog_ViewOnly.cfm?showAll=yes">Show All</a>
			<cfform id="sForm" name="sForm" method="post" action="catalog_ViewOnly.cfm">
			<table border="1" cellpadding="2" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse:collapse;">
				<!---<tr bgcolor="#000000">
					<td>CAT#</td>
                    <td>LABEL</td>
                    <td>ARTIST</td>
					<td>TITLE</td>
                    <td>DISCOGS ID</td>
					<td>VENDOR ID</td>
                    
				</tr>//--->
				<cfoutput>
					<tr>
						<td>CAT ##<br /><input type="text" name="sCatnum" size="12" maxlength="20" value="#Cookie.sCatnum#"></td>
						<td>LABEL<br /><input type="text" name="sLabel" size="18" maxlength="30" value="#Cookie.sLabel#"></td>
						<td>ARTIST<br /><input type="text" name="sArtist" size="23" maxlength="30" value="#Cookie.sArtist#"></td>
						<td>TITLE<br /><input type="text" name="sTitle" size="20" maxlength="30" value="#Cookie.sTitle#"></td>
						
                        <td align="center" nowrap ><input type="radio" name="sActive" value="Active"<cfif Cookie.sActive EQ "Active"> checked</cfif>> Active <input type="radio" name="sActive" value="304"<cfif Cookie.sActive EQ "304"> checked</cfif>> 304<br /><input type="radio" name="sActive" value="161"<cfif Cookie.sActive EQ "161"> checked</cfif>> 161 &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sActive" value="All"<cfif Cookie.sActive EQ "All"> checked</cfif>> All&nbsp;</td>
                    <td  align="center" valign="middle"><input type="submit" name="search" value=" SEARCH " tabindex="1" style="font-size: small;" /><br /><input type="button" name="clear" value="  CLEAR   " style="font-size: small;"  onclick="clearBoxes();" /></td>
                    <cfquery name="vendorsCat" datasource="#DSN#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
                            select *
                            from shelf
                            order by partner
                        </cfquery>
          <!---<td  align="center"><input type="submit" name="search" value=" LEFT SEARCH " tabindex="1" style="font-size: small;" /><br /><cfselect query="vendorsCat" name="vendorID" value="ID" display="partner" class="inputBox" selected="#form.vendorID#" onChange="javascript:sForm.submit();" style="font-size: small;" ><option id="vendor0" value="0" <cfif Cookie.vendorID EQ 0> selected</cfif>>No Vendor</option></cfselect></td>//--->
          <td>DISCOGS ID<br /><input type="text" name="sDiscogsID" size="10" maxlength="12" value="#Cookie.sDiscogsID#"></td><td>VENDOR ID<br /><input type="text" name="vID" size="10" maxlength="10" value="#Cookie.vID#"><input type="submit" name="vsubmit" value="&radic;" style="font-size: small;"  tabindex="100" /></td>
                        </tr>
				</cfoutput>
			</table>
		</cfform>
<cfform name="catResultsForm" action="catalogAction.cfm" method="post">
	<input type="hidden" name="itemID" id="itemID" value="0" />
    <cfoutput><input type="hidden" name="vendorID" id="vendorID" value="#Cookie.vendorID#" /></cfoutput>
	<cfif Cookie.sArtist NEQ "" OR Cookie.vendorID NEQ 0 OR Cookie.sDiscogsID NEQ "" OR Cookie.sLabel NEQ "" OR Cookie.sTitle NEQ "" OR Cookie.sCatnum NEQ "" OR Cookie.vID NEQ "">
	<table border="1" bordercolor="#999999" cellpadding="3" cellspacing="0" style="border-collapse:collapse;" width="100%">
		<cfoutput>
		<tr valign="middle">
			<td class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=catnum&so=ASC&showAll=#url.showAll#">^</a>&nbsp;CAT##&nbsp;<a href="catalog.cfm?ob=catnum&so=DESC&showAll=#url.showAll#">v</a></td>
			<td class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=label&so=ASC&showAll=#url.showAll#">^</a>&nbsp;LABEL&nbsp;<a href="catalog.cfm?ob=label&so=DESC&showAll=#url.showAll#">v</a></td>
			<td class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=artist&so=ASC&showAll=#url.showAll#">^</a>&nbsp;ARTIST&nbsp;<a href="catalog.cfm?ob=artist&so=DESC&showAll=#url.showAll#">v</a></td>
			<td class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=title&so=ASC&showAll=#url.showAll#">^</a>&nbsp;TITLE&nbsp;<a href="catalog.cfm?ob=title&so=DESC&showAll=#url.showAll#">v</a></td>
			<td align="center" class="catDisplayHead">MEDIA</td>
			<td align="center" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=price&so=ASC&showAll=#url.showAll#">^</a>&nbsp;PRICE&nbsp;<a href="catalog.cfm?ob=price&so=DESC&showAll=#url.showAll#">v</a></td>
			
		</tr></cfoutput>
        <cfset rowCount=0>
	<cfoutput query="catalogFind">
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
	
</cfif>
<p><cfinput type="submit" name="save" value="Save Changes"></p>
</cfform>
<cfoutput>
		<!---<input type="hidden" name="sTitle" value="#Cookie.sTitle#" />
		<input type="hidden" name="sArtist" value="#Cookie.sArtist#" />
		<input type="hidden" name="sLabel" value="#Cookie.sLabel#" />
		<input type="hidden" name="sCatnum" value="#Cookie.sCatnum#" />//--->
        <cfif url.stype EQ "left" OR form.search EQ " LEFT SEARCH "><cfset stypeurl="&stype=left"><cfelse><cfset stypeurl=""></cfif>
		<p><cfif url.showAll EQ false>
			<a href="catalog.cfm?showAll=true#stypeurl#">Show All Results</a>
		<cfelse>
			<a href="catalog.cfm?showAll=false#stypeurl#">Show Max 100 Results</a>
		</cfif><br />
	</cfoutput>		
      <!---  <a href="cleanOldMP3s.cfm">Clean Old MP3 Files from Server</a></p>//--->
		<cfinclude template="pageFoot.cfm">