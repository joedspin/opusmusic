<cfset pageName="LISTS">
<cfparam name="url.added" default="">
<cfinclude template="pageHead.cfm">
<form action="listsShelvesAction.cfm" method="post">
	<input type="text" name="code" size="4" maxlength="2"><input type="text" name="partner" size="20"><input type="checkbox" name="isVendor" value="yes">Is Vendor?<input type="submit" name="submit" value="Add">
</form>
<cfquery name="shelves" datasource="#DSN#">
	select *
	from shelf
	order by code
</cfquery>
<!---<p><a href="listsGenresAdd.cfm">ADD NEW GENRE</a></p>//--->
<p><cfoutput query="shelves">
	<!---<a href="listsGenresEdit.cfm?ID=#ID#">EDIT</a> | <a href="listsGenresDelete.cfm?ID=#ID#">DELETE</a>//---><font face="Courier New, Courier, monospace">#code#</font> : #NumberFormat(ID,"00")# : #partner# <cfif isVendor EQ 1><font color="##66CC00">[Vendor]</font></cfif> <cfif code EQ url.added><font color="red">ADDED</font></cfif><br />
</cfoutput></p>