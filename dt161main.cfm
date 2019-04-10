<cfset sitePage="dt161main.cfm">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>downtown304.com</title>
<link rel="stylesheet" type="text/css" href="styles/dt161styles.css" />
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: black;
}
.style1 {color: #FFCC00; font-weight: bold;}
.style2 {color: #333333;}
.style3 {color:#FF6699;	font-weight: bold;}
.style5 {color: #000000; font-weight: bold; }
-->
</style></head>
<body onload="MM_preloadImages('images/topnav_v2_r2_c2_f2.jpg','images/topnav_v2_r2_c2_f3.jpg','images/topnav_v2_r2_c4_f2.jpg','images/topnav_v2_r2_c4_f3.jpg','images/topnav_v2_r2_c6_f2.jpg','images/topnav_v2_r2_c6_f3.jpg','images/topnav_v2_r2_c8_f2.jpg','images/topnav_v2_r2_c8_f3.jpg','images/topnav_v2_r2_c10_f2.jpg','images/topnav_v2_r2_c10_f3.jpg','images/topnav_v2_r2_c12_f2.jpg','images/topnav_v2_r2_c12_f3.jpg','images/topnav_v2_r2_c14_f2.jpg','images/topnav_v2_r2_c14_f3.jpg','images/topnav_v2_r2_c16_f2.jpg','images/topnav_v2_r2_c16_f3.jpg');"><br />
<cfset sitePage="dt161main.cfm">
<!---<cfinclude template="topNav.cfm">//--->
<cfset siteChoice="161">
<cfset trackChoice="dt161tracks">
<cfinclude template="catFind.cfm">
<cfif catFind.recordCount EQ 0>
<p align="center" class="detailsArtist">&nbsp;</p>
<p align="center" class="detailsArtist"><br /><b>NO RECORDS FOUND MATCHING YOUR SEARCH CRITERIA</b></p>
<p align="center" class="detailsArtist">&nbsp;</p>
<cfelse>
<cfif url.lf NEQ "">
    <cfquery name="thisLabel" datasource="#DSN#">
        select *
        from labels
        where ID=<cfqueryparam value="#url.lf#" cfsqltype="cf_sql_char">
    </cfquery>
    <cfoutput query="thisLabel">
    <p style="font-size: x-large; font-weight:bold;" align="center">#name#</p>
    </cfoutput>
    <cfinclude template="boxTopSellersLabel.cfm">
</cfif>
<cfif catFind.recordCount GT #numItemsPerPage#>
<cfset numPages=Int((catFind.recordCount-1)/#numItemsPerPage#)+1>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="95%">
<tr>
<!---<td width="37"><a href="javascript: history.go(-1);" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','buttonBack','images/buttonBack_f2.jpg','images/buttonBack_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','buttonBack','images/buttonBack_f3.jpg',1);"><img src="images/buttonBack.jpg" alt="" name="buttonBack" width="37" height="10" hspace="5" vspace="5" border="0" id="buttonBack" /></a></td>//--->
<td><cfoutput>
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="dt161main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage-1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="dt161main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#x#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages><a href="dt161main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage+1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#">&nbsp;&nbsp;next&gt;&gt;</a></cfif></p>
</cfoutput></td>
<!---<td width="37">&nbsp;</td>//--->
</tr>
</table>
</cfif>
<table border="4" cellpadding="8" cellspacing="4" width="90%" align="center" bordercolor="#000000" bgcolor="#000000">
  <cfset thisStartRow=(url.rsPage*#numItemsPerPage#)-#numItemsPerPage#+1>
  <cfif url.prerelease EQ "allow">
  </cfif>
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
   <td valign="top" width="80" bgcolor="##FFFFFF"><table border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td background="images/#imageFile#" style="background-position:top; background-repeat:no-repeat"><a href="dt161main.cfm?sID=#ID#" title="#title#"><img src="images/spacer.gif" width="75" height="75" border="0" /></a></td>
  </tr>
</table></td>

   <td width="615" valign="top" bgcolor="##FFFFFF"><font size="2">[#UCase(catnum)#] <a href="dt161main.cfm?lf=#labelID#&group=all"><cfif reissue OR genreID EQ 7>*</cfif>#UCase(label)#</a><br /><a href="dt161main.cfm?af=#artistID#&group=all"><b>#UCase(artist)#</b></a><br /><a href="dt161main.cfm?sID=#ID#" title="View Details and Recommendations">#UCase(title)# <cfif FindNoCase("Reissue",title) EQ 0 AND (genreID EQ 7 OR reissue EQ 1)>[Reissue]</cfif></a> (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)</font>
   
   <div id="hideshow#ID#" <cfif hideTracks EQ 1> style="visibility:hidden;"</cfif>><table width="100%" border="0" cellpadding="0" >
	 <cfquery name="tracks" dbtype="query">
		select *
		from Application.allTracks
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
				<!---<td><img src="images/spacer.gif" width="3" height="1" /></td>
				<td><img src="images/spacer.gif" width="12" height="1" /></td>//--->
			</tr>
		  <tr>
			<td align="center" bgcolor="##330066" width="12" height="12" style="padding: 1px;"><div align="center" class="style1"><a href="dt161player.cfm?oClip=#trID#" target="opusviewplayer" title="Play" class="clickit"><font style="font-size: x-small;">LISTEN</font></a></div></td>
			<!---<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
			<td align="center" bgcolor="##0066CC" width="12" height="12"><span class="style1"><a href="binaction.cfm?oClip=#tracks.ID#" target="opusviewbins" title="Add to Listening Bin" class="clickit"><font style="font-size: x-small;">B</font></a></span></td>//--->
		  </tr>
		</table></td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	<cfelse>
			<td align="left" valign="middle" style="line-height: 100%;" width="5">
			<table cellpadding="0" cellspacing="0" border="0" width="10"style="border-collapse:collapse;">
			<tr><td><img src="spacer.gif" width="9" height="10" border="0"></td></tr></table>			</td>
			<td width="2"><img src="spacer.gif" height="1" width="2" /></td>
	</cfif>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks">#tName#</td>
      	</tr>
	  </cfloop> 
    </table></div>
   
   <!---<br /><a href="dt161main.cfm?lf=#labelID#&group=all">#label#</a> &nbsp;&nbsp;<a href="http://www.downtown304.com/index.cfm?sID=#ID#" target="_top" style="font-size: xx-small;">Item ID: ###ID#</a>//---></td>
   <td width="113" valign="top" class="detailsArtist" bgcolor="##FFFFFF"><font style="font-family: Arial, Helvetica, sans-serif; font-size:small; line-height:100%;"><!---<cfif releaseDate NEQ "" AND albumStatusID NEQ 148>#DateFormat(releaseDate,"yyyy-mm-dd")#<cfelse>#DateFormat(DTdateUpdated,"yyyy-mm-dd")#</cfif><br />//--->
		Genre: #genre#<br />
		<cfif country NEQ "U.S.A."><font color="red">IMPORT</font><br /></cfif>
     	<cfif albumStatusID EQ 148>
			<b><font color="red">PRE-RELEASE</font></b>
		<cfelse>
			<!---<cfset salePerc=66>
            <cfif url.group EQ "sale" OR (DateFormat(blueDate,"yyyy-mm-dd") EQ DateFormat(varDateODBC,"yyyy-mm-dd")) OR (isVendor EQ 1 AND Left(shelfCode,1) NEQ 'D' AND DateCompare(DateFormat(DTDateUpdated,"mm/dd/yyyy"),#varDateODBC#) GT 120 AND albumStatusID NEQ 23) OR shelfCode EQ 'BS'>
				<cfif (blue99 EQ 1 AND DateFormat(blueDate,"yyyy-mm-dd") EQ DateFormat(varDateODBC,"yyyy-mm-dd")) OR (price*salePerc/100 LT .99)>
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
            </cfif>
			<!--- Right now saleperc of 100% and reducing sale to just BS, show original price as cost + $3 //---><cfset salePerc=100><!---<cfif NOT url.group EQ "sale"><cfset salePerc=40></cfif>//---><b><font color="red" style="text-decoration:line-through;">#DollarFormat(cost+3)#</font> #DollarFormat(price*salePerc/100)#</b><cfset addSale=true>
			<cfelse>//---><b>#DollarFormat(buy)#</b><!---<cfset addSale=false></cfif>//---><br />
		<span class="style1">IN-STOCK</span><br /></cfif>
		<!---<cfif addSale><a href="cartAction.cfm?cAdd=#ID#&dos=oui&dosp=#salePerc#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a><cfelse>
		<cfif price GT 0><a href="cartAction.cfm?cAdd=#ID#" target="opusviewbins" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','shopButton#ID#','images/shopButton01_f2.jpg','images/shopButton01_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','shopButton#ID#','images/shopButton01_f3.jpg',1);"><img name="shopButton#ID#" src="images/shopButton01.jpg" width="75" height="20" border="0" id="shopButton#ID#" alt="ADD TO CART" vspace="4" /></a><cfelse><span class="style3">PROMO ONLY<br>NOT FOR SALE</cfif></cfif></cfif>//---></td>
   </tr>
  <!---<tr>
    <td valign="top" bgcolor="##FFFFFF">
	
    <cfif url.emf NEQ "go" AND Session.userID NEQ 0>
    	<p><a href="dt161main.cfm?sID=#ID#&emf=go" title="Email this title to a friend">Email to a Friend</a></p></cfif>	</td>
    </tr>//--->
  <!---<tr>
   <td colspan="3"><img name="opussitelayout07main_r13_c2" src="images/opussitelayout07main_r13_c2.jpg" width="75" height="2" border="0" id="opussitelayout07main_r13_c2" alt="" /></td>
   <td colspan="7"><img name="opussitelayout07main_r13_c6" src="images/opussitelayout07main_r13_c6.jpg" width="590" height="2" border="0" id="opussitelayout07main_r13_c6" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="2" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="14"><img name="opussitelayout07main_r14_c1" src="images/opussitelayout07main_r14_c1.jpg" width="693" height="3" border="0" id="opussitelayout07main_r14_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="3" border="0" alt="" /></td>
  </tr>//--->
  <cfset thisFullImg=fullImg>
</cfoutput>
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
<p align="center">Page &nbsp;&nbsp;<cfif url.rsPage NEQ 1><a href="dt161main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage-1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&cID=#url.cID#">&lt;&lt;prev</a>&nbsp;&nbsp;</cfif>
<cfloop from="1" to="#numPages#" index="x">
<cfif x NEQ url.rsPage><a href="dt161main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#x#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&cID=#url.cID#">#x#</a><cfelse>#rsPage#</cfif>&nbsp;&nbsp;
</cfloop>
<cfif url.rsPage NEQ numPages><a href="dt161main.cfm?sID=#url.sID#&oLd=#url.oLd#&oHd=#oHd#&group=#url.group#&so=#url.so#&ob=#url.ob#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&showAll=#url.showAll#&newused=#url.newused#&rsPage=#url.rsPage+1#&searchString=#form.searchString#&searchField=#form.searchField#&search=#form.search#&prerelease=#url.prerelease#&sale2=#url.sale2#&cID=#url.cID#">&nbsp;&nbsp;next&gt;&gt;</a></cfif></p>
</cfoutput>
</cfif>
</cfif>
<!--- ALSO BOUGHT feature //--->
<!---
<cfif (url.sID NEQ 0 AND IsValid("integer",url.sID)) OR catFind.recordCount EQ 1>
<cfquery name="thisItem" dbtype="query">
	select *
	from catFind
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


<!--- TEMPORARILY DISABLE ALSO BOUGHT QUERY....MAYBE MAKING SYSTEM TOO SLOW  - DON'T FORGET THE </cfif> BELOW//--->
<cfquery name="alsoBought" datasource="#DSN#">
	select *, catItemID AS abID
	from orderItemsQuery 
	where orderID IN (select DISTINCT orderID from orderItems where catItemID=#displayedID#) 
		AND catitemID <>#displayedID# AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
		AND adminAvailID=6
	ORDER BY dateShipped DESC
</cfquery>
<cfif alsoBought.recordCount EQ 0><!---//--->
	<cfset abMsg1="If you like">
	<cfset abMsg2="you might also like these titles:">
	<cfquery name="alsoBought" datasource="#DSN#" maxrows="30">
		select *, ID As abID from catItemsQuery
		where (artistID=#thisArtistID# OR artist LIKE '%#thisArtist#%') AND ID<><cfqueryparam value="#displayedID#" cfsqltype="cf_sql_integer"> AND artistID<>728 AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
		order by ID DESC
	</cfquery>
</cfif><!---//--->
<cfif alsoBought.recordCount EQ 0>
	<cfquery name="alsoBought" dbtype="query" maxrows="30">
	select *, catItemID AS abID
	from Application.dt304Items
		where (labelID=#thisLabelID# OR label LIKE '%#thisLabel#%') AND ID<><cfqueryparam value="#displayedID#" cfsqltype="cf_sql_integer"> AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999
		order by ID DESC
	</cfquery>
</cfif>

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
		<tr><td><a href="dt161main.cfm?sID=#abID#" target="opusviewmain" title="#title#"><img src="images/#abImageFile#" width="50" height="50" vspace="3" border="0" /></a></td>
		<td><p style="font-size: x-small; margin-left: 5px; margin-right: 5px;"><b><a href="dt161main.cfm?sID=#abID#" target="opusviewmain" title="View Item Details">#catnum# #label#</a><a href="dt161main.cfm?af=#artistID#" target="opusviewmain" title="View All Items by this Artist">#artist#</a></b><br />
		<a href="dt161main.cfm?sID=#abID#" target="opusviewmain" title="View Item Details">#title#</a></p></td>
		</tr></table></td>
	</cfoutput>
	<cfif int(rowCt/2)*2 NEQ rowCt>
		<td><img src="images/spacer.gif" width="50" height="50" /></td>
	</cfif>
	<td width="15"><img src="images/spacer.gif" width="15" height="15" /></td></tr>
	</table>
	<cfif alsoBought.recordCount GT 10>
		<cfoutput><p align="right" style="font-size: x-small; margin-top: 7px; margin-bottom: 7px; margin-right: 15px;"><a href="dt161main.cfm?sID=#displayedID#">See more recommendations</a></p></cfoutput>
	</cfif>
</cfif>
</cfloop>
</cfif>//--->

<!--- Also Bought END //--->
<cfoutput><map name="m_opussitelayout07main_r5_c1" id="m_opussitelayout07main_r5_c1">
<area shape="poly" coords="137,2,148,2,148,22,137,22,137,2" href="dt161main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=artist&so=asc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#" alt="Sort by Artist A-Z" />
<area shape="poly" coords="148,2,159,2,159,21,148,21,148,2" href="dt161main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=artist&amp;so=desc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#" alt="Sort by Artist Z-A" />
<area shape="poly" coords="330,0,341,0,341,22,330,22,330,0" href="dt161main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=title&amp;so=asc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#" alt="Sort by Title A-Z" />
<area shape="poly" coords="341,0,352,0,352,22,341,22,341,0" href="dt161main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=title&amp;so=desc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#" alt="Sort by Title Z-A" />
<area shape="poly" coords="529,0,540,0,540,22,529,22,529,0" href="dt161main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=label&amp;so=asc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#" alt="Sort by Label A-Z" />
<area shape="poly" coords="540,0,551,0,551,22,540,22,540,0" href="dt161main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=label&amp;so=desc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#" alt="Sort by Label Z-A" />
<area shape="poly" coords="618,0,629,0,629,22,618,22,618,0" href="dt161main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=releaseDate&amp;so=asc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#" alt="Sort by Date, oldest first" />
<area shape="poly" coords="629,0,640,0,640,22,629,22,629,0" href="dt161main.cfm?group=#url.group#&lf=#url.lf#&af=#url.af#&gf=#url.gf#&ob=releaseDate&amp;so=desc&amp;oLd=#url.oLd#&amp;oHd=#url.oHd#&amp;sale2=#url.sale2#&cID=#url.cID#" alt="Sort by Date, most recent first" />
</map></cfoutput>
</body>
</html>