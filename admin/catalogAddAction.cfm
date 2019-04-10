<cfparam name="form.catConfirm" default="">
<cfparam name="form.catnum" default="">
<cfparam name="form.artistID" default="">
<cfparam name="form.genreID" default="0">
<cfparam name="form.labelID" default="0">
<cfparam name="form.reissue" default="No">
<cfparam name="form.specialItem" default="No">
<cfparam name="form.addArtistName" default="">
<cfparam name="form.addLabelName" default="">
<cfparam name="form.numtrx" default="5">
<cfparam name="form.dtID" default="0">
<cfparam name="form.discogsID" default="0">
<cfif form.dtID EQ ""><cfset form.dtID="0"></cfif>
<cfparam name="price" default="0.00">
<cfparam name="cost" default="0.00">
<cfparam name="form.CONDITION_MEDIA_ID" default="1">
<cfparam name="form.CONDITION_COVER_ID" default="1">
<cfparam name="form.ORDER304" default="0">
<cfparam name="form.ORDER161" default="0">
<cfparam name="form.ONHAND" default="0">
<cfparam name="form.warehouseFind" default="no">
<cfparam name="form.remastered" default="no">
<cfparam name="form.repress" default="no">
<cfparam name="form.limitedEdition" default="no">
<cfparam name="form.notched" default="no">
<cfparam name="form.dt304exclusive" default="no">
<cfparam name="form.vinyl180g" default="no">
<cfset Cookie.shelfselect=form.shelfID>
<cfset Cookie.countryselect=form.countryID>
<cfquery name="checkLabel" datasource="#DSN#">
    select *
    from labels
    where name=<cfqueryparam value="#form.addLabelName#" cfsqltype="cf_sql_char">
</cfquery>
<!---<cfoutput>181.#TimeFormat(Now(),"hh:mm:ss.l")#<br></cfoutput>//--->
<cfif form.addLabelName NEQ "" AND Find("++",addLabelName) EQ 0>
	<cfquery name="checkLabelSimilar" datasource="#DSN#">
    	select *
        from labels
        where name LIKE '%#form.addLabelName#%'
        order by name
    </cfquery>
    <cfif checkLabelSimilar.recordCount GT 0>
    <cfif checkLabel.recordCount EQ 0>
    	<h1>Are you sure you didn't mean one of these labels that are already in the system?</h1>
        <p><cfoutput query="checkLabelSimilar">
        	#name#<br>
        </cfoutput></p>
        <h2>To use one of these labels instead, please click back and type the full name. If you want to add a new label, click back and add ++ to the label name to force it to be added.</h2>
    	<cfabort>
    </cfif>
	</cfif>
</cfif>
<cfset form.addLabelName=Replace(form.addLabelName,"++","","all")>
<cfif form.catConfirm NEQ form.catnum>
    <cfquery name="checkCatNum" datasource="#DSN#">
        select *
        from catItemsQuery
        where catnum=<cfqueryparam value="#form.catnum#" cfsqltype="cf_sql_char">
    </cfquery>
	<cfif checkCatNum.recordCount NEQ 0>
        <html>
        <body bgcolor="black" style="font-family:Arial, Helvetica, sans-serif; font-size: x-small; color:white;">
            <h2><font color="red">WARNING!</font></h2>
            <p>There is already at least one item in the database with this catalog number (see below).
            <p>To add the new item anyway, click "BACK" and retype the catalog number in the Catalog Number Confirm box.</p>
            <cfoutput query="checkCatNum">
                <h3><a href="catalogEdit.cfm?ID=#ID#">#catnum#</a> - #label# #Ucase(artist)# / #title# [<cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</h3>
            </cfoutput>
        </body>
        </html>
        <cfabort>
    </cfif>
</cfif>
<cfif form.artistID EQ "0">
	<cfif form.addArtistName NEQ "">
    	<cfif form.addArtistName EQ "Various Artist" OR form.addArtistName EQ "Various"><cfset newArtist="Various Artists"><cfelse><cfset newArtist=form.addArtistName></cfif>
		<cfquery name="checkArtist" datasource="#DSN#">
			select *
			from artists
			where name=<cfqueryparam value="#newArtist#" cfsqltype="cf_sql_char">
		</cfquery>
		<cfif checkArtist.recordCount EQ 0>
			<cfquery name="addArtist" datasource="#DSN#">
				insert into artists (name, sort)
				values (
					<cfqueryparam value="#Trim(newArtist)#" cfsqltype="cf_sql_char">,
					<cfqueryparam value="#Trim(Replace(Replace(Replace(UCase(addArtistName)," ","","all"),","," ","all"),"/","","all"))#" cfsqltype="cf_sql_char">
				)
			</cfquery>
			<cfquery name="getArtistID" datasource="#DSN#">
				select Max(ID) as newID
				from artists
				where name=<cfqueryparam value="#Trim(newArtist)#" cfsqltype="cf_sql_char">
			</cfquery>
            <cfquery name="Application.adminAllArtists" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
                select *
                from artists
                order by sort, name
            </cfquery>
		<cfset form.artistID=getArtistID.newID>
		<cfelse>
			<cfset form.artistID=checkArtist.ID>
		</cfif>
	</cfif>
</cfif>
<cfif form.addLabelName NEQ "">
	<cfif checkLabel.recordCount EQ 0>
		<cfquery name="addLabel" datasource="#DSN#">
			insert into labels (name,sort)
			values (
				<cfqueryparam value="#Trim(form.addLabelName)#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#Trim(UCase(Replace(form.addLabelName," ","","all")))#" cfsqltype="cf_sql_char">
			)
		</cfquery>
		<cfquery name="getLabelID" datasource="#DSN#">
			select Max(ID) as newID
			from labels
			where name=<cfqueryparam value="#Trim(form.addLabelName)#" cfsqltype="cf_sql_char">
		</cfquery>
        <cfquery name="Application.adminAllLabels" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
            select *
            from labels
            order by sort, name
        </cfquery>
	<cfset form.labelID=getLabelID.newID>
	<cfelse>
		<cfset form.LabelID=checkLabel.ID>
	</cfif>
</cfif>
<cfif form.ORDER304 GT 0 AND form.ONHAND LT 1>
	<cfset thisAlbumStatusID=148>
<cfelse>
	<cfset thisAlbumStatusID=21>
</cfif>
<cfquery name="addItem" datasource="#DSN#">
	insert into catItems (catnum, title, artistID, labelID, countryID, mediaID, genreID, releaseDate, realReleaseDate, shelfID, price, cost, wholesalePrice, NRECSINSET, ONHAND, ONORDER, CONDITION_MEDIA_ID, CONDITION_COVER_ID, reissue, dtID, albumStatusID,specialItem, discogsID,notched,remastered,repress,warehouseFind,vinyl180g,limitedEdition,dt304exclusive)
	values (
		<cfqueryparam value="#Trim(form.catnum)#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#Trim(form.title)#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.artistID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.labelID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.countryID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.mediaID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.genreID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.releaseDate#" cfsqltype="cf_sql_date">,
		<cfqueryparam value="#form.releaseDate#" cfsqltype="cf_sql_date">,
		<cfqueryparam value="#form.shelfID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#Replace(form.price,"$","","all")#" cfsqltype="cf_sql_money">,
		<cfqueryparam value="#Replace(form.cost,"$","","all")#" cfsqltype="cf_sql_money">,
		<cfqueryparam value="#Replace(form.wholesalePrice,"$","","all")#" cfsqltype="cf_sql_money">,
		<cfqueryparam value="#form.NRECSINSET#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.ONHAND#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.ORDER304#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.CONDITION_MEDIA_ID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.CONDITION_COVER_ID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.reissue#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.dtID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#thisAlbumStatusID#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.specialItem#" cfsqltype="cf_sql_bit">,
        <cfqueryparam value="#Int(form.discogsID)#" cfsqltype="cf_sql_char">,
		<cfqueryparam value="#form.notched#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.remastered#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.repress#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.warehouseFind#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.vinyl180g#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.limitedEdition#" cfsqltype="cf_sql_bit">,
		<cfqueryparam value="#form.dt304exclusive#" cfsqltype="cf_sql_bit">
	)
</cfquery>
<cfquery name="newItem" datasource="#DSN#">
	select Max(ID) as newID
	from catItems
	where title=<cfqueryparam value="#form.title#" cfsqltype="cf_sql_char">
</cfquery>
<cfif form.ORDER304 NEQ 0>
    <cfquery name="purchaseOrder" datasource="#DSN#">
    	insert into purchaseOrderDetails (PO_ID, catItemID, vendorID, qtyRequested, dateRequested, completed, requestedUserID,customerID)
        values (0,#newItem.newID#,#form.shelfID#,#form.ORDER304#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,0,#Session.userID#,0)
    </cfquery>
</cfif>
<cfif form.ORDER161 NEQ 0>
    <cfquery name="purchaseOrder" datasource="#DSN#">
    	insert into purchaseOrderDetails (PO_ID, catItemID, vendorID, qtyRequested, dateRequested, completed, requestedUserID,customerID)
        values (0,#newItem.newID#,#form.shelfID#,#form.ORDER161#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,0,#Session.userID#,2126)
    </cfquery>
</cfif>
<cfif form.ONHAND NEQ 0>
	<cfquery name="audit999" datasource="#DSN#">
    	insert into catRcvd (catItemID, dateReceived, qtyRcvd, rcvdShelfID, rcvdUserID)
        values (#newItem.newID#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,#form.ONHAND#,#form.shelfID#,#Session.userID#)
    </cfquery>
</cfif>
<cfif form.submit EQ " DONE ">
	<cflocation url="catalog.cfm">
<cfelse>
	<cflocation url="catalogEdit.cfm?ID=#newItem.newID#&addtrx=#form.numtrx#&forcecache=yes">
</cfif>