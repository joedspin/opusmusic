<cfparam name="url.lID" default="353">
<cfquery name="labelFocus" datasource="#DSN#" maxrows="4">
	select *
    from catItemsQuery
    where labelID=<cfqueryparam value="#url.lID#" cfsqltype="cf_sql_integer"> AND ((albumStatusID<25 AND ONHAND>0) OR ONSIDE>0) AND ONSIDE<>999 AND media NOT LIKE '%CD%' order by releaseDate DESC
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
<table border="0" cellpadding="5" bgcolor="#FF9900" width="100%">
  <tr>
    <td><table border="0" cellpadding="0">
      <tr>
        <cfoutput><td colspan="3" align="left" valign="top"><a href="opussitelayout07main.cfm?lf=#url.lID#&amp;group=all" class="stylea3 stylea2" style="text-decoration:none; color:##FFFFFF"><strong>#labelFocus.label#</strong></a></td>
      </tr></cfoutput>
            <tr>
        <td colspan="3" align="center" valign="top"><img src="images/spacer.gif" width="10" height="10"></td>
      </tr>
      <cfset rowStart=true>
<cfoutput query="labelFocus">
	<cfif jpgLoaded>
		<cfset imagefile="items/oI#ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
<cfif rowStart><tr><cfelse><td align="center" valign="top"><img src="images/spacer.gif" width="25" height="10" /></td></cfif>
        <td align="center" valign="top"><a href="opussitelayout07main.cfm?sID=#ID#" title="#title#"><img src="images/#imageFile#" width="75" height="75" border="0" /></a><br>
        <span class="stylea7"><strong>#Left(artist,30)#</strong><br />
          #Left(title,30)#<!---<br />
          <span class="stylea8">(#label#)</span>//---></span></td>
      <cfif NOT rowStart></tr>
      <tr>
        <td align="center" valign="top">&nbsp;</td>
        <td align="center" valign="top">&nbsp;</td>
        <td align="center" valign="top">&nbsp;</td>
      </tr><cfset rowStart=true><cfelse><cfset rowStart=false></cfif>
</cfoutput>
      <tr>
        <td colspan="3" align="center" valign="top"><div class="stylea9">
          <cfoutput><a href="opussitelayout07main.cfm?lf=#url.lID#&amp;group=all" style="text-decoration:none; color:##FFFFFF">Other releases from #labelFocus.label# . . . </a></cfoutput>
        </div></td>
        </tr>
      <tr>
        <td colspan="3" align="center" valign="top"><img src="images/spacer.gif" width="10" height="10"></td>
      </tr>
    </table></td>
  </tr>
</table>

<img src="images/spacer.gif" width="200" height="10" />
<cfquery name="artistCharts" datasource="#DSN#" maxrows="9" cachedwithin="#CreateTimeSpan(0, 3, 0, 0)#">
	select artistID, artist, listName, ID
	from artistListsQuery
	where artistID<>15387 AND active=1
	order by listDate DESC
</cfquery>
<style type="text/css">
<!--
.style2 {
	font-size: large;
	font-family: Arial, Helvetica, sans-serif;
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<table border="0" cellpadding="0" cellspacing="0"  width="100%">
<!-- fwtable fwsrc="opussitelayout07lists.png" fwbase="opussitelayout07lists.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td width="13"><img src="images/spacer.gif" width="13" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" height="1" border="0" alt="" /></td>
   <td width="12"><img src="images/spacer.gif" width="12" height="1" border="0" alt="" /></td>
   <td width="1"><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td><img name="opussitelayout07lists_r1_c1" src="images/opussitelayout07lists_r1_c1.jpg" width="13" height="10" border="0" id="opussitelayout07lists_r1_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r1_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r1_c3" src="images/opussitelayout07lists_r1_c3.jpg" width="12" height="10" border="0" id="opussitelayout07lists_r1_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="10" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r2_c1" src="images/opussitelayout07lists_r2_c1.jpg" width="13" height="24" border="0" id="opussitelayout07lists_r2_c1" alt="" /></td>
   <td width="290" align="left" valign="top" bgcolor="#006699"><span class="style2">Play Lists</span></td>
   <td><img name="opussitelayout07lists_r2_c3" src="images/opussitelayout07lists_r2_c3.jpg" width="12" height="24" border="0" id="opussitelayout07lists_r2_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="24" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r3_c1" src="images/opussitelayout07lists_r3_c1.jpg" width="13" height="6" border="0" id="opussitelayout07lists_r3_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r3_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r3_c3" src="images/opussitelayout07lists_r3_c3.jpg" width="12" height="6" border="0" id="opussitelayout07lists_r3_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="6" border="0" alt="" /></td>
  </tr>
  <tr>
   <td background="images/opussitelayout07lists_r4_c1.jpg"><img src="images/spacer.gif" width="1" heigth="1" /></td>
   <td valign="top" bgcolor="#333333"><table border=0 align="left" cellpadding=4 cellspacing=0>
     <cfoutput query="artistCharts">
	 <tr>
       <td align="left"><a href="artistCharts.cfm?artistID=#artistID#&chartID=#ID#"><b>#artist#</b> &nbsp;&nbsp;#listName#</a></td>
     </tr>
	 </cfoutput>  
	 <tr>
	 	<td align="left"><a href="artistChartsList.cfm" style="color:#FFCC33;">See Complete List of Artist Play Lists &gt;&gt;</a></td>
	 </tr> 
</table></td>
   <td background="images/opussitelayout07lists_r4_c3.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="78" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r5_c1" src="images/opussitelayout07lists_r5_c1.jpg" width="13" height="12" border="0" id="opussitelayout07lists_r5_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r5_c2.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img name="opussitelayout07lists_r5_c3" src="images/opussitelayout07lists_r5_c3.jpg" width="12" height="12" border="0" id="opussitelayout07lists_r5_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="12" border="0" alt="" /></td>
  </tr>
</table>
