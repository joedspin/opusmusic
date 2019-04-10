<cfset pageName="LISTS">
<cfparam name="url.letter" default="a">
<cfparam name="url.find" default="">
<cfparam name="form.find" default="#url.find#">
<cfinclude template="pageHead.cfm">
<form name="labelFind" action="listsArtists.cfm" method="post">
<input type="text" name="find" /><input type="submit" name="submit" value="Find" />
</form>
<cfif form.find NEQ "">
	<cfquery name="allArtists" datasource="#DSN#">
		select *
		from artists
		where name LIKE '%#form.find#%' order by sort
	</cfquery>
<cfelseif url.letter EQ "nosort">
	<cfquery name="allArtists" datasource="#DSN#">
		select *
		from artists
		where sort='' or sort is Null
	</cfquery>
<cfelseif url.letter EQ "repress">
	<cfquery name="allArtists" datasource="#DSN#">
		select *
		from artists
		where name LIKE '%repress%' OR name LIKE '%re-press%' OR name LIKE '%re press%'
		order by sort
	</cfquery>
<cfelseif url.letter EQ "commas">
	<cfquery name="allArtists" datasource="#DSN#">
		select *
		from artists
		where name LIKE '%,%'
		order by sort
	</cfquery>
<cfelse>
	<cfquery name="allArtists" datasource="#DSN#">
		select *
		from artists
		where ((sort='' OR sort Is Null) AND Left(name,1)='#url.letter#') OR Left(sort,1)='#url.letter#'
		order by sort
	</cfquery>
</cfif>
<cfquery name="letterList" datasource="#DSN#">
	select DISTINCT Left(sort,1) As artistLetter
	from artists ORDER BY Left(sort,1)
</cfquery>
<p><cfoutput query="letterList"><cfif artistLetter NEQ ""><a href="listsArtists.cfm?letter=#artistLetter#">#artistLetter#</a>
<cfelse><a href="listsArtists.cfm?letter=nosort">[no sort]</a></cfif> </cfoutput>
<a href="listsArtists.cfm?letter=repress">repress</a> <a href="listsArtists.cfm?letter=commas">commas</a></p>
<p><a href="listsArtistsAdd.cfm">ADD NEW ARTIST</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="listsArtistsFeatured.cfm">FEATURED ARTIST</a> </p>
<table border="1" style="border-collapse:collapse;" cellpadding="2">
	<cfoutput query="allArtists">
		<tr>
			<td><a href="listsArtistsEdit.cfm?ID=#ID#&letter=#url.letter#&find=#form.find#">EDIT</a></td>
			<td><a href="listsArtistsFixCase.cfm?ID=#ID#&letter=#url.letter#">FIX CASE</a></td>
			<td><a href="listsArtistsNameSwap.cfm?ID=#ID#&letter=#url.letter#">SWAP</a></td>
			<td><a href="listsArtistsDelete.cfm?ID=#ID#&letter=#url.letter#&find=#form.find#">DELETE</a></td>
			<td>#name#</td>
			<td>#sort#</td>
            <td><a href="listsArtistsLinkCode.cfm?ID=#ID#" target="_blank">LINK CODE</a></td>
			<td><cfif website NEQ ""><a href="#website#" target="_blank">#website#</a></cfif>&nbsp;</td>
		</tr>
	</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">