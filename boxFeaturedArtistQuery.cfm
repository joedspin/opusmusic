<cfquery name="fArtist" datasource="#DSN#" maxrows="1"><!---cachedwithin="#CreateTimeSpan(0,1,0,0)#"//--->
	select *
	from artists
	where featured=1
</cfquery>
<cfparam name="url.aID" default="#fArtist.ID#">
<cfquery name="afArtist" datasource="#DSN#">
		select *
		from artists
		where ID=<cfqueryparam value="#url.aID#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfif afArtist.name EQ ""><cfset searchArtist="NONE FOUND NO SEARCH"><cfelse><cfset searchArtist=afArtist.name></cfif>
<!---<cfquery name="artistFocus" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,2,0,0)#" maxrows="4">
	select *
    from catItemsQuery
    where (artistID=#url.aID# 
			OR artist LIKE '%#searchArtist#%'
			OR title LIKE '%#searchArtist#%') AND ((albumStatusID<25 AND ONHAND>0) OR ONSIDE>0) AND ONSIDE<>999 AND (media='12"' OR media='LP')
    order by releaseDate DESC
</cfquery>//--->
<cfquery name="artistFocus" datasource="#DSN#" maxrows="6">
	select * from catItemsQuery where ID IN (select DISTINCT itemID from catTracksQuery
	where (artist LIKE <cfqueryparam value="%#searchArtist#%" cfsqltype="cf_sql_char"> OR
		title LIKE <cfqueryparam value="%#searchArtist#%" cfsqltype="cf_sql_char"> OR
		label LIKE <cfqueryparam value="%#searchArtist#%" cfsqltype="cf_sql_char"> OR
		tName LIKE <cfqueryparam value="%#searchArtist#%" cfsqltype="cf_sql_char">)
		AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999) AND (media='12"' OR media='LP') 
		order by releaseDate DESC
</cfquery>
<style type="text/css">
<!--
.stylea7 {font-family: Arial, Helvetica, sans-serif; font-size: xx-small; color: #FFFFFF; }
.stylea8 {font-size: xx-small}
.stylea9 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: x-small;
}
.stylea2 {font-family: Arial, Helvetica, sans-serif}
.stylea3 {font-size: large;}
-->
</style>
<table border="0" cellpadding="5" bgcolor="#333333" width="320">
  <tr>
    <td><table border="0" cellpadding="0">
      <tr>
        <cfoutput><td colspan="3" align="left" valign="top"><a href="opussitelayout07main.cfm?af=#url.aID#&amp;group=all" class="stylea3 stylea2" style="text-decoration:none; color:##FFFFFF"><strong>#searchArtist#</strong></a></td>
      </tr></cfoutput>
            <tr>
        <td colspan="3" align="center" valign="top"><img src="http://www.downtown304.com/images/spacer.gif" width="10" height="10"></td>
      </tr>
<cfset rowStart=true>
<cfoutput query="artistFocus">
	<cfif jpgLoaded>
		<cfset imagefile="items/oI#ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
<cfif rowStart><tr><cfelse><td align="center" valign="top"><img src="http://www.downtown304.com/images/spacer.gif" width="25" height="10" /></td></cfif>
        <td align="center" valign="top"><a href="opussitelayout07main.cfm?sID=#ID#" title="#title#"><img src="http://www.downtown304.com/images/#imageFile#" width="75" height="75" border="0" /></a><br>
        <span class="stylea7"><strong>#Left(artist,29)#</strong><br />
          #Left(title,29)#<!---<br />
          <span class="stylea8">(#label#)</span>//---></span></td>
      <cfif NOT rowStart>
	  	  </tr>
		  <tr>
			<td colspan="3" align="center" valign="top">&nbsp;</td>
		  </tr>
	  	<cfset rowStart=true>
	  <cfelse>
	  	<cfset rowStart=false>
	  </cfif>
</cfoutput>
      <tr>
        <td colspan="3" align="center" valign="top"><div class="stylea9">
          <cfoutput><a href="http://www.downtown304.com/opussitelayout07main.cfm?af=#url.aID#&amp;group=all" style="text-decoration:none; color:##FFFFFF">Other releases from #searchArtist# . . . </a></cfoutput>
        </div></td>
        </tr>
      <tr>
        <td colspan="3" align="center" valign="top"><img src="http://www.downtown304.com/images/spacer.gif" width="10" height="10"></td>
      </tr>
    </table></td>
  </tr>
</table>