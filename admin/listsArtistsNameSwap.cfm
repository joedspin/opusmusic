<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfparam name="url.editItem" default="0">
<cfquery name="thisArtist" datasource="#DSN#">
	select *
	from artists
	where ID=#url.ID#
</cfquery>
<cfif Find(",",thisArtist.name) EQ 0>
	Name must have a comma in order to swap. Click Back in your browser to edit.<cfabort>
</cfif>
<cfloop query="thisArtist">
	<cfset commaPos=Find(",",name)>
	<cfset nameLen=Len(name)>
	<cfset firstName=Right(name,nameLen-commaPos-1)>
	<cfset lastName=Left(name,commaPos-1)>
	<cfset newName=firstName&" "&lastName>
	<cfset newSort=Ucase(firstName)&Ucase(lastName)>
	<cfoutput>#newName# #newSort# #name#</cfoutput>
</cfloop>
<cfquery name="updateArtist" datasource="#DSN#">
	update artists
	set name='#newName#', sort='#newSort#'
	where ID=#url.ID#
</cfquery>
<cfif url.editItem NEQ 0>
	<cflocation url="catalogEdit.cfm?ID=#url.editItem#">
<cfelse>
	<cflocation url="listsArtistsEdit.cfm?ID=#url.ID#">
</cfif>