<cfparam name="url.already" default="notry">
<cfset pageName="CATALOG">
<cfinclude template="pageHead.cfm">
<cfquery name="thisItem" datasource="#DSN#">
	select *
	from catItemsQuery
	where ID=#url.ID#
</cfquery>
<cfquery name="tracks" datasource="#DSN#">
	select *
	from catTracks
	where catID=#url.ID#
	order by tSort
</cfquery>
<cfform name="addPicks" action="trackLoadAction.cfm" method="post" enctype="multipart/form-data">
<cfoutput query="thisItem">
	<cfset thisItemID=#thisItem.ID#>
	<p><b>#thisItem.artist#</b><br />
	#thisItem.title#<br />
	<small>#thisItem.catnum# #thisItem.artist# <cfif thisItem.NRECSINSET GT 1>#thisItem.NRECSINSET# x </cfif>#thisItem.media#</small></p>
	<cfif url.already EQ "true">
		<p><font color="red"><b>CAN'T ADD TO STAFF PICKS - ALREADY ON LIST</b></font></p>
	<cfelseif url.already EQ "false">
		<p><font color="green"><b>SUCCESSFULLY ADDED TO STAFF PICKS</b></font></p>
	</cfif>
	<p>Add Item to Staff Picks <input type="submit" name="insertItem" value="#url.ID#" /></p>
	<input type="hidden" name="ID" value="#url.ID#" />
</cfoutput>
</cfform>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
		<cfset x=0>
        <cfset theLastRow=tracks.recordCount>
		<cfoutput query="tracks">
		
		<cfset x=x+1>
		
			<tr>
				<td>#tSort#. #tName#</td>
				<td>
				<cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=tracks.ID></cfif>
				<!---<cfdirectory directory="d:\media" filter="oT#trID#.mp3" name="trackCheck" action="list">//--->
					<cfif tracks.mp3Loaded>
						<a href="#webPath#/media/oT#trID#.mp3"><img src="images/speaker.gif" width="16" height="14" border="0"></a>
						<cfelse>
						<img src="images/spacer.gif" height="1" width="1" />
					</cfif>
				</td>
				<td><cfform name="trackLoad#x#" action="trackLoadAction.cfm" method="post" enctype="multipart/form-data">
						
							<input type="hidden" name="ID" value="#url.ID#" />
							<input type="hidden" name="artistID" value="#thisItem.artistID#" />
							<input type="hidden" name="trackID" value="#tracks.ID#" />
							<cfif tracks.mp3Loaded>
								<cfif mp3Alt NEQ 0>
									<font size="1" color="red">LINKED (can't delete)</font>
								<cfelse>
									<input type="submit" name="delete" value="Delete"> Add Track to Staff Picks: <input type="submit" name="insertTrack" value="#tracks.ID#" />
								</cfif>
							<cfelse>
								<input type="file" name="uploadFile" size="35" class="inputBox"><input type="submit" name="upload" value="Upload"> 
                            Next: <cfif x EQ theLastRow><input type="radio" name="continue" value="art" checked> Load Art <input type="radio" name="continue" value="more"> Load More Tracks <cfelse><input type="radio" name="continue" value="art"> Load Art <input type="radio" name="continue" value="more" checked> Load More Tracks </cfif><input type="radio" name="continue" value="done"> Done 
							</cfif>
							</cfform>
					
				</td>
				<td>
				
				</td>
			</tr>
		</cfoutput>
	</table>
   <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
   <tr>
   	<td><p>Load all tracks from file remote M3U file</p>
<cfform name="loadm3u" action="trackLoadM3U.cfm" method="post">
<cfinput type="text" name="getm3u" size="60" value="http://www.groovedis.com/m3u/#LCase(thisitem.catnum)#.m3u"><cfinput type="submit" name="m3usubmit"value="Load All"><cfoutput><input type="hidden" name="ID" value="#url.ID#" /></cfoutput></cfform></td>
<td rowspan="2" width="30"></td>
    <td rowspan="2" valign="top">
    	 <p>Load all tracks from juno with pattern</p>
<cfform name="loadjuno" action="trackLoadM3U.cfm" method="post">
<cfinput type="text" name="getjunoprefix" size="60"><cfinput type="submit" name="junosubmit"value="Load All"><cfoutput><input type="hidden" name="ID" value="#url.ID#" /></cfoutput>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
	<tr>
    	<td>01-01-<cfinput type="text" name="j0101" size="2" maxlength="3"></td><td>01-02-<cfinput type="text" name="j0102" size="2" maxlength="3"></td>
    </tr>
    <tr>
    	<td>01-03-<cfinput type="text" name="j0103" size="2" maxlength="3"></td><td>01-04-<cfinput type="text" name="j0104" size="2" maxlength="3"></td>
    </tr>
    <tr>
    	<td>01-05-<cfinput type="text" name="j0105" size="2" maxlength="3"></td><td>01-06-<cfinput type="text" name="j0106" size="2" maxlength="3"></td>
    </tr>
    <tr>
    	<td>02-01-<cfinput type="text" name="j0201" size="2" maxlength="3"></td><td>02-02-<cfinput type="text" name="j0202" size="2" maxlength="3"></td>
    </tr>
    <tr>
    	<td>02-03-<cfinput type="text" name="j0203" size="2" maxlength="3"></td><td>02-04-<cfinput type="text" name="j0204" size="2" maxlength="3"></td>
    </tr>
    <tr>
    	<td>02-05-<cfinput type="text" name="j0205" size="2" maxlength="3"></td><td>02-06-<cfinput type="text" name="j0204" size="2" maxlength="3"></td>
    </tr>
</table>
</cfform>
    </td>
   </tr>
   <tr>
   	<td><p>Load all tracks from file list:</p>
<cfform name="loadm3u" action="trackLoadM3U.cfm" method="post">
<cftextarea name="submitm3u" cols="62" rows="7"></cftextarea><cfinput type="submit" name="m3usubmit" value="Load All"><cfoutput><input type="hidden" name="ID" value="#url.ID#" /></cfoutput></cfform>
<cfform name="cancelForm" action="trackLoadAction.cfm" method="post">
			<cfoutput><input type="submit" name="cancel" value=" Done " /> <input type="submit" name="item" value=" Return to Item Details " /><input type="hidden" name="ID" value="#url.ID#" /> <a href="artLoad.cfm?ID=#url.ID#">Load Art</a></cfoutput>
		</cfform>
    </td>
  	</tr>
   </table>
    

		<cfoutput><p><a href="trackLoadAction.cfm?resetTracks=yes&thisItemID=#thisItemID#">Reset Tracks</a></p></cfoutput>
	<p>&nbsp;</p>
<cfinclude template="pageFoot.cfm">