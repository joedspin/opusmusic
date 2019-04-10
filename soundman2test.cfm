<cfset addSale=false>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>downtown304.com</title>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>


<link rel="stylesheet" type="text/css" href="soundmanagerv297a-20120318/demo/play-mp3-links/css/inlineplayer.css" />
<link rel="stylesheet" type="text/css" href="soundmanagerv297a-20120318/demo/flashblock/flashblock.css" />
<!---<script type="text/javascript" src="../../script/soundmanager2.js"></script>//--->
<script src="/soundmanagerv297a-20120318/script/soundmanager2-nodebug-jsmin.js"></script>
<script type="text/javascript" src="soundmanagerv297a-20120318/demo/play-mp3-links/script/inlineplayer.js"></script>
<script>
soundManager.url = '/soundmanagerv297a-20120318/swf/';
soundManager.flashVersion = 9; 
soundManager.useFlashBlock = false; 
soundManager.onready(function() {});
</script>
<style type="text/css">
<!--
body {
	background-color: #000000;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: white;
}
.style1 {color: #FFCC00;	font-weight: bold;}
.style2 {color: #333333}
.style3 {color:#FF6699;	font-weight: bold;}
.style5 {color: #000000; font-weight: bold; }
-->
</style></head>
<body onload="MM_preloadImages('images/topnav_v2_r2_c2_f2.jpg','images/topnav_v2_r2_c2_f3.jpg','images/topnav_v2_r2_c4_f2.jpg','images/topnav_v2_r2_c4_f3.jpg','images/topnav_v2_r2_c6_f2.jpg','images/topnav_v2_r2_c6_f3.jpg','images/topnav_v2_r2_c8_f2.jpg','images/topnav_v2_r2_c8_f3.jpg','images/topnav_v2_r2_c10_f2.jpg','images/topnav_v2_r2_c10_f3.jpg','images/topnav_v2_r2_c12_f2.jpg','images/topnav_v2_r2_c12_f3.jpg','images/topnav_v2_r2_c14_f2.jpg','images/topnav_v2_r2_c14_f3.jpg','images/topnav_v2_r2_c16_f2.jpg','images/topnav_v2_r2_c16_f3.jpg');">
<div id="sm2-container">
  <!-- SM2 flash goes here -->
 </div>
<cfset sitePage="opussitelayout07main.cfm">
<cfinclude template="topNav.cfm">
<cfset siteChoice="304">
<cfset trackChoice="Application.allTracks">
<cfinclude template="catFind.cfm">
<cfif catFind.recordCount EQ 0>
<p align="center" class="detailsArtist">&nbsp;</p>
<p align="center" class="detailsArtist"><br /><b>NO RECORDS FOUND MATCHING YOUR SEARCH CRITERIA</b></p>
<p align="center" class="detailsArtist">&nbsp;</p>
<cfelse>
<cfif url.group EQ "preview">
<p align="center"><img src="images/PreviewImportsHead.jpg" width="600" height="87" border="0" /></p>
</cfif>
<cfif url.lf NEQ "">
    <cfquery name="thisLabel" dbtype="query">
        select *
        from labels
        where ID=<cfqueryparam value="#url.lf#" cfsqltype="cf_sql_integer">
    </cfquery>
<!---    <cfoutput query="thisLabel">
    <p style="font-size: x-large; font-weight:bold;" align="center">#name#</p>
    </cfoutput>
    <cfinclude template="boxTopSellersLabel.cfm">//--->
</cfif>
<cfif catFind.recordCount GT #numItemsPerPage#>
<cfset numPages=Int((catFind.recordCount-1)/#numItemsPerPage#)+1>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="95%">
<tr>
<td width="37"><a href="javascript: history.go(-1);" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','buttonBack','images/buttonBack_f2.jpg','images/buttonBack_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','buttonBack','images/buttonBack_f3.jpg',1);"><img src="images/buttonBack.jpg" alt="" name="buttonBack" width="37" height="10" hspace="5" vspace="5" border="0" id="buttonBack" /></a></td>
<td><cfoutput>
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage-1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&sale=#url.sale#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#x#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&sale=#url.sale#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage+1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&sale=#url.sale#">&nbsp;&nbsp;next&gt;&gt;</a></cfif></p>
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
  <cfif url.prerelease EQ "allow">
  	
  </cfif>
   <cfoutput query="catFind" maxrows="#numItemsPerPage#" startrow="#thisStartRow#">
   	<cfset displayedID=ID>
    <!---<cfif NOT isNumeric(displayedID)><cfmail to="order@downtown304.com" from="info@downtown304.com" subject="displayedID is not numberic">displayedID = #displayedID#</cfmail><cfabort></cfif>//--->
	<cfif catFind.jpgLoaded AND NOT (fullImg NEQ "" AND url.sID NEQ 0)>
		<cfset imagefile="items/oI#catFind.ID#.jpg">
    <cfelseif catFind.jpgLoaded AND logofile EQ "">
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
    <td background="images/#imageFile#" style="background-position:top; background-repeat:no-repeat"><a href="opussitelayout07main.cfm?sID=#ID#" title="#title#"><img src="images/spacer.gif" width="75" height="75" border="0" /></a><!---<cfif discogsID NEQ "" AND discogsID NEQ 0 AND discogsID NEQ -1><br />
		<a href="http://www.discogs.com/release/#discogsID#" title="See this item on Discogs" target="_blank"><img src="images/discogslogo.jpg" width="75" height="25" border="0" alt="See the Discogs entry for this item" /></a></cfif>//---></td>
  </tr>
</table></td>
   <td rowspan="3" background="images/opussitelayout07main_r11_c5.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td valign="top" bgcolor="##333333" colspan="5"><font size="2"><a href="opussitelayout07main.cfm?af=#artistID#&group=all"><b>#artist#</b></a><br /><a href="opussitelayout07main.cfm?sID=#ID#" title="View Details and Recommendations">#title# <cfif Find("Reissue",title) EQ 0 AND (genreID EQ 7 OR reissue EQ 1)>[Reissue]</cfif></a> (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)</font><br /><a href="opussitelayout07main.cfm?lf=#labelID#&group=all">#label#</a> <!---&nbsp;&nbsp;<a href="http://www.downtown304.com/index.cfm?sID=#ID#" target="_top" style="font-size: xx-small;">Item ID: ###ID#</a>//---><cfset activeItemID=ID></td>
   <td colspan="2" rowspan="2" valign="top" bgcolor="##333333" class="detailsArtist"><font style="font-family: Arial, Helvetica, sans-serif; font-size:x-small; line-height:100%;"><cfif releaseDate NEQ "" AND albumStatusID NEQ 148  AND albumStatusID NEQ 44>#DateFormat(releaseDate,"mmm d yyyy")#<br /><cfelseif albumStatusID NEQ 44>#DateFormat(DTdateUpdated,"mmm d yyyy")#<br />
		</cfif>Cat. No.:<br />
		#Right(catnum,13)#<br />
		Genre: #genre#<br />
		#country#</font><br />
     	<cfif albumStatusID EQ 148 OR (albumStatusID EQ 44 AND ONHAND EQ 0 AND ONSIDE EQ 0)>
			<b><font color="red">PRE-RELEASE</font></b>
		<cfelse>
			<cfset salePerc=66>
            <cfif url.group EQ "sale" OR url.group EQ "hurricane" OR price LT pricesave<!---OR url.sale EQ "volcano" OR (DateFormat(blueDate,"yyyy-mm-dd") EQ DateFormat(varDateODBC,"yyyy-mm-dd")) OR (isVendor EQ 1 AND Left(shelfCode,1) NEQ 'D' AND DateCompare(DateFormat(DTDateUpdated,"mm/dd/yyyy"),#varDateODBC#) GT 120 AND albumStatusID NEQ 23)//---> OR shelfCode EQ 'BS'>
				<!---<cfif (blue99 EQ 1 AND DateFormat(blueDate,"yyyy-mm-dd") EQ DateFormat(varDateODBC,"yyyy-mm-dd")) OR (price*salePerc/100 LT .99)>
                    <cfset salePerc=100*.99/price>
                </cfif>
            <cfif DateFormat(blueDate,"yyyy-mm-dd") EQ DateFormat(varDateODBC,"yyyy-mm-dd")>
                <cfif price LT 6.99 and blue99 EQ 0>
                    <cfset salePerc=39.8>
                <cfelseif blue99 EQ 1 OR (price*40/100 LT .99)>
                    <cfset salePerc=100*.99/price>
                <cfelse>		
                    <cfset salePerc=29.8>
                </cfif>
            </cfif>//---><!--- Right now saleperc of 100% and reducing sale to just BS, show original price as cost + $3 //---><cfset salePerc=100><!---<cfif NOT url.group EQ "sale"><cfset salePerc=40></cfif>//---><cfif cost+3 GT price*salePerc/100><b><font color="red" style="text-decoration:line-through;">#DollarFormat(cost+3)#</font> #DollarFormat(price*salePerc/100)#</b><cfset addSale=true><cfelseif price LT pricesave><b><font color="red" style="text-decoration:line-through;">#DollarFormat(priceSave)#</font> #DollarFormat(price)#</b><cfelse><b>#DollarFormat(price)#</b><cfset addSale=false></cfif>
			<!---<cfelseif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "2009-08-31"><b><font color="red" style="text-decoration:line-through;">#DollarFormat(price)#</font> #DollarFormat(price*.9)#</b>//---><cfelse><b>#DollarFormat(price)#</b><cfset addSale=false></cfif><br />
		<cfif albumStatusID EQ 30><span class="style1"><font color="##FFFF00">SPECIAL ORDER</font></span><cfelse><span class="style1">IN STOCK</span></cfif><br />
        <cfif ONHAND EQ 1 OR (ONHAND EQ 0 AND ONSIDE EQ 1)><font color="red">ONLY 1 LEFT</font><br /></cfif>
		<cfif addSale><a href="cartAction.cfm?cAdd=#ID#&dos=oui&dosp=#salePerc#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a><cfelse>
		<cfif price GT 0><a href="cartAction.cfm?cAdd=#ID#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a><cfelse><span class="style3">PROMO ONLY<br>NOT FOR SALE</span></cfif></cfif></cfif></td>
   <td rowspan="3" colspan="2" background="images/opussitelayout07main_r11_c13.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
    <td colspan="5" valign="top" bgcolor="##333333">
    <cfif hideTracks EQ 1><p><a href="javascript:showdiv(#ID#)">Click to see track listing</a></p></cfif>
	<div id="hideshow#ID#" <cfif hideTracks EQ 1> style="visibility:hidden;"</cfif>><table width="100%" border="0" cellpadding="0" >
	 <cfquery name="tracks" dbtype="query">
		select *
		from Application.allTracks
		where catID=#activeItemID#
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
			<td align="center" bgcolor="##009933" width="12" height="12"><!---<div align="center" class="style1"><font style="font-size: x-small;">&gt;</font></a></div>//--->&nbsp;</td>
			<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" border="0" /></td>
			<td align="center" bgcolor="##0066CC" width="12" height="12"><span class="style1"><a href="binaction.cfm?oClip=#tracks.ID#" target="opusviewbins" title="Add to Listening Bin" class="clickit"><font style="font-size: x-small;">B</font></a></span></td>
		  </tr>
		</table></td>
			<td width="2"><img src="images/spacer.gif" height="1" width="2" border="0" /></td>
            
	<cfelse>
    	<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table cellpadding="0" cellspacing="0" border="0" width="10" style="border-collapse:collapse;">
			<tr><td><img src="images/spacer.gif" width="10" height="10" border="0"></td></tr></table>
			</td>
			<td width="2"><img src="images/spacer.gif" height="1" width="2" border="0"/></td>
	</cfif>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks"><ul class="graphic"><li><cfif tracks.mp3Loaded OR mp3Alt NEQ 0><a href="media/oT#trID#.mp3" type="audio/mpeg"><!---<a href="##" onclick="loadSong('#trID#');">//--->#tName#<!---</a>//---></a><cfelse>#tName#</cfif></li></ul></div>
</td>
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
<cfif url.sID NEQ 0 AND IsValid("integer",url.sid) AND url.emf EQ "go">
<cfif Session.userID EQ 0>
	<p align="center"><font color="red"><b>You must be logged in to use the Email a Friend feature.</b></font></p>
<cfelse>
<cfform id="emailFriendForm" name="emailFriendForm" method="post" action="emailFriendAction.cfm">
  <table width="500" border="0" align="center" cellpadding="20" cellspacing="0" bgcolor="#ECE9D8">
    <tr>
      <td bgcolor="#CCFF33"><h4 class="style2">Email Link to Friend:</h4>
      <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr>
            <td><span class="style5">Friend's Name:</span></td>
            <td><cfinput type="text" name="friendsName" required="yes" id="friendsName" style="font-size: x-small; font-family:Arial, Helvetica, sans-serif;" tabindex="1" size="40" maxlength="100" /></td>
          </tr>
          <tr>
            <td><span class="style5">Friend's email:</span></td>
            <td><cfinput style="font-size: x-small; font-family:Arial, Helvetica, sans-serif;" name="friendsEmail" type="text" id="friendsEmail" tabindex="2" size="40" maxlength="100" required="yes" validate="email" message="The email address you enetered for your friend is not valid."  /></td>
          </tr>
          <tr>
            <td><span class="style5">Short Message:</span></td>
            <td><cfinput style="font-size: x-small; font-family:Arial, Helvetica, sans-serif;" name="shortMessage" type="text" id="shortMessage" tabindex="3" value="I heard this track on Downtown304.com and thought you would like it" size="70" maxlength="150" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><cfinput style="font-size: x-small; font-family:Arial, Helvetica, sans-serif;" type="submit" name="submit" id="submit" value="Submit" tabindex="4" /><cfinput type="hidden" name="sid" value="#url.sid#"></td>
          </tr>
        </table>      </td>
    </tr>
  </table>
</cfform>
</cfif>
<cfelseif url.sID NEQ 0 AND isValid("integer",url.sid) AND url.emf EQ "done">
<table width="500" border="0" align="center" cellpadding="20" cellspacing="0" bgcolor="#ECE9D8">
    <tr>
      <td bgcolor="#CCFF33"><h4><span class="style2">Email Link to Friend:</span> <i>Sent</i></h4></td>
    </tr>
  </table>
</cfif>
<cfif thisFullImg NEQ "" AND url.sID NEQ 0><cfoutput><blockquote><img src="images/items/oI#url.sID#full.jpg"></blockquote></cfoutput></cfif>
<cfif url.sID EQ 53316><cfinclude template="ultimatebreaks.cfm"></cfif>
<cfif url.sID EQ 53318><cfinclude template="strictlybreaks.cfm"></cfif>
<cfif catFind.recordCount GT #numItemsPerPage#>
<cfoutput>
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage-1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#x#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages><a href="opussitelayout07main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage+1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#">&nbsp;&nbsp;next&gt;&gt;</a></cfif></p>
</cfoutput>
</cfif>
</cfif>
<!--- ALSO BOUGHT feature //--->

<cfif (url.sID NEQ 0 AND IsValid("integer",url.sID)) OR catFind.recordCount EQ 1>
<cfquery name="thisItem" dbtype="query">
	select *
	from Application.dt304Items
	where ID=<cfqueryparam value="#displayedID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfloop query="thisItem">
<cfset thisArtistID=thisItem.artistID>
<cfset thisLabelID=thisItem.labelID>
<cfset thisArtist=thisItem.artist>
<cfset thisLabel=thisItem.label>
<cfset abMsg1="Customers who bought">
<cfset abMsg2="also bought these titles:">
<!---<cfquery name="alsoBought" datasource="#DSN#" maxrows="30">
	select *
	FROM alsoBoughtQuery
	where abItemID=<cfqueryparam value="#displayedID#" cfsqltype="cf_sql_integer"> AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
</cfquery>//--->


<!--- TEMPORARILY DISABLE ALSO BOUGHT QUERY....MAYBE MAKING SYSTEM TOO SLOW  - DON'T FORGET THE </cfif> BELOW
<cfquery name="cachedOrderItems" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,2,0,0)#">
	select * from orderItemsQuery where adminAvailID=6
</cfquery>
<cfquery name="thisCustOrders" dbtype="query">
	select DISTINCT orderID from cachedOrderItems where catItemID=#displayedID#
</cfquery>
<cfset custOrdersCSV="0">
<cfloop query="thisCustOrders">
	<cfset custOrdersCSV=custOrdersCSV&","&orderID>
</cfloop>
<cfquery name="alsoBought" dbtype="query">
	select *, catItemID AS abID
	from cachedOrderItems
	where orderID IN (#custOrdersCSV#) 
		AND catitemID<>#displayedID# AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
	ORDER BY dateShipped DESC
</cfquery>
<cfif alsoBought.recordCount EQ 0>
	<cfset abMsg1="If you like">
	<cfset abMsg2="you might also like these titles:">
	<cfquery name="alsoBought" dbtype="query" maxrows="30">
		select *, ID As abID from Application.dt304Items
		where (artistID=#thisArtistID# OR LOWER(artist) LIKE '%#LCase(thisArtist)#%') AND ID<><cfqueryparam value="#displayedID#" cfsqltype="cf_sql_integer"> AND artistID<>728 AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
		order by ID DESC
	</cfquery>
</cfif>
<cfif alsoBought.recordCount EQ 0>//--->
	<cfquery name="alsoBought" dbtype="query" maxrows="30">
	select *, catItemID AS abID
	from Application.dt304Items
		where (labelID=#thisLabelID# OR label LIKE <cfqueryparam value="%#thisLabel#%" cfsqltype="cf_sql_char">) AND ID<><cfqueryparam value="#displayedID#" cfsqltype="cf_sql_integer"> AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
		order by ID DESC
	</cfquery>
<!---</cfif>//--->

<cfif alsoBought.recordCount GT 0>
	<cfoutput query="thisItem">
	<p style="font-size: small; margin-top: 20px; margin-bottom: 7px; margin-left: 15px;">#abMsg1#
	<b>#artist#</b> 
	"#title#" #abMsg2#</p>
	</cfoutput>
	<cfif alsoBought.recordCount GT 10>
		<cfset oRand=RandRange(1,alsoBought.recordCount-10)>
	<cfelse>
		<cfset oRand=1>
	</cfif>
	<cfset rowCt=0>
	<table border="0" cellpadding="0" cellspacing="0" width="100%" hspace="15">
		<tr>
	<cfoutput query="alsoBought" startrow="#oRand#" maxrows=10>
	<cfset rowCt=rowCt+1>
	<cfset abImagefile="labels/label_WhiteLabel.gif">
		<cfset abImagefolder="">
		<cfif jpgLoaded>
			<cfset abImagefile="items/oI#abID#.jpg">
		<cfelseif logofile NEQ "">
			<cfset abImagefile="labels/" & logofile>
			</cfif>
	<cfif int(rowCt/2)*2 NEQ rowCt AND rowCt NEQ 1>
		<td width="10"><img src="images/spacer.gif" width="15" height="15" /></td></tr><tr>
	</cfif>
		<td width="15"><img src="images/spacer.gif" width="15" height="15" /></td>
		<td width="50%">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr><td><a href="opussitelayout07main.cfm?sID=#abID#" target="opusviewmain" title="#title#"><img src="images/#abImageFile#" width="50" height="50" vspace="3" border="0" /></a></td>
		<td><p style="font-size: x-small; margin-left: 5px; margin-right: 5px;"><b><a href="opussitelayout07main.cfm?af=#artistID#" target="opusviewmain" title="View All Items by this Artist">#artist#</a></b><br />
		<a href="opussitelayout07main.cfm?sID=#abID#" target="opusviewmain" title="View Item Details">#title#</a></p></td>
		</tr></table></td>
	</cfoutput>
	<cfif int(rowCt/2)*2 NEQ rowCt>
		<td><img src="images/spacer.gif" width="50" height="50" /></td>
	</cfif>
	<td width="15"><img src="images/spacer.gif" width="15" height="15" /></td></tr>
	</table>
	<cfif alsoBought.recordCount GT 10>
		<cfoutput><p align="right" style="font-size: x-small; margin-top: 7px; margin-bottom: 7px; margin-right: 15px;"><a href="opussitelayout07main.cfm?sID=#displayedID#">See more recommendations</a></p></cfoutput>
	</cfif>
</cfif>
</cfloop>
</cfif>

<!--- Also Bought END //--->
<cfoutput><map name="m_opussitelayout07main_r5_c1" id="m_opussitelayout07main_r5_c1">
<area shape="poly" coords="137,2,148,2,148,22,137,22,137,2" href="opussitelayout07main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=artist&so=asc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#" alt="Sort by Artist A-Z" />
<area shape="poly" coords="148,2,159,2,159,21,148,21,148,2" href="opussitelayout07main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=artist&amp;so=desc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#" alt="Sort by Artist Z-A" />
<area shape="poly" coords="330,0,341,0,341,22,330,22,330,0" href="opussitelayout07main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=title&amp;so=asc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#" alt="Sort by Title A-Z" />
<area shape="poly" coords="341,0,352,0,352,22,341,22,341,0" href="opussitelayout07main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=title&amp;so=desc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#" alt="Sort by Title Z-A" />
<area shape="poly" coords="529,0,540,0,540,22,529,22,529,0" href="opussitelayout07main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=label&amp;so=asc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#" alt="Sort by Label A-Z" />
<area shape="poly" coords="540,0,551,0,551,22,540,22,540,0" href="opussitelayout07main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=label&amp;so=desc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#" alt="Sort by Label Z-A" />
<area shape="poly" coords="618,0,629,0,629,22,618,22,618,0" href="opussitelayout07main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=releaseDate&amp;so=asc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#" alt="Sort by Date, oldest first" />
<area shape="poly" coords="629,0,640,0,640,22,629,22,629,0" href="opussitelayout07main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=releaseDate&amp;so=desc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#&sale=#url.sale#" alt="Sort by Date, most recent first" />
</map></cfoutput>
<cfif Session.framesetloaded NEQ "true"><p align="center"><a href="https://downtown304.com/index.cfm" target="_top"><font style="font-size: large;">Shop for this and more at Downtown 304</font></a></p></cfif>
</body>
</html>