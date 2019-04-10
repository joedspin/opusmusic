<cfparam name="form.ID" default="">
<cfparam name="form.uploadFile" default="">
<cfparam name="form.uploadFileFull" default="">
<cfparam name="form.cancel" default="">
<cfparam name="form.delete" default="">
<cfparam name="form.deleteFull" default="">
<!---<cfparam name="form.item" default="">//--->
<cfif form.cancel NEQ "">
	<cflocation url="eventsLIST.cfm">
<cfelseif form.item NEQ "">
	<cflocation url="eventsEDIT.cfm?ID=#form.ID#">
<cfelseif form.delete NEQ "">
	<cfdirectory name="checkArt" directory="#serverPath#\images\calendar" filter="calEvent#NumberFormat(url.ID,"00000")#_thumb.jpg" action="list">
	<cfif checkArt.recordCount GT 0>
		<cffile action="delete" file="#serverPath#\images\calendar\calEvent#NumberFormat(url.ID,"00000")#_thumb.jpg">
	</cfif>
	<cfquery name="updateItem" datasource="#DSN#">
		update tblEvents
		set jpgLoaded=0
		where ID=#form.ID#
	</cfquery>
	<cflocation url="eventsARTLOAD.cfm?ID=#form.ID#">
<cfelseif form.deleteFull NEQ "">
	<cfdirectory name="checkArt" directory="#serverPath#\images\calendar" filter="calEvent#NumberFormat(url.ID,"00000")#_full.jpg" action="list">
	<cfif checkArt.recordCount GT 0>
		<cffile action="delete" file="#serverPath#\images\calendar\calEvent#NumberFormat(url.ID,"00000")#_full.jpg">
	</cfif>
	<cfquery name="updateItem" datasource="#DSN#">
		update tblEvents
		set fullImg=0
		where ID=#form.ID#
	</cfquery>
	<cflocation url="eventsARTLOAD.cfm?ID=#form.ID#">
<cfelseif form.uploadFile NEQ "">
	<cffile action="upload"
		destination="#serverPath#\images\calendar"
		nameConflict="overwrite"
		fileField="uploadFile">
	<cffile action="rename"
		source="#serverPath#\images\calendar\#cffile.serverFile#"
		destination="#serverPath#\images\calendar\calEvent#NumberFormat(url.ID,"00000")#_thumb.jpg">
	<cfquery name="updateItem" datasource="#DSN#">
		update tblEvents
		set jpgLoaded=1
		where ID=#form.ID#
	</cfquery>
	<cflocation url="eventsARTLOAD.cfm">
<cfelseif form.uploadFileFull NEQ "">
	<cffile action="upload"
		destination="#serverPath#\images\calendar"
		nameConflict="overwrite"
		fileField="uploadFileFull">
	<cffile action="rename"
		source="#serverPath#\images\calendar\#cffile.serverFile#"
		destination="#serverPath#\images\calendar\calEvent#NumberFormat(url.ID,"00000")#_full.jpg">
	<cfquery name="updateItem" datasource="#DSN#">
		update tblEvents
		set fullImg=1
		where ID=#form.ID#
	</cfquery>
	<cflocation url="eventsARTLOAD.cfm?ID=#form.ID#">
</cfif>