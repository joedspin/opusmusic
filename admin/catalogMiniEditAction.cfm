<cfparam name="form.artistID" default="0">
<cfparam name="form.genreID" default="0">
<cfparam name="form.reissue" default="No">
<cfparam name="form.addArtistName" default="">
<cfparam name="form.addtrx" default="0">
<cfparam name="form.dtID" default="0">
<cfif form.dtID EQ ""><cfset form.dtID="0"></cfif>
<cfparam name="form.tCt" default="0">
<cfparam name="form.price" default="0.00">
<cfparam name="form.cost" default="0.00">
<cfparam name="form.CONDITION_MEDIA_ID" default="1">
<cfparam name="form.CONDITION_COVER_ID" default="1">
<cfparam name="form.description" default="">
<cfparam name="form.trackID" default="">
<cfparam name="form.uploadFile" default="">
<cfparam name="form.cancel" default="">
<cfparam name="form.deleteItem" default="">
<cfparam name="form.done" default="">
<cfparam name="form.dup" default="">
<cfparam name="form.promo" default="">
<cfparam name="form.merge" default="">
<cfparam name="form.loadTracks" default="">
<cfparam name="form.loadArt" default="">
<cfparam name="form.fixTitleCase" default="">
<cfparam name="form.calcPrice" default="">
<cfparam name="form.active" default="No">
<cfparam name="form.weightException" default="0">
<cfparam name="form.ONSIDE" default="0">
<cfparam name="form.addONSIDE" default="0">
<cfparam name="form.addONHAND" default="0">
<cfparam name="form.ONORDER" default="0">
<cfparam name="form.addONHANDshelfID" default="0">
<cfparam name="form.title" default="">
<cfparam name="form.hideTracks" default="No">
<cfparam name="form.noReorder" default="No">
<cfparam name="form.specialItem" default="No">
<cfparam name="form.itemTitle" default="#form.title#">
<cfparam name="form.pageBack" default="catalog.cfm">
<cfparam name="form.sendBackorder" default="no">
<cfparam name="form.buy" default="0">
<cfparam name="form.blueDate" default="">
<cfparam name="form.blue99" default="no">
<cfparam name="form.discogsID" default="0">
<cfparam name="form.releaseDateLock" default="0">
<cfparam name="form.notNew304" default="No">
<cfif form.sendBackorder EQ "yes">
	<cfquery name="backorders" datasource="#DSN#">
        select *
        from orderItemsQuery
        where catItemID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char"> AND adminAvailID=3 AND statusID<>7 AND backorderNoticeSent=0
    </cfquery>
    <cfif backorders.recordCount GT 0>
        <cfloop query="backorders">
        <cfquery name="customer" datasource="#DSN#">
            select *
            from custAccounts
            where ID=#custID#
        </cfquery>
        <cfset itemDescrip="#artist# #title# (#NRECSINSET#x#media#) [#label# - #catnum#]">
            <cfmail query="customer" to="#email#" from="info@downtown304.com" bcc="order@downtown304.com" subject="BACKORDERED ITEMS Back In Stock" type="html">
    <p>#firstName#,</p>
    <p>This item, which you have on backorder, is now available again:</p>
    <p>#itemDescrip#</p>
    <p>You can manage your backorders in the "My Account" section after you login on our website. Move this item to your cart, or REMOVE it from backorder there.</p>
    <p><a href="http://www.downtown304.com">Downtown304.com</a></p>
            </cfmail>
            </cfloop>
        </cfif>
</cfif>
<!---<cfset thisAlbumStatusID=form.albumStatusID>//--->
<cfset thisReleaseDate=form.releaseDate>
<cfset thisDateUpdated=form.releaseYear>
<cfif form.addONSIDE EQ 999 OR form.addONSIDE EQ -999>
	<cfif form.addONSIDE EQ -999><cfset thisAOS=0><cfelse><cfset thisAOS=999></cfif>
	<cfquery name="onside999" datasource="#DSN#">
    	update catItems
        set ONSIDE=#thisAOS#
        where ID=#form.ID#
    </cfquery>
    <cfquery name="audit999" datasource="#DSN#">
    	insert into catRcvd (catItemID, dateReceived, qtyRcvd, rcvdShelfID, rcvdUserID)
        values (#form.ID#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,#form.addONSIDE#,7,#Session.userID#)
    </cfquery>
<cfelseif form.addONSIDE NEQ 0>
	<cfquery name="auditONSIDE" datasource="#DSN#">
    	insert into catRcvd (catItemID, dateReceived, qtyRcvd, rcvdShelfID, rcvdUserID)
        values (#form.ID#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,#form.addONSIDE#,7,#Session.userID#)
    </cfquery>
</cfif>
<cfset thisONORDER=form.ONORDER>
<cfif form.addONHAND NEQ 0>
	<cfif form.addONHANDshelfID EQ 0><p><font color="red">ERROR!!!!!</font> You did not specify a Vendor for catalog received. Click back and try again.</p><cfabort></cfif>
    <cfquery name="auditONHAND" datasource="#DSN#">
    	insert into catRcvd (catItemID, dateReceived, qtyRcvd, rcvdShelfID, rcvdUserID)
        values (#form.ID#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,#form.addONHAND#,#form.addONHANDshelfID#,#Session.userID#)
    </cfquery>
    <cfquery name="updateONHAND" datasource="#DSN#">
    	update catItems
        set ONHAND=ONHAND+<cfqueryparam value="#form.addONHAND#" cfsqltype="cf_sql_char">
       	where ID=#form.ID#
    </cfquery>
    <!---<cfif form.ONORDER NEQ 0 AND form.addONHAND GT 0 AND addONHANDshelfID NEQ 24>
		<cfset thisONORDER=thisONORDER-form.addONHAND>
    </cfif>//--->
    <cfquery name="purchOrderEntries" datasource="#DSN#">
    	select *
        from purchaseOrderDetails
        where catItemID=#form.ID# AND qtyRequested > qtyReceived AND completed=0 AND vendorID=#form.addONHANDshelfID# order by dateRequested DESC
    </cfquery>
    <cfset todayRQty=form.addONHAND>
    <cfloop query="purchOrderEntries">
    	<cfset thisPOID=POItem_ID>
    	<cfset thisOnOrderQTY=qtyRequested-qtyReceived>
        <cfif todayRQty LT thisOnOrderQTY AND todayRQty GT 0>
            <cfquery name="adjustPO" datasource="#DSN#">
            	update purchaseOrderDetails
                set qtyReceived=#qtyReceived+todayRQty#
                where POItem_ID=#thisPOID#
            </cfquery>
            <cfset todayRQty=0>
        <cfelseif todayRQty EQ thisOnOrderQTY AND todayRQty GT 0>
            <cfquery name="adjustPO" datasource="#DSN#">
            	update purchaseOrderDetails
                set qtyReceived=qtyRequested, completed=1, dateReceived=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
                where POItem_ID=#thisPOID#
            </cfquery>
            <cfset todayRQty=0>
		<cfelseif todayRQty GT 0>
            <cfquery name="adjustPO" datasource="#DSN#">
            	update purchaseOrderDetails
                set qtyReceived=qtyRequested, completed=1, dateReceived=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
                where POItem_ID=#thisPOID#
            </cfquery>
			<cfset todayRQty=todayRQty-thisOnOrderQTY>
        </cfif>
    </cfloop>
    <cfif form.albumStatusID EQ 44>
    	<cfset thisAlbumStatusID=21>
        <cfset thisReleaseDate=#varDateODBC#>
        <cfset thisDateUpdated=#varDateODBC#>
     <cfelseif form.albumStatusID EQ 25 AND form.ONHAND LTE 0>
     	<cfset thisAlbumStatusID=23>
        <cfset thisDateUpdated=#varDateODBC#>
     <cfelse>
     	<cfset thisDateUpdated=#varDateODBC#>
     </cfif>
</cfif>
<cfif form.ONORDER NEQ 0>
    <cfquery name="purchaseOrder" datasource="#DSN#">
    	insert into purchaseOrderDetails (PO_ID, catItemID, vendorID, qtyRequested, dateRequested, completed, requestedUserID, customerID)
        values (0,#form.ID#,#form.addONORDERshelfID#,#form.ONORDER#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,0,#Session.userID#,#form.ONORDERcustID#)
    </cfquery>
</cfif>
<cfif form.merge NEQ "">
	<cflocation url="catalogMerge.cfm?ID=#form.ID#">
</cfif>
<cfif form.calcPrice NEQ "">
	<cfset thisPrice=DollarFormat(Replace(form.cost,"$","","all")*1.4)>
<cfelse>
	<cfset thisPrice=form.price>
</cfif>
<cfif form.fixTitleCase NEQ "">
	<cfset newTitle=UCase(Left(form.itemTitle,1))&LCase(Right(form.itemTitle,Len(form.itemTitle)-1))>
	<cfset spacePos=Find(" ",newTitle)>
	<cfloop condition="spacePos NEQ 0">
		<cfif spacePos EQ Len(newTitle)-1>
			<cfset newTitle=Left(newTitle,spacePos)&UCase(Right(newTitle,1))>
		<cfelse>
			<cfset newTitle=Left(newTitle,spacePos)&UCase(Mid(newTitle,spacePos+1,1))&LCase(Right(newTitle,Len(newTitle)-spacePos-1))>
		</cfif>
		<!---<cfoutput>#spacePos#</cfoutput> ... //--->
		<cfset spacePos=Find(" ",newTitle,spacePos+1)>
	</cfloop>
    <cfset parenPos=Find("(",newTitle)>
    <cfloop condition="parenPos NEQ 0">
		<cfif parenPos EQ Len(newTitle)-1>
			<cfset newTitle=Left(newTitle,parenPos)&UCase(Right(newTitle,1))>
		<cfelse>
			<cfset newTitle=Left(newTitle,parenPos)&UCase(Mid(newTitle,parenPos+1,1))&Right(newTitle,Len(newTitle)-parenPos-1)>
		</cfif>
		<!---<cfoutput>#parenPos#</cfoutput> ... //--->
		<cfset parenPos=Find("(",newTitle,parenPos+1)>
	</cfloop>
	<cfset newTitle=Replace(newTitle," The "," the ","all")>
	<cfset newTitle=Replace(newTitle," A "," a ","all")>
	<cfset newTitle=Replace(newTitle," Of "," of ","all")>
	<cfset newTitle=Replace(newTitle," And "," and ","all")>
	<cfset newTitle=Replace(newTitle," On "," on ","all")>
	<cfset newTitle=Replace(newTitle," For "," for ","all")>
	<cfset newTitle=Replace(newTitle," Ft. "," feat. ","all")>
   	<cfset newTitle=Replace(newTitle," Ft "," feat. ","all")>
	<cfset newTitle=Replace(newTitle,"Feat. ","feat. ","all")>
	<cfset newTitle=Replace(newTitle,"Presents ","presents ","all")>
	<cfset newTitle=Replace(newTitle," In "," in ","all")>
	<cfset newTitle=Replace(newTitle," With "," with ","all")>
	<cfset newTitle=Replace(newTitle," Ep "," EP ","all")>
	<cfset newTitle=Replace(newTitle,"Dj ","DJ ","all")>
	<cfif Right(newTitle,3) EQ " Ep">
		<cfset newTitle=Left(newTitle,Len(newTitle)-3)&" EP">
	</cfif>
<cfelse>
	<cfset newTitle=form.itemTitle>
</cfif>
<cfif form.deleteItem NEQ "">
	<cflocation url="catalogDelete.cfm?ID=#form.ID#&pageBack=#form.pageBack#">
</cfif>
<cfif form.artistID EQ "0">
	<cfif form.addArtistName NEQ "">
		<cfquery name="addArtist" datasource="#DSN#">
			insert into artists (name)
			values (
				<cfqueryparam value="#form.addArtistName#" cfsqltype="cf_sql_char">
			)
		</cfquery>
		<cfquery name="getArtistID" datasource="#DSN#">
			select Max(ID) as newID
			from artists
			where name=<cfqueryparam value="#form.addArtistName#" cfsqltype="cf_sql_char">
		</cfquery>
		<cfset form.artistID="#getArtistID.newID#">
	</cfif>
</cfif>
<cfset tracks=false>
<cfif form.tCt GT 0>
	<cfloop from="1" to="#form.tCt#" index="tCt">
		<cfparam name="form.tName#tCt#" default="">
		<cfif Evaluate("form.tID"&tCt) EQ "0">
			<cfif Evaluate("form.tName"&tCt) NEQ "">
				<cfquery name="addTrack" datasource="#DSN#">
					insert into catTracks (catID, tName, tSort, mp3Alt)
					values (
						<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">,
						<cfqueryparam value="#Evaluate("form.tName"&tCt)#" cfsqltype="cf_sql_char">,
						<cfqueryparam value="#Evaluate("form.tSort"&tCt)#" cfsqltype="cf_sql_char">,
						0
					)
				</cfquery>
				<cfset tracks=true>
			</cfif>
		<cfelse>
			<cfif Evaluate("form.tName"&tCt) NEQ "">
				<cfquery name="editTrack" datasource="#DSN#">
					update catTracks
					set tName=<cfqueryparam value="#Evaluate("form.tName"&tCt)#" cfsqltype="cf_sql_char">,
						tSort=<cfqueryparam value="#Evaluate("form.tSort"&tCt)#" cfsqltype="cf_sql_char">
					where ID=#Evaluate("form.tID"&tCt)#
				</cfquery>
				<cfset tracks=true>
			<cfelse>
				<cfquery name="deleteTrack" datasource="#DSN#">
					delete
					from catTracks
					where ID=#Evaluate("form.tID"&tCt)#
				</cfquery>
			</cfif>
		</cfif>
	</cfloop>
</cfif>
<cfif tracks AND form.shelfID EQ 7>
	<cfset form.shelfID=11>
</cfif>
<cfset thisONSIDE=form.ONSIDE+form.addONSIDE>
<cfquery name="editItem" datasource="#DSN#">
	update catItems 
	set 
		catnum=<cfqueryparam value="#form.catnum#" cfsqltype="cf_sql_char">,
		title=<cfqueryparam value="#newTitle#" cfsqltype="cf_sql_char">,
		artistID=<cfqueryparam value="#form.artistID#" cfsqltype="cf_sql_char">,
		labelID=<cfqueryparam value="#form.labelID#" cfsqltype="cf_sql_char">,
		countryID=<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
		mediaID=<cfqueryparam value="#form.mediaID#" cfsqltype="cf_sql_char">,
		genreID=<cfqueryparam value="#form.genreID#" cfsqltype="cf_sql_char">,
		releaseDate=<cfqueryparam value="#thisReleaseDate#" cfsqltype="cf_sql_date">,
		DTdateUpdated=<cfqueryparam value="#thisDateUpdated#" cfsqltype="cf_sql_date">,
        NRECSINSET=<cfqueryparam value="#form.NRECSINSET#" cfsqltype="cf_sql_char">,
		reissue=<cfqueryparam value="#form.reissue#" cfsqltype="cf_sql_bit">,
		discogsID=<cfqueryparam value="#form.discogsID#" cfsqltype="cf_sql_char">
        where ID=#form.ID#
</cfquery>

	<cfif form.addtrx EQ ""><cfset thisAddtrx=0><cfelse><cfset thisAddtrx=form.addtrx></cfif>
	<cflocation url="catalogMiniEdit.cfm?ID=#form.ID#&addtrx=#thisAddtrx#&pageBack=#form.pageBack#">
