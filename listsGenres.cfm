<cfinclude template="pageHead.cfm">
<!---cfinclude template="topNav.cfm">
    <cfinclude template="middleNav.htm">//--->
		<cfinclude template="middleNav.cfm">
    <cfquery name="allGenres" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,0,0,1)#">
	select DISTINCT genre, genreID
    from catItemsQuery 
		WHERE (((Left([shelfCode],1))='D') OR isVendor=1) AND ((AlbumStatusID <25 AND ONHAND>0) OR (ONSIDE>0 AND ONSIDE<900)) AND genre<>''
   order by genre
  </cfquery>
<h4 align="center">Genres</h4>
<style>td {font-size: small;}
a:link {
	color:#FFF;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color:#FFF;
}
a:hover {
	text-decoration: none;
	color:#000;
}
a:active {
	text-decoration: none;
	color:#CCCCCC;
}</style>
<cfset rowEnd=false>
<table border="0" cellpadding="5" cellspacing="2" align="center">
<cfoutput query="allGenres">
<cfif NOT rowEnd><tr><td bgcolor="##669934" width="180"><a href="opussitelayout07main.cfm?gf=#genreID#&group=all" alt="Browse #genre#">#genre#</a></td>
<cfset rowEnd=true><cfelse><td bgcolor="##669934" width="180"><a href="opussitelayout07main.cfm?gf=#genreID#&group=all" alt="Browse #genre#">#genre#</a></td>
</tr><cfset rowEnd=false></cfif>
</cfoutput>
<cfif rowEnd><td bgcolor="#666666">&nbsp;</td>
</tr></cfif>
</table>
<p align="center"><a href="http://www.downtown304.com/opussitelayout07main.cfm?group=sevens">Click here to browse 7-inch singles</a></p>
  <cfinclude template="pageFoot.cfm">