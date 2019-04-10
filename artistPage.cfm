<cfabort>
<cflocation url="opussitelayout07main.cfm?lf=1666">
<cfset numItemsPerPage=60>
<cfparam name="url.rsPage" default="1">
<cfparam name="url.emf" default="stop">
<cfparam name="url.sid" default="0">
<cfparam name="url.oLd" default="">
<cfif catFind.recordCount GT #numItemsPerPage#>
<cfset numPages=Int((catFind.recordCount-1)/#numItemsPerPage#)+1>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="95%">
<tr>
<td width="37"><a href="javascript: history.go(-1);" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','buttonBack','images/buttonBack_f2.jpg','images/buttonBack_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','buttonBack','images/buttonBack_f3.jpg',1);"><img src="images/buttonBack.jpg" alt="" name="buttonBack" width="37" height="10" hspace="5" vspace="5" border="0" id="buttonBack" /></a></td>
<td><cfoutput>
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage-1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#x#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage+1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#">&nbsp;&nbsp;next&gt;&gt;</a></cfif></p>
</cfoutput></td>
<td width="37">&nbsp;</td>
</tr>
</table>
</cfif>
<table border="0" cellpadding="0" cellspacing="0" width="693" align="center">
<!-- fwtable fwsrc="opussitelayout07main.png" fwbase="opussitelayout07main.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="15" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="7" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="28" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="40" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="200" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="44" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="26" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="130" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="90" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="98" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="2" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td colspan="14"><img name="opussitelayout07main_r1_c1" src="images/opussitelayout07main_r1_c1.jpg" width="693" height="6" border="0" id="opussitelayout07main_r1_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  
  <tr>
   <td rowspan="2" colspan="14"><img name="opussitelayout07main_r5_c1" src="images/opussitelayout07main_r5_c1.jpg" width="693" height="21" border="0" id="opussitelayout07main_r5_c1" usemap="#m_opussitelayout07main_r5_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <cfset thisStartRow=(url.rsPage*#numItemsPerPage#)-#numItemsPerPage#+1>
   <cfoutput query="catFind" maxrows="#numItemsPerPage#" startrow="#thisStartRow#">
   	<cfset displayedID=ID>
	<cfif catFind.jpgLoaded AND NOT (fullImg NEQ "" AND url.sID NEQ 0)>
		<cfset imagefile="items/oI#catFind.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
	
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r10_c1" src="images/opussitelayout07main_r10_c1.jpg" width="693" height="5" border="0" id="opussitelayout07main_r10_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="5" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="3" background="images/opussitelayout07main_r11_c1.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td colspan="3" rowspan="2" valign="top" bgcolor="##333333"><table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td background="images/#imageFile#" style="background-position:top; background-repeat:no-repeat"><a href="opussitelayout07main.cfm?sID=#ID#" title="#title#"><img src="images/spacer.gif" width="75" height="75" border="0" /></a></td>
  </tr>
</table></td>
   <td rowspan="3" background="images/opussitelayout07main_r11_c5.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td valign="top" bgcolor="##333333" colspan="5"><font size="2"><a href="opussitelayout07main.cfm?af=#artistID#&group=all"><b>#artist#</b></a><br /><a href="opussitelayout07main.cfm?sID=#ID#" title="View Details and Recommendations">#title#</a> (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)</font><br /><a href="opussitelayout07main.cfm?lf=#labelID#&group=all">#label#</a> &nbsp;&nbsp;<a href="http://www.downtown304.com/index.cfm?sID=#ID#" target="_top" style="font-size: xx-small;">Item ID: ###ID#</a></td>
   <td colspan="2" rowspan="2" valign="top" bgcolor="##333333" class="detailsArtist"><font style="font-family: Arial, Helvetica, sans-serif; font-size:x-small; line-height:100%;"><cfif releaseDate NEQ "" AND albumStatusID NEQ 148>#DateFormat(releaseDate,"yyyy-mm-dd")#<cfelse>#DateFormat(DTdateUpdated,"yyyy-mm-dd")#</cfif><br />
		Cat. No.:<br />
		#Right(catnum,13)#<br />
		Genre: #genre#<br />
		#country#</font><br />
     	<cfif albumStatusID EQ 148>
			<b><font color="red">PRE-RELEASE</font></b>
		<cfelse>
		<cfset salePerc=70><cfif url.group EQ "sale"<!--- OR (DateFormat(DTDateUpdated,"yyyy-mm-dd") LT "2008-02-28" AND Left(shelfCode,1) NEQ 'D')//--->><b><font color="red" style="text-decoration:line-through;">#DollarFormat(price)#</font> #DollarFormat(price*salePerc/100)#</b><cfelse><b>#DollarFormat(price)#</cfif></b><br />
		<span class="style1">IN-STOCK</span><br />
		<cfif url.group EQ "sale" OR (DateFormat(DTDateUpdated,"yyyy-mm-dd") LT "2008-02-28" AND Left(shelfCode,1) NEQ 'D')><a href="cartAction.cfm?cAdd=#ID#&dos=oui&dosp=#salePerc#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a><cfelse>
		<a href="cartAction.cfm?cAdd=#ID#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a></cfif></cfif></td>
   <td rowspan="3" colspan="2" background="images/opussitelayout07main_r11_c13.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
    <td colspan="5" valign="top" bgcolor="##333333">
    <cfif hideTracks EQ 1><p><a href="javascript:showdiv(#ID#)">Click to see track listing</a></p></cfif>
	<div id="hideshow#ID#" <cfif hideTracks EQ 1> style="visibility:hidden;"</cfif>><table width="100%" border="0" cellpadding="0" >
	 <cfquery name="tracks" dbtype="query">
		select *
		from allTracks
		where catID=#catFind.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<tr>
			<cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
			<cfif tracks.mp3Loaded OR mp3Alt NEQ 0>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
				<td><img src="images/spacer.gif" width="3" height="1" /></td>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
			</tr>
		  <tr>
			<td align="center" bgcolor="##009933" width="12" height="12"><div align="center" class="style1"><a href="opussitelayout07player.cfm?oClip=#trID#" target="opusviewplayer" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
			<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
			<td align="center" bgcolor="##0066CC" width="12" height="12"><span class="style1"><a href="binaction.cfm?oClip=#tracks.ID#" target="opusviewbins" title="Add to Listening Bin" class="clickit"><font style="font-size: x-small;">B</font></a></span></td>
		  </tr>
		</table></td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	<cfelse>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table cellpadding="0" cellspacing="0" border="0" width="10"style="border-collapse:collapse;">
			<tr><td><img src="spacer.gif" width="9" height="10" border="0"></td></tr></table>
			</td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	</cfif>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks">#tName#</td>
      	</tr>
	  </cfloop> 
    </table></div>
    <cfif url.emf NEQ "go" AND Session.userID NEQ 0>
    	<p><a href="opussitelayout07main.cfm?sID=#ID#&emf=go" title="Email this title to a friend">Email to a Friend</a></p></cfif>
	</td>
    <td><img src="images/spacer.gif" width="1" height="9" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="3"><img name="opussitelayout07main_r13_c2" src="images/opussitelayout07main_r13_c2.jpg" width="75" height="2" border="0" id="opussitelayout07main_r13_c2" alt="" /></td>
   <td colspan="7"><img name="opussitelayout07main_r13_c6" src="images/opussitelayout07main_r13_c6.jpg" width="590" height="2" border="0" id="opussitelayout07main_r13_c6" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="2" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r14_c1" src="images/opussitelayout07main_r14_c1.jpg" width="693" height="3" border="0" id="opussitelayout07main_r14_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="3" border="0" alt="" /></td>
  </tr>
  <cfset thisFullImg=fullImg>
</cfoutput>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r17_c1" src="images/opussitelayout07main_r17_c1.jpg" width="693" height="22" border="0" id="opussitelayout07main_r17_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="22" border="0" alt="" /></td>
  </tr>
  
</table>


<!---<cfif catFind.recordCount GT 0>
<table border="0" cellpadding="0" cellspacing="0" width="693" align="center">
<!-- fwtable fwsrc="opussitelayout07main.png" fwbase="opussitelayout07main.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="15" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="7" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="28" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="40" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="200" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="44" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="26" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="130" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="90" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="98" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="2" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="6" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td colspan="14"><img name="opussitelayout07main_r1_c1" src="images/opussitelayout07main_r1_c1.jpg" width="693" height="6" border="0" id="opussitelayout07main_r1_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  
  <tr>
   <td rowspan="2" colspan="14"><img name="opussitelayout07main_r5_c1" src="images/opussitelayout07main_r5_c1.jpg" width="693" height="21" border="0" id="opussitelayout07main_r5_c1" usemap="#m_opussitelayout07main_r5_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  
   <cfoutput query="catFind">
   	<cfset displayedID=ID>
	<cfif catFind.jpgLoaded>
		<cfset imagefile="items/oI#catFind.ID#.jpg">
	<cfelseif logofile NEQ "">
		<cfset imagefile="labels/"&logofile>
	<cfelse>
		<cfset imagefile="labels/label_WhiteLabel.gif">
	</cfif>
	
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r10_c1" src="images/opussitelayout07main_r10_c1.jpg" width="693" height="5" border="0" id="opussitelayout07main_r10_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="5" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="3" background="images/opussitelayout07main_r11_c1.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td colspan="3" rowspan="2" valign="top" bgcolor="##333333"><table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td background="images/#imageFile#" style="background-position:top; background-repeat:no-repeat"><a href="opussitelayout07main.cfm?sID=#ID#" title="#title#"><img src="images/spacer.gif" width="75" height="75" border="0" /></a></td>
  </tr>
</table></td>
   <td rowspan="3" background="images/opussitelayout07main_r11_c5.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td valign="top" bgcolor="##333333" colspan="5"><font size="2"><a href="opussitelayout07main.cfm?af=#artistID#&group=all"><b>#artist#</b></a><br /><a href="opussitelayout07main.cfm?sID=#ID#" title="View Details and Recommendations">#title#</a> (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)</font><br /><a href="opussitelayout07main.cfm?lf=#labelID#&group=all">#label#</a></td>
   <td colspan="2" rowspan="2" valign="top" bgcolor="##333333" class="detailsArtist"><font style="font-family: Arial, Helvetica, sans-serif; font-size:x-small; line-height:100%;"><cfif releaseDate NEQ "" AND albumStatusID NEQ 148>#DateFormat(releaseDate,"yyyy-mm-dd")#<cfelse>#DateFormat(DTdateUpdated,"yyyy-mm-dd")#</cfif><br />
		Cat. No.:<br />
		#Right(catnum,13)#<br />
		Genre: #genre#<br />
		#country#</font><br />
     	<cfif albumStatusID EQ 148>
			<b><font color="red">PRE-RELEASE</font></b>
		<cfelse>
		<cfset salePerc=79><cfif url.group EQ "sale"><b><font color="red" style="text-decoration:line-through;">#DollarFormat(price)#</font> #DollarFormat(price*salePerc/100)#</b><cfelse><b>#DollarFormat(price)#</cfif></b><br />
		<span class="style1">IN-STOCK</span><br />
		<cfif DollarFormat(price) EQ "$0.00">PROMO ONLY NOT FOR SALE<cfelse><cfif url.group EQ "sale"><a href="cartAction.cfm?cAdd=#ID#&dos=oui&dosp=#salePerc#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a><cfelse>
		<a href="cartAction.cfm?cAdd=#ID#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a></cfif></cfif></cfif></td>
   <td rowspan="3" colspan="2" background="images/opussitelayout07main_r11_c13.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
    <td colspan="5" valign="top" bgcolor="##333333">
    <cfif hideTracks EQ 1><p><a href="javascript:showdiv(#ID#)">Click to see track listing</a></p></cfif>
	<div id="hideshow#ID#" <cfif hideTracks EQ 1> style="visibility:hidden;"</cfif>><table width="100%" border="0" cellpadding="0" >
	 <cfquery name="tracks" dbtype="query">
		select *
		from allTracks
		where catID=#catFind.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<tr>
			<cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
			<cfif tracks.mp3Loaded OR mp3Alt NEQ 0>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
				<td><img src="images/spacer.gif" width="3" height="1" /></td>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>
			</tr>
		  <tr>
			<td align="center" bgcolor="##009933" width="12" height="12"><div align="center" class="style1"><a href="opussitelayout07player.cfm?oClip=#trID#" target="opusviewplayer" title="Play" class="clickit"><font style="font-size: x-small;">&gt;</font></a></div></td>
			<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
			<td align="center" bgcolor="##0066CC" width="12" height="12"><span class="style1"><a href="binaction.cfm?oClip=#tracks.ID#" target="opusviewbins" title="Add to Listening Bin" class="clickit"><font style="font-size: x-small;">B</font></a></span></td>
		  </tr>
		</table></td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	<cfelse>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table cellpadding="0" cellspacing="0" border="0" width="10"style="border-collapse:collapse;">
			<tr><td><img src="spacer.gif" width="9" height="10" border="0"></td></tr></table>
			</td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	</cfif>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks">#tName#</td>
      	</tr>
	  </cfloop> 
    </table></div>
	</td>
    <td><img src="images/spacer.gif" width="1" height="9" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="3"><img name="opussitelayout07main_r13_c2" src="images/opussitelayout07main_r13_c2.jpg" width="75" height="2" border="0" id="opussitelayout07main_r13_c2" alt="" /></td>
   <td colspan="7"><img name="opussitelayout07main_r13_c6" src="images/opussitelayout07main_r13_c6.jpg" width="590" height="2" border="0" id="opussitelayout07main_r13_c6" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="2" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r14_c1" src="images/opussitelayout07main_r14_c1.jpg" width="693" height="3" border="0" id="opussitelayout07main_r14_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="3" border="0" alt="" /></td>
  </tr>
  <cfset thisFullImg=fullImg>
</cfoutput>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r17_c1" src="images/opussitelayout07main_r17_c1.jpg" width="693" height="22" border="0" id="opussitelayout07main_r17_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="22" border="0" alt="" /></td>
  </tr>
  
</table>
</cfif>//--->