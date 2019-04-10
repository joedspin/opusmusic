<cfif CGI.REMOTE_ADDR NEQ "184.152.28.62"><cfabort></cfif>
<cfsetting requesttimeout="6000" enablecfoutputonly="no">
<cfquery name="allOpusItems" datasource="#DSN#">
	select *
	from catItemsQuery
</cfquery>
<cfparam name="form.DTCatText" default="">
<cfparam name="form.uu" default="">
<cfparam name="form.pp" default="">
<cfparam name="form.loadType" default="">
<cfparam name="form.loadDate" default="today">
<cfparam name="form.compDates" default="">
<cfparam name="url.tryagain" default="0">
<cfset flag1=0>
<cfif loadType EQ "UNDER2"><cfset flag1=1></cfif>
<cfif (form.uu NEQ "DT161" OR form.pp NEQ "ggHy77Tjx8H") AND url.tryagain EQ "0">ERROR - Access Denied</cfif>
<cfif form.DTCatText EQ "" AND url.tryagain NEQ "0">
	ERROR
<cfelseif url.tryagain EQ "0">
	<cffile action="write" 
		file="#serverPath#\DTinventory.txt"
	output="#form.DTCatText#">
</cfif>		
<cfhttp method="Get"
		url="#webPath#/DTInventory.txt"
		name="DTInventory"
		delimiter="|"
		textqualifier="" columns="Catalog_Number,Album_Detail_ID,Album_Format_ID,Label_Name,Album_Name,Artist_Name,Sell_Price,Buy_Price,In_Stock_Num,Style_ID,Date_Updated,Album_Status_ID,Company_ID,Release_Date">
	<cfif DTInventory.RecordCount GT 0>
		<cfloop query="DTInventory">
			<cfif Album_Format_ID EQ "" OR Album_Format_ID EQ 0><cfoutput><font color="red">Catalog Number #Catalog_Number# does not have an Album Format.</font> Load cannot be performed until it is fixed on DownTown system.<cfabort></cfoutput></cfif>
		</cfloop>
		<cfquery name="DTformat" datasource="#DSN#">
			select *
			from DTAlbumFormats
		</cfquery>	
		<cfif url.tryagain NEQ "">
			<cfquery name="DTInvLoad" dbtype="query">
			select * from DTInventory, DTFormat WHERE CAST(Album_Format_ID AS INTEGER)=DTformat.ID AND CAST(Album_Detail_ID AS INTEGER)>Cast('#url.tryagain#' As INTEGER) order by Album_Detail_ID
		</cfquery>
<cfelse>	
			<cfquery name="DTInvLoad" dbtype="query">
			select * from DTInventory, DTFormat WHERE CAST(Album_Format_ID AS INTEGER)=DTformat.ID order by Album_Detail_ID
		</cfquery>
</cfif>
		<cfif form.compDates NEQ "">
		<table>
		<cfloop query="DTInvLoad">
		<cfset compareDateUpdated=Date_Updated>
		<cfquery name="checkOpus" dbtype="query">
			select *
			from allOpusItems
			where dtID=Album_Detail_ID
		</cfquery>
		<cfoutput query="checkOpus">
			<tr>
				<td>304:#DateFormat(dtDateUpdated,"mm/dd/yyyy")#</td>
				<td>161:#DateFormat(compareDateUpdated,"mm/dd/yyyy")#</td>
				<td>#catnum#</td>
				<td>#label#</td>
				<td>#left(artist,20)#
				<td>#left(titel,25)#
			</tr>
		</cfoutput>
		</cfloop>
		</table>
		<cfabort>
		</cfif>
		
		<cfset numRows=DTInvLoad.RecordCount>
		<cfloop query="DTInvLoad">
        	<cfset thisVendorID=Company_ID>
            <cfset thisDTBuy=Buy_Price>
            <cfif thisDTBuy EQ ""><cfset thisDTBuy=0></cfif>
			<cfset thisAlbumID=DTInvLoad.Album_Detail_ID>
			<cfset thisMediaID=DTInvLoad.mediaID>
            <cfif thisVendorID EQ ""><cfoutput>#Catalog_Number# does not have a vendorID</cfoutput><cfset vendorID=0><br></cfif>
            <cfif thisDTBuy EQ ""><cfoutput>#Catalog_Number# does not have a Buy Price</cfoutput></cfif>
			<cfif thisMediaID EQ ''><cfset thisMediaID=0></cfif>
            <cfset thisItemDTID=NumberFormat(DTInvLoad.Album_Detail_ID,"000000")>
			<cfquery name="thisOpusItem" datasource="#DSN#">
				select *
				from catItemsQuery
				WHERE CAST(dtID AS INTEGER)=#thisItemDTID#
			</cfquery><!---dtID=#thisAlbumID#//--->
			<cfif thisOpusItem.RecordCount GT 0>
				<cfset thisDateUpdated=DTInvLoad.Date_Updated>
				<cfset thisReleaseDate=DTInvLoad.Release_Date>
				<cfset thisAlbumStatusID=DTInvLoad.Album_Status_ID>
				<cfset thisCost=DTInvLoad.Sell_Price>
                <cfif thisCost EQ ""><cfoutput>#Catalog_Number# does not have a Sell Price</cfoutput></cfif>
				<cfset thisGenreID=1>
				<cfif Style_ID EQ 67><cfset thisGenreID=7></cfif>
				<cfif Style_ID EQ 99 OR thisOpusItem.labelID EQ 2413 OR thisOpusItem.labelID EQ 2036><cfset thisGenreID=4></cfif>
				<cfif Style_ID EQ 50><cfset thisGenreID=3></cfif>
				<cfif Style_ID EQ 128><cfset thisGenreID=9></cfif>
				<cfif Style_ID EQ 200><cfset thisGenreID=10></cfif>
				<cfif Style_ID EQ 300 OR thisOpusItem.labelID EQ 2022 OR thisOpusItem.labelID EQ 2045 OR thisOpusItem.labelID EQ 3992 OR thisOpusItem.labelID EQ 2043><cfset thisGenreID=8></cfif>
				<cfif Style_ID EQ 400><cfset thisGenreID=5></cfif>
				<cfset thisONHAND=DTInvLoad.In_Stock_Num>
				<cfloop query="thisOpusItem">
					<cfset doUpdate=true>
					<cfset updateDescrip="">
					<cfset opusGenreID=thisOpusItem.genreID>
					<cfif thisGenreID NEQ opusGenreID>
						<cfset doUpdate=true>
						<cfset updateDescrip=updateDescrip&"Genre ID changed from " & opusGenreID & " to " & thisGenreID & "<br>">
					<cfelse>
						<cfset thisGenreID=opusGenreID>
					</cfif>
					<cfset opusMediaID=thisOpusItem.mediaID>
					<cfif thisMediaID NEQ opusMediaID>
						<cfset doUpdate=true>
						<cfset updateDescrip=updateDescrip&"Media ID changed from " & opusMediaID & " to " & thisMediaID & "<br>">
					<cfelse>
						<cfset thisMediaID=opusMediaID>
					</cfif>
					<cfset opusReleaseDate=thisOpusItem.releaseDate>
					<cfif DateFormat(thisOpusItem.dtDateUpdated,"yyyy-mm-dd") NEQ thisDateUpdated AND thisDateUpdated NEQ "">
						<cfset doUpdate=true>
						<cfset updateDescrip=updateDescrip&"DownTown Date Updated changed from " & DateFormat(thisOpusItem.dtDateUpdated,"yyyy-mm-dd") & " to " & thisDateUpdated & "<br>">
					<cfelse>
						<cfset thisDateUpdated=DateFormat(thisOpusItem.dtDateUpdated,"yyyy-mm-dd")>
					</cfif>
					<cfif thisDateUpdated EQ "" OR thisDateUpdated EQ "0000-00-00"><cfset thisDateUpdated="11/15/05"></cfif>
					<cfif thisOpusItem.albumStatusID NEQ thisAlbumStatusID>
                    	<cfif thisAlbumStatusID GT 24 AND thisOpusItem.ONSIDE GT 0>
                        	<cfset thisONHAND=0>
                        	<cfset thisAlbumStatusID=thisOpusItem.albumStatusID>
                       	<cfelse>
							<cfset doUpdate=true>
							<cfset updateDescrip=updateDescrip&"Status changed from " & thisOpusItem.albumStatusID & " to " & thisAlbumStatusID & "<br>">
                            </cfif>
					<cfelse>
						<cfset thisAlbumStatusID=thisOpusItem.albumStatusID>
					</cfif>
					<cfif releaseDateLock EQ 0 AND thisReleaseDate NEQ "" AND thisReleaseDate NEQ "0000-00-00">
						<cfset doUpdate=true>
						<cfset updateDescrip=updateDescrip&"Release Date changed from " & DateFormat(opusReleaseDate,"yyyy-mm-dd") & " to " & thisReleaseDate & "<br>">
					<cfelse>
						<cfset thisReleaseDate=opusReleaseDate>
					</cfif>
					<cfif thisReleaseDate EQ "" OR thisReleaseDate EQ "0000-00-00">
						<cfset thisReleaseDate=DateFormat(varDateODBC,"yyyy-mm-dd")>
					</cfif>
                    <cfset thisBuy=thisCost>
					<!---
					2008-12-11 REMOVED CODE FOR UPDATING PRICE/COST
					REPLACED WITH ABOVE CODE TO ASSIGN DT161 SELL PRICE (buy variable)
					<cfif DollarFormat(thisOpusItem.cost) NEQ DollarFormat(thisCost)>
						<cfset doUpdate=true>
						<cfset thisPrice=NumberFormat((thisCost*1.6),"0.00")>
                        <cfif thisPrice GT thisCost+3.0 AND NRECSINSET EQ 1><cfset thisPrice=NumberFormat((thisCost)+3.0,"0.00")></cfif>
						<cfset updateDescrip=updateDescrip&"Cost changed from " & DollarFormat(thisOpusItem.cost) & " to " & DollarFormat(thisCost) & "<br>">
						<cfset updateDescrip=updateDescrip&"Price changed from " & DollarFormat(thisOpusItem.price) & " to " & thisPrice & "<br>">
					<cfelse>
						<cfset thisCost=thisOpusItem.cost>
						<cfset thisPrice=NumberFormat((thisOpusItem.price),"0.00")>
					</cfif>//--->
					<cfif thisOpusItem.ONHAND NEQ thisONHAND>
						<cfset doUpdate=true>
						<cfset updateDescrip=updateDescrip&"In Stock Num changed from " & thisOpusItem.ONHAND & " to " & thisONHAND & "<br>">
						<cfif thisONHAND GT thisOpusItem.ONHAND AND thisONHAND GT 0>
						<cfquery name="backorders" datasource="#DSN#">
							select *
							from orderItemsQuery
							where dtID=<cfqueryparam value="#thisAlbumID#" cfsqltype="cf_sql_char"> AND adminAvailID=3 AND statusID<>7 AND backorderNoticeSent=0
						</cfquery>
						<cfif backorders.recordCount GT 0>
                        <cfloop query="backorders">
                        <cfset itemDescrip="#artist# #title# (#NRECSINSET#x#media#) [#label# - #catnum#]">
                        <cfquery name="customer" datasource="#DSN#">
                            select *
                            from custAccounts
                            where ID=#custID#
                        </cfquery>
                        <cfif form.loadType NEQ "ALL ACTIVE"><cfset sendMailTo=email><cfelse><cfset sendMailTo="joe@downtown161.com"></cfif>
							<cfmail query="customer" to="#sendMailTo#" from="info@downtown304.com" bcc="order@downtown304.com" subject="BACKORDERED ITEMS Back In Stock" type="html">
<p>#firstName#,</p>
<p>This item, which you have on backorder, is now available again:</p>
<p>#itemDescrip#</p>
<p>You can manage your backorders in the "My Account" section after you login on our website. Move this item to your cart, or REMOVE it from backorder there.</p>
<p><a href="http://www.downtown304.com">Downtown304.com</a></p>
							</cfmail>
                            <cfquery name="markBO" datasource="#DSN#">
                                update orderItems
                                set backorderNoticeSent=1
                                where ID=#orderItemID#
                            </cfquery>
                            </cfloop>
						</cfif>
						</cfif>
					<cfelse>
						<cfset thisONHAND=thisOpusItem.ONHAND>
					</cfif>
					<cfif thisAlbumStatusID LT 25 AND thisONHAND GT 0>
						<cfset thisActive=true>
					<cfelse>
						<cfset thisActive=false>
					</cfif>
                    <cfif flag1 EQ 1><cfset doUpdate=true></cfif>
				<cfif thisAlbumStatusID EQ 19>
					<cfset this304notnew=1>
				<cfelse>
					<cfset this304notnew=0>
				</cfif>
					<cfif doUpdate>
						<cfoutput><a href="catalogLoadCatalogAction.cfm?tryagain=#thisOpusItem.dtID#">#NumberFormat(thisOpusItem.dtID,"0000000")#</a> | #thisOpusItem.catnum# | #thisOpusItem.title# | #thisOpusItem.artist#<br />
						<font size="1" color="red">#updateDescrip#</font></cfoutput>
                        <cfif thisBuy EQ ""><cfset thisBuy=0></cfif>
                        <cfif thisAlbumStatusID EQ ""><cfset thisAlbumStatusID=148></cfif>
                        <cfif thisDateUpdated EQ ""><cfset thisDateUpdated=varDateODBC></cfif>
                        <cfif thisMediaID EQ ""><cfset thisMediaID=1></cfif>
                        <cfif thisAlbumID EQ ""><cfset thisAlbumID=0></cfif>
                        <!---/cost=<cfqueryparam value="#thisCost#" cfsqltype="cf_sql_money">,
							price=<cfqueryparam value="#thisPrice#" cfsqltype="cf_sql_money">,/--->
						<cfquery name="loadCatalog" datasource="#DSN#">
							update catItems
							set
							buy=<cfqueryparam value="#Replace(DollarFormat(thisBuy),'$','','all')#" cfsqltype="cf_sql_money">,
							ONHAND=<cfqueryparam value="#thisONHAND#" cfsqltype="cf_sql_char">,
							albumStatusID=<cfqueryparam value="#thisAlbumStatusID#" cfsqltype="cf_sql_char">,
							dtDateUpdated=<cfqueryparam value="#thisDateUpdated#" cfsqltype="cf_sql_date">,
							active=<cfqueryparam value="#thisActive#" cfsqltype="cf_sql_bit">,
							releaseDate=<cfqueryparam value="#thisReleaseDate#" cfsqltype="cf_sql_date">,
							mediaID=<cfqueryparam value="#thisMediaID#" cfsqltype="cf_sql_char">,
                            flag1=<cfqueryparam value="#flag1#" cfsqltype="cf_sql_bit">,
                            vendorID=<cfqueryparam value="#thisVendorID#" cfsqltype="cf_sql_char">,
                            dtBuy=<cfqueryparam value="#Replace(DollarFormat(thisDTBuy),'$','','all')#" cfsqltype="cf_sql_money">,
                            notNew304=#this304notnew#
							where dtID=<cfqueryparam value="#thisAlbumID#" cfsqltype="cf_sql_char">
						</cfquery>
					</cfif>
				</cfloop>
			<cfelse>
				<cfif Album_Status_ID EQ 19>
					<cfset this304notnew=1>
				<cfelse>
					<cfset this304notnew=0>
				</cfif>
            	<cfif mediaID EQ ""><cfoutput>#UCase(Artist_Name)# / #Album_Name# is missing FORMAT</cfoutput><br>
<cfset mediaID=1></cfif>
				<cfif (Album_Status_ID LT 25 OR Album_Status_ID EQ 148) AND (mediaID NEQ "") AND (In_Stock_Num GT 0 OR Album_Status_ID EQ 148)>
				<cfquery name="checkArtist" datasource="#DSN#">
					select *
					from artists
					where name=<cfqueryparam value="#Artist_Name#" cfsqltype="cf_sql_char">
				</cfquery>
				<cfif checkArtist.recordCount EQ 0>
					<cfquery name="addArtist" datasource="#DSN#">
						insert into artists (name, sort)
						values (
							<cfqueryparam value="#Artist_Name#" cfsqltype="cf_sql_char">,
							<cfqueryparam value="#Replace(Replace(Replace(UCase(Artist_Name)," ","","all"),","," ","all"),"/","","all")#" cfsqltype="cf_sql_char">
						)
					</cfquery>
					<cfquery name="getArtistID" datasource="#DSN#">
						select Max(ID) as newID
						from artists
						where name=<cfqueryparam value="#Artist_Name#" cfsqltype="cf_sql_char">
					</cfquery>
					<cfset thisArtistID=getArtistID.newID>
				<cfelse>
					<cfset thisArtistID=checkArtist.ID>
				</cfif>
				<cfset thisLabelName=Replace(Replace(Replace(Replace(Label_Name,"*69","star 69","all"),"*","","all"),"MISC./","","all"),"SERIES/","","all")>
				<cfif Replace(thisLabelName," ","","all") EQ "">
					<cfset thisLabelName="white label">
				</cfif>
				<cfquery name="checkLabel" datasource="#DSN#">
					select *
					from labels
					where name=<cfqueryparam value="#thisLabelName#" cfsqltype="cf_sql_char">
				</cfquery>
				<cfif checkLabel.recordCount EQ 0>
					<cfquery name="addLabel" datasource="#DSN#">
						insert into labels (name)
						values (
							<cfqueryparam value="#thisLabelName#" cfsqltype="cf_sql_char">
						)
					</cfquery>
					<cfquery name="getLabelID" datasource="#DSN#">
						select Max(ID) as newID
						from labels
						where name=<cfqueryparam value="#thisLabelName#" cfsqltype="cf_sql_char">
					</cfquery>
					<cfset thisLabelID=getLabelID.newID>
				<cfelse>
					<cfset thisLabelID=checkLabel.ID>
				</cfif>
				<cfset thisReleaseDate="">
				<cfif Album_Status_ID LT 23>
					<cfset thisReleaseDate=Release_Date>
				</cfif>
				<cfif thisReleaseDate EQ "" OR thisReleaseDate EQ "0000-00-00">
					<cfset thisReleaseDate="1999-12-31">
				</cfif>
				<cfset thisGenreID=1>
				<cfif Style_ID EQ 67><cfset thisGenreID=7></cfif>
				<cfif Style_ID EQ 99><cfset thisGenreID=4></cfif>
				<cfif Style_ID EQ 50><cfset thisGenreID=3></cfif>
				<cfset reissue="No">
				<cfif Style_ID EQ 67><cfset reissue="Yes"></cfif>
				<cfset thisONHAND=In_Stock_Num>
				<!--- CODE FOR DISGUISING REAL IN-STOCK NUMBER (temporarily disabled) <cfif thisONHAND GT 30><cfset thisONHAND=30+Right(thisONHAND,"1")></cfif>//--->
				<cfset thisDateUpdated=Date_Updated>
				<cfif thisDateUpdated EQ "" OR thisDateUpdated EQ "0000-00-00" OR thisDateUpdated LT "2000-01-01"><cfset thisDateUpdated="11/15/05"></cfif>
				<cfset thisCost=Sell_Price>
                <cfset thisBuy=Sell_Price>
				<cfif thisCost EQ ""><cfset thisCost=0></cfif>
                <cfif thisBuy EQ ""><cfset thisBuy=0></cfif>
				<cfset thisPrice=NumberFormat(thisCost*1.6,"0.00")>
                <!---<cfif thisPrice GT thisCost+3.0 AND NRECSINSET EQ 1><cfset thisPrice=NumberFormat((thisCost)+3.0,"0.00")></cfif>//--->
				<cfif Album_Status_ID LT 25 AND thisONHAND GT 0>
						<cfset thisActive=true>
					<cfelse>
						<cfset thisActive=false>
					</cfif>
				 <!--- These three lines store the current DT "Date Updated", "Cost" and 50% markup Price //--->
				<cfoutput>#NumberFormat(thisAlbumID,"0000000")# | #Catalog_Number# | #Album_Name# | #Artist_Name#<br />
				<font color="red" size="1">ADDED</font><br /></cfoutput>
			<cfquery name="loadCatalog" datasource="#DSN#">
				insert into catItems (catnum,mediaID,NRECSINSET,labelID,artistID,title,genreID,shelfID,dtID,reissue,CONDITION_MEDIA_ID,CONDITION_COVER_ID,countryID,buy,cost,price,ONHAND,releaseDate,dtDateUpdated,albumStatusID,active,flag1,vendorID,dtBuy,notNew304)
				values (
				<cfqueryparam value="#Catalog_Number#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisMediaID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#NRECSINSET#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisLabelID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisArtistID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#Album_Name#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisGenreID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="11" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisAlbumID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#reissue#" cfsqltype="cf_sql_bit">,
				<cfqueryparam value="1" cfsqltype="cf_sql_char">,
				<cfqueryparam value="1" cfsqltype="cf_sql_char">,
				<cfqueryparam value="1" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisBuy#" cfsqltype="cf_sql_money">,
				<cfqueryparam value="#thisCost#" cfsqltype="cf_sql_money">,
				<cfqueryparam value="#thisPrice#" cfsqltype="cf_sql_money">,
				<cfqueryparam value="#thisONHAND#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisReleaseDate#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#thisDateUpdated#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#Album_Status_ID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisActive#" cfsqltype="cf_sql_bit">,
                <cfqueryparam value="#flag1#" cfsqltype="cf_sql_bit">,
                <cfqueryparam value="#thisVendorID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisDTBuy#" cfsqltype="cf_sql_money">,
                                #this304notnew#)
			</cfquery>
			</cfif>
			</cfif>
		</cfloop>
		<cfif form.loadDate EQ "today">
			<cfset thisLoadDate=varDateODBC>
		<cfelse>
			<cfset thisLoadDate=form.loadDate>
		</cfif>
		<cfquery name="logAction" datasource="#DSN#">
			insert into DTLoadHistory (dateLoaded,numRows,loadType,comment)
			values (
				<cfqueryparam value="#thisLoadDate#" cfsqltype="cf_sql_date">,
				<cfqueryparam value="#numRows#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="CATALOG" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#form.loadType#" cfsqltype="cf_sql_longvarchar">)
		</cfquery>
	<cfelse>
		<p>No Items found.</p>
	</cfif>
	<cfoutput>
	
<!--- Fix BREAKS Genres //--->
<cfquery name="fixGenres" datasource="#DSN#">
	update catItems
	set genreID=8
	where labelID=2022 OR labelID=2045 OR labelID=3992 OR labelID=2043
</cfquery>
<cfquery name="fixGenres" datasource="#DSN#">
	update catItems
	set genreID=4
	where labelID=2413 OR labelID=2036
</cfquery>
<cfinclude template="catalogLoadPrices.cfm">
		<p>Downtown 304 - Load Downtown Daily Update</p>
		<p><b>#DateFormat(thisLoadDate,"mm/dd/yyyy")#<br />
		#numRows# Items Processed</b></p>
		<p>Done.</p>
	</cfoutput>
