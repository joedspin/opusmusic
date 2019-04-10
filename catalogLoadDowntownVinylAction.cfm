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
<cfset flag1=0>
<cfif loadType EQ "UNDER2"><cfset flag1=1></cfif>
<cfhttp method="Get"
		url="#webPath#/DTVinylInventory.txt"
		name="DTInventory"
		delimiter="|"
		textqualifier="" columns="Catalog_Number,Album_Detail_ID,Album_Format_ID,Label_Name,Album_Name,Artist_Name,Sell_Price,Buy_Price,In_Stock_Num,Style_ID,Date_Updated,Album_Status_ID,Company_ID,Release_Date,Notch_Column">
	<cfif DTInventory.RecordCount GT 0>
		<!---<cfloop query="DTInventory">
			<cfif Album_Format_ID EQ "" OR Album_Format_ID EQ 0><cfoutput><font color="red">Catalog Number #Catalog_Number# does not have an Album Format.</font> Load cannot be performed until it is fixed on DownTown system.<cfabort></cfoutput></cfif>
		</cfloop>//--->
		<cfquery name="DTformat" datasource="#DSN#">
			select *
			from DTAlbumFormats
		</cfquery>	
		<cfquery name="DTInvLoad" dbtype="query">
			select * from DTInventory, DTFormat WHERE CAST(Album_Format_ID AS INTEGER)=DTformat.ID
		</cfquery>
		
		<cfset numRows=DTInvLoad.RecordCount>
		<cfloop query="DTInvLoad">
        	
            <cfset thisBuy=Buy_Price>
            <cfif thisBuy EQ ""><cfset thisBuy=0></cfif>
            <cfset thisDTBuy=thisBuy>
            <cfset thisCost=thisBuy*1.25>
            <cfset thisPrice=Sell_Price>
	<cfset thisMediaID=DTInvLoad.mediaID>
         		            	<cfif mediaID EQ ""><cfoutput>#UCase(Artist_Name)# / #Album_Name# is missing FORMAT</cfoutput><br>
<cfset mediaID=1></cfif>
				<!---<cfif (Album_Status_ID LT 25 OR Album_Status_ID EQ 148) AND (mediaID NEQ "") AND (In_Stock_Num GT 0 OR Album_Status_ID EQ 148)>//--->
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
				<cfset thisAlbumID=0>
                <cfset thisGenreID=9>
                <cfset reissue=0>
                <cfset THISONHAND=0>
                <cfset thisReleaseDate="">
                <cfset thisDateUpdated=varDateODBC>
                <cfset thisActive=1>
                <cfset thisVendorID=0>
				<cfoutput>#NumberFormat(thisAlbumID,"0000000")# | #Catalog_Number# | #Album_Name# | #Artist_Name#<br />
				<font color="red" size="1">ADDED</font><br /></cfoutput>
<cfif Notch_Column EQ "N"><cfset thisNotched=1><cfelse><cfset thisNotched=0></cfif>
			<cfquery name="loadCatalog" datasource="#DSN#">
				insert into catItems (catnum,mediaID,NRECSINSET,labelID,artistID,title,genreID,shelfID,dtID,reissue,CONDITION_MEDIA_ID,CONDITION_COVER_ID,countryID,buy,cost,price,ONHAND,releaseDate,dtDateUpdated,albumStatusID,active,flag1,vendorID,dtBuy,notched)
				values (
				<cfqueryparam value="#Catalog_Number#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisMediaID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#NRECSINSET#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisLabelID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisArtistID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#Album_Name#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#thisGenreID#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="40" cfsqltype="cf_sql_char">,
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
				#thisNotched#)
			</cfquery>
			<!---</cfif>//--->
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
				<cfqueryparam value="SCORPIO" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#form.loadType#" cfsqltype="cf_sql_longvarchar">)
		</cfquery>
	<cfelse>
		<p>No Items found.</p>
	</cfif>
	<cfoutput>
	
		<p>Downtown 304 - Scorpio Import</p>
		<p><b>#DateFormat(thisLoadDate,"mm/dd/yyyy")#<br />
		#numRows# Items Processed</b></p>
		<p>Done.</p>
	</cfoutput>
