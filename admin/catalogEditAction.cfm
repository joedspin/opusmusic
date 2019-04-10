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
<cfparam name="form.wholesalePrice" default="0.00">
<cfparam name="form.CONDITION_MEDIA_ID" default="1">
<cfparam name="form.CONDITION_COVER_ID" default="1">
<cfparam name="form.description" default="">
<cfparam name="form.trackID" default="">
<cfparam name="form.uploadFile" default="">
<cfparam name="form.cancel" default="">
<cfparam name="form.deleteItem" default="">
<cfparam name="form.done" default="">
<cfparam name="form.makeInactive" default="">
<cfparam name="form.dup" default="">
<cfparam name="form.promo" default="">
<cfparam name="form.merge" default="">
<cfparam name="form.loadTracks" default="">
<cfparam name="form.loadArt" default="">
<cfparam name="form.fixTitleCase" default="">
<cfparam name="form.calcPrice" default="">
<cfparam name="form.active" default="No">
<cfparam name="form.weightException" default="0">
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
<cfparam name="form.forceBackorder" default="no">
<cfparam name="form.buy" default="0">
<cfparam name="form.blueDate" default="">
<cfparam name="form.dtOLDID" default="">
<cfparam name="form.blue99" default="no">
<cfparam name="form.discogsID" default="0">
<cfparam name="form.releaseDateLock" default="0">
<cfparam name="form.notNew304" default="No">
<cfparam name="form.white" default="">
<cfparam name="form.findReissue" default="">
<cfparam name="form.pushReleaseDate" default="no">
<cfparam name="form.priceSave" default="0">
<cfparam name="form.costSave" default="0">
<cfparam name="form.originalPrice" default="0">
<cfparam name="form.keywords" default="">
<cfparam name="form.createTracks" default="">
<cfparam name="form.fixCountry" default="">
<cfparam name="form.warehouseFind" default="no">
<cfparam name="form.remastered" default="no">
<cfparam name="form.repress" default="no">
<cfparam name="form.limitedEdition" default="no">
<cfparam name="form.notched" default="no">
<cfparam name="form.dt304exclusive" default="no">
<cfparam name="form.vinyl180g" default="no">
<cfparam name="form.canPreorder" default="no">
<cfparam name="form.showAllArtists" default="">
<cfparam name="form.editArtist" default="">
<cfparam name="form.showAllLabels" default="">
<cfparam name="form.editLabel" default="">
<cfparam name="form.pocomplete" default="">
<cfparam name="form.podelete" default="">
<cfparam name="form.orderitemdelete" default="">
<cfparam name="form.skiptracks" default="false">
<cfparam name="form.oldAlbumStatusID" default="0">
<cfparam name="form.saleSave" default="0">
<cfif form.AlbumStatusID EQ 27 AND form.albumStatusID NEQ form.oldAlbumStatusID>
	<cfmail to="order@downtown304.com" from="order@downtown304.com" subject="Item manually set to Auto Out Of Stock">
		http://www.downtown304.com/admin/catalogEdit.cfm?ID=#form.ID#
	</cfmail>
</cfif>
<cfset Cookie.pushReleaseDate=form.pushReleaseDate>
<cfif form.pocomplete NEQ "">
	<cfquery name="deletePORow" datasource="#DSN#">
        update purchaseOrderDetails
        set completed=1
        where POItem_ID IN (#form.pocomplete#)
    </cfquery>
</cfif>
<cfif form.podelete NEQ "">
	<cfquery name="deletePORow" datasource="#DSN#">
        delete from
        purchaseOrderDetails
        where POItem_ID IN (#form.podelete#)
    </cfquery>
</cfif>
<cfif form.orderitemdelete NEQ "">
	<cfquery name="killItem" datasource="#DSN#">
        delete
        from orderItems
        where ID IN (#form.orderitemdelete#)
    </cfquery>
</cfif>

<cfif (form.sendBackorder EQ "yes" and addONHAND GT 0) OR form.forceBackorder EQ "yes">
	<cfset selectedID=form.ID>
	<cfquery name="backorders" datasource="#DSN#">
        select *
        from orderItemsQuery
        where catItemID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char"> AND adminAvailID=3 AND backorderNoticeSent=0
    </cfquery>
    <cfif backorders.recordCount GT 0>
        <cfloop query="backorders">
                <cfquery name="customer" datasource="#DSN#">
                    select *
                    from custAccounts
                    where ID=#custID#
                </cfquery>
                <cfset thisNotice="BACKORDERED ITEMS Back In Stock">
                 <cfinclude template="notifyEmail.cfm">
            </cfloop>
         <cfquery name="clearBackorder" datasource="#DSN#">
        	update orderItems
            set backorderNoticeSent=1
            where catItemID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char"> AND adminAvailID=3 AND backorderNoticeSent=0
        </cfquery>
    </cfif>
    <cfquery name="emailMe" datasource="#DSN#">
        select *
        from notifyMe
        where catItemID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char"> AND noticeSent=0
    </cfquery>
    <cfif emailMe.recordCount GT 0>
        <cfloop query="emailMe">
        <cfquery name="customer" datasource="#DSN#">
            select *
            from custAccounts
            where ID=#custID#
        </cfquery>
        <cfset thisNotice="PRE-RELEASE ITEM NOW AVAILABLE">
         <cfinclude template="notifyEmail.cfm">
            </cfloop>
        </cfif>
       
        <cfquery name="clearEmailMe" datasource="#DSN#">
        	update notifyMe
            set noticeSent=1
            where catItemID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
        </cfquery>
</cfif> 
<cfset thisAlbumStatusID=form.albumStatusID>
<cfset thisReleaseDate=form.releaseDate>
<cfset thisDateUpdated=form.releaseYear>
<cfset thisRealRelease=form.realReleaseDate>
<!---<cfif form.addONSIDE EQ 999 OR form.addONSIDE EQ -999>
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
</cfif>//--->
<cfset thisONORDER=form.ONORDER>
<cfif form.addONHAND NEQ 0>
	<cfif form.addONHANDshelfID EQ 0><p><font color="red">ERROR!!!!!</font> You did not specify a Vendor for catalog received. Click back and try again.</p><cfabort></cfif>
    <cfquery name="purchOrderEntries" datasource="#DSN#">
    	select *
        from purchaseOrderDetails
        where catItemID=#form.ID# AND qtyRequested > qtyReceived AND completed=0 AND vendorID=#form.addONHANDshelfID# order by dateRequested DESC
    </cfquery>
    <cfif purchOrderEntries.recordCount EQ 0 AND form.addONHANDshelfID NEQ 24>
    	<p style="color:red">ERROR!!!!! Vendor mismatch</p><cfabort>
    </cfif>
	<cfif form.addONHAND EQ ""><p style="color:red">ERROR!!!!! No quantity entered for receiving</p><cfabort></cfif>
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
    <cfif form.albumStatusID EQ 148>
    	<cfset thisAlbumStatusID=21>
        <cfif form.pushReleaseDate>
			<cfset thisReleaseDate=DateAdd("d",1,varDateODBC)>
            <cfset thisDateUpdated=DateAdd("d",1,varDateODBC)>
            <cfset thisRealRelease=DateAdd("d",1,varDateODBC)>
        <cfelse>
			<cfset thisReleaseDate=#varDateODBC#>
        	<cfset thisDateUpdated=#varDateODBC#>
            <cfset thisRealRelease=#varDateODBC#>
        </cfif>
     <cfelseif (form.albumStatusID EQ 25 OR form.albumStatusID EQ 27) AND form.addONHAND GT 0><!--- AND form.ONHAND LTE 0//--->
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
<cfif not skiptracks>
	<cfif form.tCt GT 0>
        <cfloop from="1" to="#form.tCt#" index="tCt">
            <cfparam name="form.tName#tCt#" default="">
            <cfif Trim(Evaluate("form.tID"&tCt)) EQ "0">
                <cfif Evaluate("form.tName"&tCt) NEQ "">
                    <cfquery name="addTrack" datasource="#DSN#">
                        insert into catTracks (catID, tName, tSort, mp3Alt)
                        values (
                            <cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">,
                            <cfqueryparam value="#Replace(Evaluate("form.tName"&tCt),chr(9)," ","all")#" cfsqltype="cf_sql_char">,
                            <cfqueryparam value="#Evaluate("form.tSort"&tCt)#" cfsqltype="cf_sql_char">,
                            0
                        )
                    </cfquery>
                    <cfset tracks=true>
                </cfif>
            <cfelse>
                <cfif Trim(Evaluate("form.tName"&tCt)) NEQ "">
                    <cfquery name="editTrack" datasource="#DSN#">
                        update catTracks
                        set tName=<cfqueryparam value="#Replace(Evaluate("form.tName"&tCt),chr(9)," ","all")#" cfsqltype="cf_sql_char">,
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
</cfif>
<cfif tracks AND form.shelfID EQ 7>
	<cfset form.shelfID=11>
</cfif>
<cfset thisPrice=Replace(form.price,"$","","all")>
<cfset thisCost=Replace(form.cost,"$","","all")>
<cfset thisWholesalePrice=Replace(form.wholesalePrice,"$","","all")>
<cfif thisPrice EQ 0 AND thisCost NEQ 0><cfset thisPrice=thisCost+3></cfif>
<cfif thisWholesalePrice EQ 0 AND thisCost NEQ 0><cfset thisWholeSalePrice=thisCost+1.3></cfif>
<cfif form.shelfID NEQ 11><cfset thisDTID=0><cfelse><cfset thisDTID=form.dtID></cfif>
<cfquery name="editItem" datasource="#DSN#">
	update catItems 
	set 
		catnum=<cfqueryparam value="#form.catnum#" cfsqltype="cf_sql_char">,
		title=<cfqueryparam value="#Trim(newTitle)#" cfsqltype="cf_sql_char">,
		artistID=<cfqueryparam value="#form.artistID#" cfsqltype="cf_sql_char">,
		labelID=<cfqueryparam value="#form.labelID#" cfsqltype="cf_sql_char">,
		countryID=<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
		mediaID=<cfqueryparam value="#form.mediaID#" cfsqltype="cf_sql_char">,
		genreID=<cfqueryparam value="#form.genreID#" cfsqltype="cf_sql_char">,
		releaseDate=<cfqueryparam value="#thisReleaseDate#" cfsqltype="cf_sql_date">,
		DTdateUpdated=<cfqueryparam value="#thisDateUpdated#" cfsqltype="cf_sql_date">,
		realReleaseDate=<cfqueryparam value="#thisRealRelease#" cfsqltype="cf_sql_date">,
		preOrderCutoffDate=<cfqueryparam value="#form.preOrderCutoffDate#" cfsqltype="cf_sql_date">,
        blueDate=<cfqueryparam value="#form.blueDate#" cfsqltype="cf_sql_date">,
		dtOLDID=<cfqueryparam value="#form.dtOLDID#" cfsqltype="cf_sql_char">,
        blue99=<cfqueryparam value="#form.blue99#" cfsqltype="cf_sql_bit">,
		shelfID=<cfqueryparam value="#form.shelfID#" cfsqltype="cf_sql_char">,
		price=<cfqueryparam value="#thisPrice#" cfsqltype="cf_sql_money">,
		cost=<cfqueryparam value="#thisCost#" cfsqltype="cf_sql_money">,
		wholesalePrice=<cfqueryparam value="#thisWholesalePrice#" cfsqltype="cf_sql_money">,
        originalPrice=<cfqueryparam value="#Replace(form.originalPrice,"$","","all")#" cfsqltype="cf_sql_money">,
		saleSave=<cfqueryparam value="#Replace(form.saleSave,"$","","all")#" cfsqltype="cf_sql_money">,
		NRECSINSET=<cfqueryparam value="#form.NRECSINSET#" cfsqltype="cf_sql_char">,
		CONDITION_MEDIA_ID=<cfqueryparam value="#form.CONDITION_MEDIA_ID#" cfsqltype="cf_sql_char">,
		CONDITION_COVER_ID=<cfqueryparam value="#form.CONDITION_COVER_ID#" cfsqltype="cf_sql_char">,
		reissue=<cfqueryparam value="#form.reissue#" cfsqltype="cf_sql_bit">,
		dtID=<cfqueryparam value="#thisDTID#" cfsqltype="cf_sql_char">,
		descrip=<cfqueryparam value="#form.description#" cfsqltype="cf_sql_longvarchar">,
		weightException=<cfqueryparam value="#form.weightException#" cfsqltype="cf_sql_double">,
		active=<cfqueryparam value="#form.active#" cfsqltype="cf_sql_bit">,
		albumStatusID=<cfqueryparam value="#thisAlbumStatusID#" cfsqltype="cf_sql_char">,
        hideTracks=<cfqueryparam value="#form.hideTracks#" cfsqltype="cf_sql_bit">,
        noReorder=<cfqueryparam value="#form.noReorder#" cfsqltype="cf_sql_bit">,
        specialItem=<cfqueryparam value="#form.specialItem#" cfsqltype="cf_sql_bit">,
		discogsID=<cfqueryparam value="#Int(form.discogsID)#" cfsqltype="cf_sql_char">,
        releaseDateLock=<cfqueryparam value="#form.releaseDateLock#" cfsqltype="cf_sql_bit">,
        notNew304=<cfqueryparam value="#form.notNew304#" cfsqltype="cf_sql_bit">,
        priceSave=<cfqueryparam value="#Replace(priceSave,"$","","all")#" cfsqltype="cf_sql_money">,
        costSave=<cfqueryparam value="#Replace(costSave,"$","","all")#" cfsqltype="cf_sql_money">,
		keywords=<cfqueryparam value="#Trim(form.keywords)#" cfsqltype="cf_sql_char">,
        warehouseFind=<cfqueryparam value="#form.warehouseFind#" cfsqltype="cf_sql_bit">,
        remastered=<cfqueryparam value="#form.remastered#" cfsqltype="cf_sql_bit">,
        repress=<cfqueryparam value="#form.repress#" cfsqltype="cf_sql_bit">,
        limitedEdition=<cfqueryparam value="#form.limitedEdition#" cfsqltype="cf_sql_bit">,
        notched=<cfqueryparam value="#form.notched#" cfsqltype="cf_sql_bit">,
        dt304exclusive=<cfqueryparam value="#form.dt304exclusive#" cfsqltype="cf_sql_bit">,
        vinyl180g=<cfqueryparam value="#form.vinyl180g#" cfsqltype="cf_sql_bit">,
        canPreorder=<cfqueryparam value="#form.canPreorder#" cfsqltype="cf_sql_bit">
	where ID=#form.ID#
</cfquery>



<cfif form.createTracks NEQ "">
	<cfset trackListWork="trackname"&linefeed&form.createTracks>
    <cffile action="write" 
            file="#serverPath#\createTracks.txt"
        output="#trackListWork#"
        charset="utf-8">

<cfhttp method="Get"
    url="#webPath#/createTracks.txt"
    name="cTracks"
    delimiter="|"
    textqualifier="" columns="trackname"
    charset="utf-8">
	<!---<cfoutput query="loadm3u">
    #remotename#<br>
    </cfoutput><cfabort>//--->
    <cfif cTracks.RecordCount GT 0>
    <cfquery name="maxTrackSort" datasource="#DSN#">
    	select Max(tSort) As maxSort
        from catTracks
        where catID=<cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">
    </cfquery>
   	<cfset tCount=Val(maxTrackSort.maxSort)>
        <cfloop query="cTracks">
        	<cfset tCount=tCount+1>
            <cfif trackname NEQ "" AND trackname NEQ "trackname">
                <cfquery name="addTrack" datasource="#DSN#">
                    insert into catTracks (catID, tName, tSort, mp3Alt)
                    values (
                        <cfqueryparam value="#form.ID#" cfsqltype="cf_sql_char">,
                        <cfqueryparam value="#cTracks.trackname#" cfsqltype="cf_sql_char">,
                        <cfqueryparam value="#tCount#" cfsqltype="cf_sql_char">,
                        0
                    )
                </cfquery>
            </cfif>
        </cfloop>
    </cfif>
</cfif>




<cfif form.makeInactive NEQ "">
	<cfquery name="makeInactive" datasource="#DSN#">
		update catItems
		set albumStatusID=44, ONHAND=0
		where ID=#form.ID#
	</cfquery>
</cfif>
<cfif form.dup NEQ "" OR form.promo NEQ "">
	<cfif form.promo NEQ "">
		<cfset thisAlbumStatusID=21>
		<cfset thisReleaseDate=DateFormat(varDateODBC,"mm/dd/yy")>
		<cfset thisONHAND=1>
        <cfset thisONORDER=0>
		<cfset thisdtID=0>
		<cfset thisTitle=form.itemTitle&" (Promo)">
	<cfelse>
		<cfset thisAlbumStatusID=form.albumStatusID>
		<cfset thisReleaseDate=DateFormat(form.releaseDate,"mm/dd/yy")>
		<cfset thisONHAND=0>
        <cfset thisONORDER=0>
		<cfset thisdtID=form.dtID>
		<cfset thisTitle=newTitle>
	</cfif>
	<cfquery name="addItem" datasource="#DSN#">
		insert into catItems (catnum, title, artistID, labelID, countryID, mediaID, genreID, DTdateUpdated, releaseDate, shelfID, price, cost, wholesalePrice, NRECSINSET, ONHAND, ONORDER, CONDITION_MEDIA_ID, CONDITION_COVER_ID, reissue, dtID, weightException, descrip, albumStatusID,hideTracks,noReorder,specialItem,discogsID,notched,repress,remastered,vinyl180g,dt304exclusive,warehouseFind,limitedEdition,keywords)
		values (
			<cfqueryparam value="#Trim(form.catnum)#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#Trim(thisTitle)#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.artistID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.labelID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.mediaID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.genreID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.releaseYear#" cfsqltype="cf_sql_date">,
			<cfqueryparam value="#thisReleaseDate#" cfsqltype="cf_sql_date">,
			<cfqueryparam value="#form.shelfID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#Replace(thisPrice,"$","","all")#" cfsqltype="cf_sql_money">,
			<cfqueryparam value="#Replace(form.cost,"$","","all")#" cfsqltype="cf_sql_money">,
			<cfqueryparam value="#Replace(form.wholesalePrice,"$","","all")#" cfsqltype="cf_sql_money">,
			<cfqueryparam value="#form.NRECSINSET#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#thisONHAND#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#thisONORDER#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.CONDITION_MEDIA_ID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.CONDITION_COVER_ID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.reissue#" cfsqltype="cf_sql_bit">,
			<cfqueryparam value="#thisdtID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#form.weightException#" cfsqltype="cf_sql_double">,
			<cfqueryparam value="#form.description#" cfsqltype="cf_sql_longvarchar">,
			<cfqueryparam value="#thisAlbumStatusID#" cfsqltype="cf_sql_char">,
        	<cfqueryparam value="#form.hideTracks#" cfsqltype="cf_sql_bit">,
        	<cfqueryparam value="#form.noReorder#" cfsqltype="cf_sql_bit">,
        	<cfqueryparam value="#form.specialItem#" cfsqltype="cf_sql_bit">,
        	<cfqueryparam value="#Int(form.discogsID)#" cfsqltype="cf_sql_bit">,
            <cfqueryparam value="#form.notched#" cfsqltype="cf_sql_bit">,
            <cfqueryparam value="#form.repress#" cfsqltype="cf_sql_bit">,
            <cfqueryparam value="#form.remastered#" cfsqltype="cf_sql_bit">,
            <cfqueryparam value="#form.vinyl180g#" cfsqltype="cf_sql_bit">,
            <cfqueryparam value="#form.dt304exclusive#" cfsqltype="cf_sql_bit">,
            <cfqueryparam value="#form.warehouseFind#" cfsqltype="cf_sql_bit">,
            <cfqueryparam value="#form.limitedEdition#" cfsqltype="cf_sql_bit">,
            <cfqueryparam value="#form.keywords#" cfsqltype="cf_sql_char">
		)
	</cfquery>
	<cfquery name="newItem" datasource="#DSN#">
		select Max(ID) as newID
		from catItems
		where title=<cfqueryparam value="#thisTitle#" cfsqltype="cf_sql_char">
	</cfquery>
	<cfquery name="itemTracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#form.ID#
	</cfquery>
	<cfloop query="itemTracks">
		<!---<cfif itemTracks.mp3Alt GT 0><cfset thisAlt=mp3Alt><cfelse><cfset thisAlt=itemTracks.ID></cfif>
		<cfdirectory directory="d:\media" filter="oT#itemTracks.IDt#.mp3" name="trackCheck" action="list">
		<cfif trackCheck.recordCount EQ 0><cfset thisAlt=0></cfif>//--->
		<cfquery name="addTrack" datasource="#DSN#">
			insert into catTracks (catID, tName, tSort, mp3Loaded, mp3Alt)
			values (
				<cfqueryparam value="#newItem.newID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#Trim(itemTracks.tName)#" cfsqltype="cf_sql_char">,
                <cfqueryparam value="#itemTracks.mp3Loaded#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#itemTracks.tSort#" cfsqltype="cf_sql_char">,
				0
			)
		</cfquery>
        <cfquery name="newTrack" datasource="#DSN#">
        	select Max(ID) as newID
            from catTracks
            where catID=<cfqueryparam value="#newItem.newID#" cfsqltype="cf_sql_char">
            	AND tName=<cfqueryparam value="#Trim(itemTracks.tName)#" cfsqltype="cf_sql_char">
                AND tSort=<cfqueryparam value="#itemTracks.tSort#" cfsqltype="cf_sql_char">
        </cfquery>
        <cfif itemTracks.mp3Loaded EQ 1 AND FileExists("c:\Inetpub\wwwroot\downtown304\media\oT#itemTracks.ID#.mp3")>
            <cffile action="copy"
            source="c:\Inetpub\wwwroot\downtown304\media\oT#itemTracks.ID#.mp3"
            destination="c:\Inetpub\wwwroot\downtown304\media\oT#newTrack.newID#.mp3"
            nameconflict="overwrite">
        </cfif>
	</cfloop>
	<cflocation url="catalogEdit.cfm?ID=#newItem.newID#&dup=yes&pageBack=#form.pageBack#">
</cfif>
<cfif form.fixCountry EQ "yes">
	<cfquery name="fixCountry" datasource="#DSN#">
    	update catItems
        set countryID=<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">
        where labelID=<cfqueryparam value="#form.labelID#" cfsqltype="cf_sql_char">
    </cfquery>
</cfif>
<!---<cfquery name="fixOOS" datasource="#DSN#">
	update catItems
	set albumStatusID=25
	where ONHAND<1 AND ONSIDE=0 AND albumStatusID<25
</cfquery>//--->
<cfif form.white EQ "edit">
	<cflocation url="reportsGeorgeTWhiteLabels.cfm">
<cfelseif form.loadTracks NEQ "">
	<cflocation url="trackLoad.cfm?ID=#form.ID#">
<cfelseif form.loadArt NEQ "">
	<cflocation url="artLoad.cfm?ID=#form.ID#">
<!---<cfelseif form.addONSIDE NEQ 0 AND form.addONSIDE NEQ 999 AND form.addONSIDE NEQ -999>
	<cfif form.done NEQ ""><cfset OSpb="catalog"><cfelse><cfset OSpb="catalogEdit"></cfif>
	<cflocation url="http://10.0.0.113/DT161/eGrid_Master/opusToolsONSIDEInvoice.php?dtID=#form.dtID#&addQTY=#form.addONSIDE#&todaydate=#DateFormat(varDateODBC,'yyyy-mm-dd')#&price=#NumberFormat(Replace(form.cost,"$","","all"),"0.00")#&itemID=#form.ID#&catnum=#form.catnum#&pb=#OSpb#">//--->
<cfelseif form.done NEQ "">
	<cflocation url="#pageBack#?hidetracks=#form.skiptracks#">
<cfelseif form.findReissue NEQ "">
	<cflocation url="catalogEdit.cfm?findReissue=yes&hidetracks=#form.skiptracks#">
<cfelseif form.showAllArtists NEQ "">
	<cflocation url="catalogEdit.cfm?ID=#form.ID#&artists=showAll&hidetracks=#form.skiptracks#">
<cfelseif form.editArtist NEQ "">
	<cflocation url="listsArtistsEdit.cfm?ID=#form.artistID#&editItem=#form.ID#">
<cfelseif form.showAllLabels NEQ "">
	<cflocation url="catalogEdit.cfm?ID=#form.ID#&labels=showAll&hidetracks=#form.skiptracks#">
<cfelseif form.editLabel NEQ "">
	<cflocation url="listsLabelsEdit.cfm?ID=#form.labelID#&editItem=#form.ID#">
<cfelse>
	<cfif form.addtrx EQ ""><cfset thisAddtrx=0><cfelse><cfset thisAddtrx=form.addtrx></cfif>
	<cflocation url="catalogEdit.cfm?ID=#form.ID#&addtrx=#thisAddtrx#&pageBack=#form.pageBack#&hidetracks=#form.skiptracks#">
</cfif>