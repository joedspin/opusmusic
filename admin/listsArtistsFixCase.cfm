<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfparam name="url.editItem" default="0">
<cfquery name="thisArtist" datasource="#DSN#">
	select *
	from artists
	where ID=#url.ID#
</cfquery>
<cfloop query="thisArtist">
	<cfset newName=UCase(Left(name,1))&LCase(Right(name,Len(name)-1))>
	<cfset spacePos=Find(" ",newName)>
	<cfloop condition="spacePos NEQ 0">
		<cfif spacePos EQ Len(newName)-1>
			<cfset newName=Left(newName,spacePos)&UCase(Right(newName,1))>
		<cfelse>
			<cfset newName=Left(newName,spacePos)&UCase(Mid(newName,spacePos+1,1))&LCase(Right(newName,Len(newName)-spacePos-1))>
		</cfif>
		<cfoutput>#spacePos#</cfoutput> ... 
		<cfset spacePos=Find(" ",newName,spacePos+1)>
	</cfloop>
	<cfset newName=Replace(newName,"The ","the ","all")>
	<cfset newName=Replace(newName," A "," a ","all")>
	<cfset newName=Replace(newName," Of "," of ","all")>
	<cfset newName=Replace(newName," And "," and ","all")>
	<cfset newName=Replace(newName," On "," on ","all")>
	<cfset newName=Replace(newName," For "," for ","all")>
	<cfset newName=Replace(newName,"Feat. ","feat. ","all")>
	<cfset newName=Replace(newName,"Presents ","presents ","all")>
	<cfset newName=Replace(newName," In "," in ","all")>
	<cfset newName=Replace(newName," With "," with ","all")>
	<cfset newName=Replace(newName,"Dj ","DJ ","all")>
	<cfoutput>#newName# #name#</cfoutput>
</cfloop>
<cfquery name="updateArtist" datasource="#DSN#">
	update artists
	set name='#newName#'
	where ID=#url.ID#
</cfquery>
<cfquery name="Application.adminAllArtists" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,0,0,1)#">
	select *
    from artists
    order by sort, name
</cfquery>
<cfif url.editItem NEQ 0>
	<cflocation url="catalogEdit.cfm?ID=#url.editItem#">
<cfelse>
	<cflocation url="listsArtistsEdit.cfm?ID=#url.ID#">
</cfif>