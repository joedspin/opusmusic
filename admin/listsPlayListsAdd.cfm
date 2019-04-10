<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="allArtists" datasource="#DSN#">
	select *
	from artists
	order by sort, name
</cfquery>
<cfform name="chooseArtist" method="post" action="listsPlayListsAddAction.cfm">
	<p><b>Choose an Artist*</b><br />
	<cfselect query="allArtists" display="name" value="ID" name="artistID"></cfselect></p>
	<p><b>List Name: </b><cfinput type="text" name="listName" size="40" maxlength="50"></p>
	<p><b>List Date: </b><cfinput type="text" name="listDate" size="15" maxlength="10"></p>
	<p><b>Active: </b><cfinput type="checkbox" name="active" value="yes" checked="yes"></p>
	<cfinput type="submit" name="submit" value=" Create List ">
</cfform>
<cfinclude template="pageFoot.cfm">