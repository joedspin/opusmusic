<cfquery name="thisList" datasource="#DSN#" maxrows="1">
	select *
	from artistListsQuery
	where artistID=15535 AND active=1
	order by listDate DESC 
</cfquery>
<cfquery name="thisListItems" datasource="#DSN#">
	select *
	from artistListsItemsQuery
	where listID=#thisList.ID# AND (ONHAND>0 OR ONSIDE>0 OR trackONHAND>0 OR trackONSIDE>0)
	order by sort
</cfquery>
<style type="text/css">
<!--
.style1 {
	color: #333333;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
-->
</style>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<!-- fwtable fwsrc="opussitelayout07lists.png" fwbase="opussitelayout07lists.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td width="13"><img src="images/spacer.gif" width="13" height="1" border="0" alt="" /></td>
   <td width="1"><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="12" height="1" border="0" alt="" /></td>
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
   <td align="left" valign="middle" bgcolor="#65FF00"><span class="style1">TOP SELLERS</span></td>
   <td width="12"><img name="opussitelayout07lists_r2_c3" src="images/opussitelayout07lists_r2_c3.jpg" width="12" height="24" border="0" id="opussitelayout07lists_r2_c3" alt="" /></td>
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
   <td valign="top" bgcolor="#333333"><table border=0 cellpadding=4 cellspacing=0>
<cfset listCt=0>
<cfoutput query="thisListItems">
	<cfset listCt=listCt+1>
	<tr>
       <!---<td rowspan="2" align="center" style="font-size:13px; background-color:##666666;color:##CCCCCC;"><b>&nbsp;#listCt#&nbsp;</b></td>//--->
	  <cfif trackID NEQ 0>
	   	<cfset thisID=trackItemID>
		<cfset thisArtist=trackArtist>
		<cfset thisTitle=tName>
		<cfset thisLabel=trackLabel>
		<cfset thisTrackID=trackID>
		<cfset thisArtistID=trackArtistID>
	 <cfelse>
	 	<cfset thisID=itemID>
		<cfset thisArtist=itemArtist>
		<cfset thisTitle=itemTitle>
		<cfset thisLabel=itemLabel>
		<cfset thisArtistID=artistID>
		<cfquery name="firstTrack" dbtype="query" maxrows="1">
			select *
			from Application.allTracks
			where catID=#itemID#
			order by tSort
		</cfquery>
		<cfset thisTrackID=firstTrack.ID>
	</cfif>
	<td align="left" valign="middle" style="line-height: 100%;" width="10">
		<cfif mp3Loaded GT 0>	
			<table border="0" cellpadding="0" cellspacing="2"><tr><td>
			<table cellpadding="0" cellspacing="0" border="0" width="10" style="border-collapse:collapse;">
			<tr class="oTrack"><td><a href="opussitelayout07player.cfm?oClip=#thisTrackID#" target="opusviewplayer"><img src="spacer.gif" width="9" height="10" border="0" title="Play"></a></td></tr></table>
			</td>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks" width="10" rowspan="2"><table cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;">
			<tr class="oTrackBin"><td><a href="binaction.cfm?oClip=#thisTrackID#" target="opusviewbins"><img src="spacer.gif" width="9" height="10" border="0" title="Add to listening bin" /></a></td></tr></table></td>
			<td align="left" valign="middle" style="line-height: 100%;" class="detailsTracks" width="10" rowspan="2"><table cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse;">
			<tr class="oTrackCart"><td><a href="cartAction.cfm?cAdd=#thisID#" target="opusviewbins" class="detailsTracks"><img src="spacer.gif" width="9" height="10" border="0" title="Buy" /></a></td></tr></table></td>
			</tr></table>
			<cfelse>&nbsp;</cfif></td>
	   <td align="left" bgcolor="##333333"><b><a href="opussitelayout07main.cfm?af=#thisArtistID#&group=all" title="See all releases by #thisArtist#">#thisArtist#</a></b><br /><a href="opussitelayout07main.cfm?sID=#thisID#" target="opusviewmain" title="See all details about this release">#thisTitle#</a></td>
     </tr>
</cfoutput>
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