<cfparam name="url.group" default="">
<cfparam name="pageGroup" default="">
<cfparam name="url.setsite" default="">
<cfif url.setsite EQ "161"><cfset sitePage="dt161main.cfm"></cfif>
<cfif url.group NEQ ""><cfset pageGroup=url.group></cfif>
<style type="text/css">
<!--
.style111 {color: #FFCC00}
.style112 {font-size: medium}
.style113 {color: #FFFFFF}
-->
</style>

<table border="0" cellpadding="0" cellspacing="0" width="541" align="center" style="margin-top:10px;">
<!-- fwtable fwsrc="topnav_v2.png" fwbase="topnav_v2.jpg" fwstyle="Dreamweaver" fwdocid = "841162120" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="76" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="76" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="76" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="76" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="76" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="76" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="76" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="2" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="15"><img name="topnav_v2_r1_c1" src="images/topnav_v2_r1_c1.jpg" width="541" height="1" border="0" id="topnav_v2_r1_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="2"><img name="topnav_v2_r2_c1" src="images/topnav_v2_r2_c1.jpg" width="1" height="31" border="0" id="topnav_v2_r2_c1" alt="" /></td>
   <cfif Find("opus",sitePage) GT 0><cfset homelink="opusviewlists.cfm"><cfelse><cfset homelink="dt161landing.cfm"></cfif>
   <td><a href="<cfoutput>#homelink#</cfoutput>" <cfif url.setsite EQ "161">target="opusviewmain"</cfif> onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','topnav_v2_r2_c2','images/topnav_v2_r2_c2_f2.jpg','images/topnav_v2_r2_c2_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','topnav_v2_r2_c2','images/topnav_v2_r2_c2_f3.jpg',1);"><img name="topnav_v2_r2_c2" src="images/topnav_v2_r2_c2<cfif pageGroup EQ "home">_f3</cfif>.jpg" width="76" height="30" border="0" id="topnav_v2_r2_c2" alt="Home" /></a></td>
   <td rowspan="2"><img name="topnav_v2_r2_c3" src="images/topnav_v2_r2_c3.jpg" width="1" height="31" border="0" id="topnav_v2_r2_c3" alt="" /></td>
   <td><a href="<cfoutput>#sitePage#</cfoutput>?group=new" <cfif url.setsite EQ "161">target="opusviewmain"</cfif> onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','topnav_v2_r2_c4','images/topnav_v2_r2_c4_f2.jpg','images/topnav_v2_r2_c4_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','topnav_v2_r2_c4','images/topnav_v2_r2_c4_f3.jpg',1);"><img name="topnav_v2_r2_c4" src="images/topnav_v2_r2_c4<cfif pageGroup EQ "new">_f3</cfif>.jpg" width="76" height="30" border="0" id="topnav_v2_r2_c4" alt="" /></a></td>
   <td rowspan="2"><img name="topnav_v2_r2_c5" src="images/topnav_v2_r2_c5.jpg" width="1" height="31" border="0" id="topnav_v2_r2_c5" alt="" /></td>
   <td><a href="<cfoutput>#sitePage#</cfoutput>?group=back" <cfif url.setsite EQ "161">target="opusviewmain"</cfif> onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','topnav_v2_r2_c6','images/topnav_v2_r2_c6_f2.jpg','images/topnav_v2_r2_c6_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','topnav_v2_r2_c6','images/topnav_v2_r2_c6_f3.jpg',1);"><img name="topnav_v2_r2_c6" src="images/topnav_v2_r2_c6<cfif pageGroup EQ "back">_f3</cfif>.jpg" width="76" height="30" border="0" id="topnav_v2_r2_c6" alt="Back in Stock" /></a></td>
   <td rowspan="2"><img name="topnav_v2_r2_c7" src="images/topnav_v2_r2_c7.jpg" width="1" height="31" border="0" id="topnav_v2_r2_c7" alt="" /></td>
   <td><a href="<cfoutput>#sitePage#</cfoutput>?group=reissues" <cfif url.setsite EQ "161">target="opusviewmain"</cfif> onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','topnav_v2_r2_c8','images/topnav_v2_r2_c8_f2.jpg','images/topnav_v2_r2_c8_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','topnav_v2_r2_c8','images/topnav_v2_r2_c8_f3.jpg',1);"><img name="topnav_v2_r2_c8" src="images/topnav_v2_r2_c8<cfif pageGroup EQ "reissues">_f3</cfif>.jpg" width="76" height="30" border="0" id="topnav_v2_r2_c8" alt="Reissues" /></a></td>
   <td rowspan="2"><img name="topnav_v2_r2_c9" src="images/topnav_v2_r2_c9.jpg" width="1" height="31" border="0" id="topnav_v2_r2_c9" alt="" /></td>
   <td><a href="<cfoutput>#sitePage#</cfoutput>?group=sale" <cfif url.setsite EQ "161">target="opusviewmain"</cfif> onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','topnav_v2_r2_c12','images/topnav_v2_r2_c12_f2.jpg','images/topnav_v2_r2_c12_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','topnav_v2_r2_c12','images/topnav_v2_r2_c12_f3.jpg',1);"><img name="topnav_v2_r2_c12" src="images/topnav_v2_r2_c12<cfif pageGroup EQ "sale">_f3</cfif>.jpg" width="76" height="30" border="0" id="topnav_v2_r2_c12" alt="Sale" /></a></td>
   <td rowspan="2"><img name="topnav_v2_r2_c13" src="images/topnav_v2_r2_c13.jpg" width="1" height="31" border="0" id="topnav_v2_r2_c13" alt="" /></td>
   <td><a href="labelList.cfm" onmouseout="MM_nbGroup('out');" <cfif url.setsite EQ "161">target="opusviewmain"</cfif> onmouseover="MM_nbGroup('over','topnav_v2_r2_c14','images/topnav_v2_r2_c14_f2.jpg','images/topnav_v2_r2_c14_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','topnav_v2_r2_c14','images/topnav_v2_r2_c14_f3.jpg',1);"><img name="topnav_v2_r2_c14" src="images/topnav_v2_r2_c14<cfif pageGroup EQ "labels">_f3</cfif>.jpg" width="76" height="30" border="0" id="topnav_v2_r2_c14" alt="Labels" /></a></td>
   <td rowspan="2"><img name="topnav_v2_r2_c15" src="images/topnav_v2_r2_c15.jpg" width="1" height="31" border="0" id="topnav_v2_r2_c15" alt="" /></td>
   <td><a href="artistList.cfm" onmouseout="MM_nbGroup('out');" <cfif url.setsite EQ "161">target="opusviewmain"</cfif> onmouseover="MM_nbGroup('over','topnav_v2_r2_c16','images/topnav_v2_r2_c16_f2.jpg','images/topnav_v2_r2_c16_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','topnav_v2_r2_c16','images/topnav_v2_r2_c16_f3.jpg',1);"><img name="topnav_v2_r2_c16" src="images/topnav_v2_r2_c16<cfif pageGroup EQ "artists">_f3</cfif>.jpg" width="76" height="30" border="0" id="topnav_v2_r2_c16" alt="Artists" /></a></td>
   <td rowspan="2"><img name="topnav_v2_r2_c17" src="images/topnav_v2_r2_c17.jpg" width="2" height="31" border="0" id="topnav_v2_r2_c17" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="30" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="topnav_v2_r3_c2" src="images/topnav_v2_r3_c2.jpg" width="76" height="1" border="0" id="topnav_v2_r3_c2" alt="" /></td>
   <td><img name="topnav_v2_r3_c4" src="images/topnav_v2_r3_c4.jpg" width="76" height="1" border="0" id="topnav_v2_r3_c4" alt="" /></td>
   <td><img name="topnav_v2_r3_c6" src="images/topnav_v2_r3_c6.jpg" width="76" height="1" border="0" id="topnav_v2_r3_c6" alt="" /></td>
   <td><img name="topnav_v2_r3_c10" src="images/topnav_v2_r3_c10.jpg" width="76" height="1" border="0" id="topnav_v2_r3_c10" alt="" /></td>
   <td><img name="topnav_v2_r3_c12" src="images/topnav_v2_r3_c12.jpg" width="76" height="1" border="0" id="topnav_v2_r3_c12" alt="" /></td>
   <td><img name="topnav_v2_r3_c14" src="images/topnav_v2_r3_c14.jpg" width="76" height="1" border="0" id="topnav_v2_r3_c14" alt="" /></td>
   <td><img name="topnav_v2_r3_c16" src="images/topnav_v2_r3_c16.jpg" width="76" height="1" border="0" id="topnav_v2_r3_c16" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
</table>
