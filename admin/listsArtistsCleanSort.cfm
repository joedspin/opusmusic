<cfsetting requesttimeout="6000">
<cfquery name="artists" datasource="#DSN#">
	select *
	from artists
</cfquery>
<cfloop query="artists">
	<cfset newsort=Replace(Replace(Replace(Replace(sort,".","","all"),"","","all")," ","","all"),",","","all")>
	<cfset newsort=ReplaceNoCase(ReplaceNoCase(ReplaceNoCase(newsort,"(re press)","","all"),"(re-press)","","all"),"(repress)","","all")>
	<cfset newsort=Replace(Replace(Replace(newsort,"(","","all"),")","","all"),"&","","all")>
	<cfset newname=ReplaceNoCase(ReplaceNoCase(ReplaceNoCase(name,"(re press)","","all"),"(re-press)","","all"),"(repress)","","all")>
	<cfset newname=ReplaceNoCase(ReplaceNoCase(newname," ft."," feat.","all")," feat "," feat. ","all")>
	<cfquery name="updatesort" datasource="#DSN#">
		update artists
		set sort='#newsort#', name='#newname#'
		where ID=#ID#
	</cfquery>
	<cfoutput>#name# / #sort# = #newname# / #newsort#<br></cfoutput>
</cfloop>
<cfquery name="artists" datasource="#DSN#">
	update
	artists
	set sort=Right(sort,Len(sort)-3)
	where Left(name,4)='The ' AND Left(sort,3)='THE'
</cfquery>