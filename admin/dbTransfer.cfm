<cfparam name="url.start" default="0">
<cfparam name="url.end" default="3884200">
<cfquery name="addInventory" datasource="#DSN#">
	select *
	from joedspin
	where MYREFNO >#url.start# AND MYREFNO<=#url.end#
</cfquery>
<cfset thisCount=addInventory.RecordCount>
<cfset nextStart=url.start+1000>
<cfset nextEnd=url.end+1000>
<cfloop query="addInventory">
	<!--- Check to see if ARTIST is already in database. If not, add it //--->
	<cfif ARTIST_FIRST NEQ "">
		<cfset thisArtist=ARTIST_LAST & ', ' & ARTIST_FIRST>
	<cfelse>
		<cfset thisArtist=ARTIST_LAST>
	</cfif>
	<cfquery name="checkArtist" datasource="#DSN#">
		select *
		from artists
		where name='#thisArtist#'
	</cfquery>
	<cfif checkArtist.recordCount EQ 0>
		<cfquery name="insertArtist" datasource="#DSN#">
			insert into
			artists (name, sort)
			values (
				<cfqueryparam value="#thisArtist#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#Replace(UCase(thisArtist)," ","","all")#" cfsqltype="cf_sql_char">
			)
			</cfquery>
			<cfquery name="getArtistID" datasource="#DSN#">
				select Max(ID) as MaxID
				from artists
				where name='#thisArtist#'
			</cfquery>
			<cfset thisArtistID=getArtistID.MaxID>
	<cfelse>
		<cfset thisArtistID=checkArtist.ID>
	</cfif>
	<!--- Check to see if LABEL is already in database. If not, add it //--->
	<cfset thisLabel=LABEL>
	<cfquery name="checkLabel" datasource="#DSN#">
		select *
		from labels
		where name='#thisLabel#'
	</cfquery>
	<cfif checkLabel.recordCount EQ 0>
		<cfquery name="insertLabel" datasource="#DSN#">
			insert into
			labels (name, sort)
			values (
				<cfqueryparam value="#thisLabel#" cfsqltype="cf_sql_char">,
				<cfqueryparam value="#Replace(UCase(thisLabel)," ","","all")#" cfsqltype="cf_sql_char">
			)
			</cfquery>
			<cfquery name="getLabelID" datasource="#DSN#">
				select Max(ID) as MaxID
				from labels
				where name='#thisLabel#'
			</cfquery>
			<cfset thisLabelID=getLabelID.MaxID>
		
	<cfelse>
		<cfset thisLabelID=checkLabel.ID>
	</cfif>
	<!--- Check to see if COUNTRY is already in database, otherwise add it //--->
	<cfset thisCountry=RELEASE_COUNTRY>
	<cfquery name="checkCountry" datasource="#DSN#">
		select *
		from country
		where abbrev='#thisCountry#'
	</cfquery>
	<cfif checkCountry.recordCount EQ 0>
		<cfquery name="insertCountry" datasource="#DSN#">
			insert into
			country (abbrev)
			values (
				<cfqueryparam value="#thisCountry#" cfsqltype="cf_sql_char">
			)
			</cfquery>
			<cfquery name="getCountryID" datasource="#DSN#">
				select Max(ID) as MaxID
				from country
				where abbrev='#thisCountry#'
			</cfquery>
			<cfset thisCountryID=getCountryID.MaxID>
		
	<cfelse>
		<cfset thisCountryID=checkCountry.ID>
	</cfif>
	<!--- Check to see if MEDIA is already in database, otherwise add it //--->
	<cfset thisMedia=MEDIA>
	<cfquery name="checkMedia" datasource="#DSN#">
		select *
		from media
		where name='#thisMedia#'
	</cfquery>
	<cfif checkMedia.recordCount EQ 0>
		<cfquery name="insertMedia" datasource="#DSN#">
			insert into
			media (name)
			values (
				<cfqueryparam value="#thisMedia#" cfsqltype="cf_sql_char">
			)
			</cfquery>
			<cfquery name="getMediaID" datasource="#DSN#">
				select Max(ID) as MaxID
				from media
				where name='#thisMedia#'
			</cfquery>
			<cfset thisMediaID=getMediaID.MaxID>
		
	<cfelse>
		<cfset thisMediaID=checkMedia.ID>
	</cfif>
	<cfquery name="getShelfID" datasource="#DSN#">
		select *
		from shelf
		where code='#PARTNER#'
	</cfquery>
	<cfif getShelfID.RecordCount GT 0><cfset thisShelfID=getShelfID.ID><cfelse><cfset thisShelfID=7></cfif>
	<cfquery name="getConditionmediaID" datasource="#DSN#">
		select *
		from condition
		where condition='#CONDITION_MEDIA#'
	</cfquery>
	<cfif getConditionMediaID.RecordCount GT 0><cfset thisCMediaID=getConditionMediaID.ID><cfelse><cfset thisCMediaID=1></cfif>
	<cfquery name="getConditionCoverID" datasource="#DSN#">
		select *
		from condition
		where condition='#CONDITION_COVER#'
	</cfquery>
	<cfif getConditionCoverID.RecordCount GT 0><cfset thisCCoverID=getConditionCoverID.ID><cfelse><cfset thisCCoverID=1></cfif>
	
	<!---<cfoutput>#RELEASE_NUMBER#<br>
			#TITLE#<br>
			#thisArtistID#<br>
			#thisLabelID#<br>
			#thisCountryID#<br>
			#thisMediaID#<br>
			1<br>
			#RELEASE_DATE#<br>
			#NumberFormat(PRICE,"0.00")#<br>
			#NumberFormat(COST,"0.00")#<br>
			#NumberFormat(NRECSINSET)#<br>
			#NumberFormat(ONHAND)#<br>
			#DESCRIPTION#<br>
			#thisShelfID#<br>
			#thisCMediaID#<br>
			#thisCCoverID#</p></cfoutput>//--->
		<cfquery name="insertCatItem" datasource="#DSN#">
		insert into catItems (catnum, title, artistID, labelID, countryID, mediaID, genreID, releaseYear, price, cost, NRECSINSET, ONHAND,  descrip, shelfID, CONDITION_MEDIA_ID, CONDITION_COVER_ID)
		values (
			<cfqueryparam value="#RELEASE_NUMBER#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#TITLE#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#thisArtistID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#thisLabelID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#thisCountryID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#thisMediaID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="1" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#RELEASE_DATE#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#NumberFormat(PRICE,"0.00")#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#NumberFormat(COST,"0.00")#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#NumberFormat(NRECSINSET)#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#NumberFormat(ONHAND)#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#DESCRIPTION#" cfsqltype="cf_sql_longvarchar">,
			<cfqueryparam value="#thisShelfID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#thisCMediaID#" cfsqltype="cf_sql_char">,
			<cfqueryparam value="#thisCCoverID#" cfsqltype="cf_sql_char">
		)
	</cfquery>
</cfloop>
<cfoutput><p>Number of Records Processed: #thisCount#</p>
<p><a href="dbTransfer.cfm?start=#nextStart#&end=#nextEnd#">Next</a></p></cfoutput>