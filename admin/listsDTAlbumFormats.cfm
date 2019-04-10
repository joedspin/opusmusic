<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm"><cfquery name="formats" datasource="#DSN#">
	select *
    from DTAlbumFormats
    order by NRECSINSET, MEDIATYPE
</cfquery>
<table border="1">
<cfoutput query="formats">
<tr>
<td>#ID#&nbsp;</td>
<td>#Album_Format_Name#&nbsp;</td>
<td>#NRECSINSET#&nbsp;</td>
<td>#MEDIATYPE#&nbsp;</td>
<td>#mediaID#&nbsp;</td>
</tr>
</cfoutput>
</table>
<cfinclude template="pageFoot.cfm">