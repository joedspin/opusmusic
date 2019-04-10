<cfparam name="form.ID" default="0">
<cfparam name="form.artistID" default="0">
<cfparam name="form.trackID" default="0">
<cfparam name="form.uploadFile" default="">
<cfparam name="form.cancel" default="">
<cfparam name="form.delete" default="">
<cfparam name="form.item" default="">
<cfparam name="form.insertItem" default="">
<cfparam name="form.insertTrack" default="">
<cfparam name="form.continue" default="more">
<cfparam name="url.resetTracks" default="no">
<cfparam name="url.thisItemID" default="0">
<cfset already=false>
	<cfif url.resetTracks EQ "yes">
		<cfquery name="resetTracks" datasource="#DSN#">
			update catTracks
			set mp3Loaded=0 
			where catID=#url.thisItemID#
		</cfquery>
		<cflocation url="trackLoad.cfm?ID=#url.thisItemID#">
	</cfif>
<!---<cfif form.trackID GTE 27999><cfset trFolder="d:\media"><cfelse><cfset trFolder="e:\media2"></cfif>//--->
<cfif form.cancel NEQ "">
	<cflocation url="catalog.cfm">
<cfelseif form.item NEQ "">
	<cflocation url="catalogEdit.cfm?ID=#form.ID#">
<cfelseif form.delete NEQ "">
	<cfdirectory name="checkTrack" directory="c:\Inetpub\wwwroot\downtown304\media\" filter="oT#form.trackID#.mp3" action="list">
	<cfif checkTrack.recordCount GT 0>
		<cffile action="delete" file="c:\Inetpub\wwwroot\downtown304\media\oT#form.trackID#.mp3">
		
		<!---<cfquery name="tracks" datasource="#DSN#">
			select *
			from catTracks
			where catID=#form.ID#
		</cfquery>
		<cfset mp3Status="0">
		<cfloop query="tracks">
			<cfdirectory directory="c:\Inetpub\wwwroot\downtown304\media" filter="oT#tracks.ID#.mp3" name="trackCheck" action="list">
			<cfif trackCheck.recordCount NEQ 0>
				<cfset mp3Status="1">
			</cfif>
		</cfloop>
		<cfquery name="updateItem" datasource="#DSN#">
			update catItems
			set mp3Loaded=#mp3Status#
			where ID=#form.ID#
		</cfquery>//--->
	</cfif>
		<cfquery name="updateTrack" datasource="#DSN#">
			update catTracks
			set mp3Loaded=0
			where ID=#form.trackID#
		</cfquery>
	<cflocation url="trackLoad.cfm?ID=#form.ID#">
<cfelseif form.insertItem NEQ "">
	<cfquery name="thisList" datasource="#DSN#" maxrows="1">
		select *
		from artistListsQuery
		where artistID=15387
		order by listDate DESC 
	</cfquery>
	<cfquery name="checkList" datasource="#DSN#">
		select *
		from artistListsItemsQuery
		where (trackItemID=#form.insertItem# OR itemID=#form.insertItem#) AND listID=#thisList.ID#
	</cfquery>
	<cfif checkList.recordCount GT 0>
		<cfset already=true>	
	<cfelse>
		<cfquery name="addItem" datasource="#DSN#">
			insert into arrtistListItems (listID, itemID, sort)
			values (
				#thisList.ID#, #form.insertItem#, 6
			)
		</cfquery>
	</cfif>
	<cflocation url="trackLoad.cfm?ID=#form.ID#&already=#already#">
<cfelseif form.insertTrack NEQ "">
	<cfquery name="thisList" datasource="#DSN#" maxrows="1">
		select *
		from artistListsQuery
		where artistID=15387
		order by listDate DESC 
	</cfquery>
	<cfquery name="checkList" datasource="#DSN#">
		select *
		from artistListsItemsQuery
		where trackID=#form.insertTrack# AND listID=#thisList.ID# OR itemID=#form.ID#
	</cfquery>
	<cfif checkList.recordCount GT 0>
		<cfset already=true>
	<cfelse>
		<cfquery name="addTrack" datasource="#DSN#">
			insert into arrtistListItems (listID, trackID, sort)
			values (
				#thisList.ID#, #form.insertTrack#, 6
			)
		</cfquery>
	</cfif>
	<cflocation url="trackLoad.cfm?ID=#form.ID#&already=#already#">
<cfelseif form.uploadFile NEQ "">
	<cffile action="upload"
		destination="c:\Inetpub\wwwroot\downtown304\media"
		nameConflict="overwrite"
		fileField="uploadFile">
	<cffile action="rename"
		source="c:\Inetpub\wwwroot\downtown304\media\#cffile.serverFile#"
		destination="c:\Inetpub\wwwroot\downtown304\media\oT#form.trackID#.mp3">
	<cfquery name="updateTrack" datasource="#DSN#">
		update catTracks
		set mp3Loaded=1, mp3Alt=0
		where ID=#form.trackID#
	</cfquery>
	<cfquery name="updateItem" datasource="#DSN#">
		update catItems
		set mp3Loaded=1
		where ID=#form.ID#
	</cfquery>
    <cfif form.continue EQ "art">
    	<cflocation url="artLoad.cfm?ID=#form.ID#">
    <cfelseif form.continue EQ "done">
    	<cflocation url="catalog.cfm">
    <cfelse>
		<cflocation url="trackLoad.cfm?ID=#form.ID#">
    </cfif>
</cfif>