<cfset pageName="CATALOG">
<cfsetting requesttimeout="6000">
<cfparam name="url.stat" default="21">
<cfparam name="url.emailsent" default="0">
<cfinclude template="pageHead.cfm">
		<h1>Catalog</h1>
		<p><a href="catalogAdd.cfm">ADD ITEM</a><br>
		<a href="listsLabelsAdd.cfm">ADD LABEL</a><br>
		<a href="catalogDTHistory.cfm">Downtown Import History</a><br>
		Catalog Review</p>
		<img src="images/spacer.gif" width="500" height="10">
	   <table border="0" cellpadding="0" cellspacing="0" width="500">
         <!-- fwtable fwsrc="DTstatusMenu.png" fwbase="DTstatusMenu.jpg" fwstyle="Dreamweaver" fwdocid = "1179021194" fwnested="0" -->
		  <tr>
		   <td><img src="images/spacer.gif" width="101" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="102" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="102" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="102" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="93" height="1" border="0" alt="" /></td>
		   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
		  </tr>
		  <tr>
		   <td><cfif url.stat EQ 21><img src="images/DTstatusMenu_r1_c1_f3.jpg"><cfelse><a href="catalogReview.cfm?stat=21" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c1','images/DTstatusMenu_r1_c1_f2.jpg','images/DTstatusMenu_r1_c1_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c1','images/DTstatusMenu_r1_c1_f3.jpg',1);"><img name="DTstatusMenu_r1_c1" src="images/DTstatusMenu_r1_c1.jpg" width="101" height="20" border="0" id="DTstatusMenu_r1_c1" alt="New Releases" /></a></cfif></td>
		   <td><cfif url.stat EQ 22><img src="images/DTstatusMenu_r1_c2_f3.jpg"><cfelse><a href="catalogReview.cfm?stat=22" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c2','images/DTstatusMenu_r1_c2_f2.jpg','images/DTstatusMenu_r1_c2_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c2','images/DTstatusMenu_r1_c2_f3.jpg',1);"><img name="DTstatusMenu_r1_c2" src="images/DTstatusMenu_r1_c2.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c2" alt="Recent Releases" /></a></cfif></td>
		   <td><cfif url.stat EQ 23><img src="images/DTstatusMenu_r1_c3_f3.jpg"><cfelse><a href="catalogReview.cfm?stat=23" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c3','images/DTstatusMenu_r1_c3_f2.jpg','images/DTstatusMenu_r1_c3_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c3','images/DTstatusMenu_r1_c3_f3.jpg',1);"><img name="DTstatusMenu_r1_c3" src="images/DTstatusMenu_r1_c3.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c3" alt="Back in Stock" /></a></cfif></td>
		   <td><cfif url.stat EQ 24><img src="images/DTstatusMenu_r1_c4_f3.jpg"><cfelse><a href="catalogReview.cfm?stat=24" onMouseOut="MM_nbGroup('out');" onMouseOver="MM_nbGroup('over','DTstatusMenu_r1_c4','images/DTstatusMenu_r1_c4_f2.jpg','images/DTstatusMenu_r1_c4_f3.jpg',1);" onClick="MM_nbGroup('down','navbar1','DTstatusMenu_r1_c4','images/DTstatusMenu_r1_c4_f3.jpg',1);"><img name="DTstatusMenu_r1_c4" src="images/DTstatusMenu_r1_c4.jpg" width="102" height="20" border="0" id="DTstatusMenu_r1_c4" alt="Regular Catalog (loads slowly)" /></a></cfif></td>
		   <td><img name="DTstatusMenu_r1_c5" src="images/DTstatusMenu_r1_c5.jpg" width="93" height="20" border="0" id="DTstatusMenu_r1_c5" alt="" /></td>
		   <td><img src="images/spacer.gif" width="1" height="20" border="0" alt="" /></td>
		  </tr>
       </table>
	   <img src="images/spacer.gif" width="500" height="20">
<cfif url.stat EQ 24>
	<cfquery name="catalogFind" datasource="#DSN#">
		select *
		from catItemsQuery
		where active=1 AND ONHAND>0 AND (albumStatusID=24) AND Left(shelfCode,1)='D' AND shelfCode<>'DS'
		order by label ASC, catnum ASC
	</cfquery>
<cfelse>
	<cfquery name="catalogFind" datasource="#DSN#">
		select *
		from catItemsQuery
		where active=1 AND ONHAND>0 AND (albumStatusID=#url.stat#) AND Left(shelfCode,1)='D' AND shelfCode<>'DS'
		order by dtDateUpdated DESC, label ASC
	</cfquery>
</cfif>
<cfset rownum=1>
<!---<table width="100%" border="0" cellpadding="8">
  <tr>
    <td bgcolor="#666666">
<p align="left" style="font-family: Arial, Helvetica, sans-serif; font-size: x-small;">
<a href="index.cfm?ob=artist&so=asc">^</a> artist <a href="index.cfm?ob=artist&so=desc">v</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="index.cfm?ob=title&so=asc">^</a>  title <a href="index.cfm?ob=title&so=desc">v</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="index.cfm?ob=label&so=asc">^</a>  label <a href="index.cfm?ob=label&so=desc">v</a>&nbsp;&nbsp;&nbsp;&nbsp;
<a href="index.cfm?ob=releaseDate&so=asc">^</a> date <a href="index.cfm?ob=releaseDate&so=desc">v</a></p>
	</td>
  </tr>
</table>//--->
<table width="100%" border="0" cellpadding="3"  bgcolor="#333333">
<cfoutput query="catalogFind">
	<cfset imagefile="labels/label_WhiteLabel.gif">
	<cfset imagefolder="">
	<cfdirectory directory="#serverPath#\images\items" filter="oI#catalogFind.ID#.jpg" name="imageCheck" action="list">
	<cfif imageCheck.recordCount NEQ 0>
		<cfset imagefile="items/" & imageCheck.name>
	<cfelseif logofile NEQ "">
		<cfdirectory directory="#serverPath#\images\labels" filter="#logofile#" name="logoCheck" action="list">
		<cfif logoCheck.recordCount NEQ 0>
			<cfset imagefile="labels/" & logoCheck.name>
		</cfif>
	</cfif>
	<cfif rownum EQ 1><cfset bgcimage="Green"><cfelse><cfset bgcimage="Gray"></cfif>
	

  <tr>
  	<cfif ONHAND EQ 0><cfset oos='OOS'><cfelse><cfset oos=''></cfif>
		<cfset imagefile="labels/label_WhiteLabel.gif">
		<cfset imagefolder="">
		<cfdirectory directory="#serverPath#\images\items" filter="oI#catalogFind.ID#.jpg" name="imageCheck" action="list">
		<cfif imageCheck.recordCount NEQ 0>
			<cfset imagefile="items/" & imageCheck.name>
		<cfelseif logofile NEQ "">
			<cfdirectory directory="#serverPath#\images\labels" filter="#logofile#" name="logoCheck" action="list">
			<cfif logoCheck.recordCount NEQ 0>
				<cfset imagefile="labels/" & logoCheck.name>
			</cfif>
		</cfif>		
    <td width="85" rowspan="2" align="center" valign="top"><a href="artLoad.cfm?ID=#ID#"><img src="images/#imagefile#" width="75" height="75" border="0" /></a><br /><a href="DTItemEmail.cfm?ID=#ID#">EMAIL</a><cfif url.emailsent EQ ID><br /><font color="red">SENT</font></cfif></td>
    <td width="390" align="left" valign="top" class="detailsArtist" ><b>#artist#</b>
		<br />#title#</td>
    <td rowspan="2" align="left" valign="top" class="detailsLabel"><b>#label#</b><br />
		Cat. No.: #catnum#<br />
		Item No.: #ID##shelfCode#<br />
		Format: <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#<br />
     	#DollarFormat(cost)#</td>
  </tr>
  <tr>
    <td colspan="2" valign="top" class="detailsTracks">
	<table width="100%" border="0" cellpadding="0" align="left">
	<cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#catalogFind.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<tr>
			<td align="left" valign="middle" style="line-height: 80%;" class="detailsTracks">#tName#
			<cfdirectory directory="d:\media" filter="oT#tracks.ID#.mp3" name="trackCheck" action="list">
			<cfif trackCheck.recordCount GT 0><a href="#webPath#/media/oT#tracks.ID#.mp3"><img 
			src="images/speaker.gif" width="16" height="13" border="0" align="middle" alt="listen" hspace="2"></a><cfelse><img src="images/spacer.gif" align="baseline" height="13" width="1" border="0"></cfif></td>
      	</tr>
	  </cfloop>
    </table>	</td>
	<td align="center" class="catDisplay">
				<cfif ONHAND EQ 0>
					<a href="catalogBackinStock.cfm?ID=#ID#?review=true&stat=#url.stat#">MARK IN STOCK</a>
				<cfelse>
					<a href="catalogOutOfStock.cfm?ID=#ID#&review=true&stat=#url.stat#">MARK OUT OF STOCK</a>
					</cfif></td>
   </tr>
 
 <cfif rownum EQ 1>
  	<cfset rownum=2>
  <cfelse>
  	<cfset rownum=1>
  </cfif>	
  <tr>
  	<td colspan="4"><hr noshade></td>
  </tr>
</cfoutput>
</table> 
<p>&nbsp; </p>
<p>&nbsp;</p>
<cfinclude template="pageFoot.cfm">