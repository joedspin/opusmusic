<cfparam name="form.ID" default="">
<cfparam name="form.uploadFile" default="">
<cfparam name="form.uploadFileFull" default="">
<cfparam name="form.uploadFileAlt" default="">
<cfparam name="form.cancel" default="">
<cfparam name="form.delete" default="">
<cfparam name="form.deleteFull" default="">
<cfparam name="form.deleteAlt" default="">
<cfparam name="form.item" default="">
<cfif form.cancel NEQ "">
	<cflocation url="catalog.cfm">
<cfelseif form.item NEQ "">
	<cflocation url="catalogEdit.cfm?ID=#form.ID#">
<cfelseif form.delete NEQ "">
	<cfdirectory name="checkArt" directory="#serverPath#\images\items" filter="oI#form.ID#.jpg" action="list">
	<cfif checkArt.recordCount GT 0>
		<cffile action="delete" file="#serverPath#\images\items\oI#form.ID#.jpg">
	</cfif>
	<cfquery name="updateItem" datasource="#DSN#">
		update catItems
		set jpgLoaded=0
		where ID=#form.ID#
	</cfquery>
	<cflocation url="artLoad.cfm?ID=#form.ID#">
<cfelseif form.deleteFull NEQ "">
	<cfdirectory name="checkArt" directory="#serverPath#\images\items" filter="oI#form.ID#full.jpg" action="list">
	<cfif checkArt.recordCount GT 0>
		<cffile action="delete" file="#serverPath#\images\items\oI#form.ID#full.jpg">
	</cfif>
	<cfquery name="updateItem" datasource="#DSN#">
		update catItems
		set fullImg=''
		where ID=#form.ID#
	</cfquery>
	<cflocation url="artLoad.cfm?ID=#form.ID#">
<cfelseif form.deleteAlt NEQ "">
	<cfdirectory name="checkArt" directory="#serverPath#\images\items" filter="oI#form.ID#back.jpg" action="list">
	<cfif checkArt.recordCount GT 0>
		<cffile action="delete" file="#serverPath#\images\items\oI#form.ID#back.jpg">
	</cfif>
	<cfquery name="updateItem" datasource="#DSN#">
		update catItems
		set altImg=''
		where ID=#form.ID#
	</cfquery>
	<cflocation url="artLoad.cfm?ID=#form.ID#">
<cfelseif form.uploadFile NEQ "">
	<cffile action="upload"
		destination="#serverPath#\images\items"
		nameConflict="overwrite"
		fileField="uploadFile">
	<cffile action="rename"
		source="#serverPath#\images\items\#cffile.serverFile#"
		destination="#serverPath#\images\items\oI#form.ID#.jpg">
	<cfquery name="updateItem" datasource="#DSN#">
		update catItems
		set jpgLoaded=1
		where ID=#form.ID#
	</cfquery>
	<cflocation url="artLoad.cfm?ID=#form.ID#">
<cfelseif form.uploadFileFull NEQ "">
	<cffile action="upload"
		destination="#serverPath#\images\items"
		nameConflict="overwrite"
		fileField="uploadFileFull">
	<cffile action="rename"
		source="#serverPath#\images\items\#cffile.serverFile#"
		destination="#serverPath#\images\items\oI#form.ID#full.jpg">
	<cfquery name="updateItem" datasource="#DSN#">
		update catItems
		set fullImg=<cfqueryparam value="oI#form.ID#full.jpg" cfsqltype="cf_sql_char">
		where ID=#form.ID#
	</cfquery>
    <cflocation url="catalog.cfm">
<cfelseif form.uploadFileAlt NEQ "">
	<cffile action="upload"
		destination="#serverPath#\images\items"
		nameConflict="overwrite"
		fileField="uploadFileAlt">
	<cffile action="rename"
		source="#serverPath#\images\items\#cffile.serverFile#"
		destination="#serverPath#\images\items\oI#form.ID#back.jpg">
	<cfquery name="updateItem" datasource="#DSN#">
		update catItems
		set altImg=<cfqueryparam value="oI#form.ID#back.jpg" cfsqltype="cf_sql_char">
		where ID=#form.ID#
	</cfquery>
    <cflocation url="artLoad.cfm?ID=#form.ID#">
</cfif>