<cfset pageName="CATALOG">
<cfinclude template="pageHead.cfm">
<cfquery name="thisItem" datasource="#DSN#">
	select *
	from catItems
	where ID=#url.ID#
</cfquery>
<cfquery name="thisArtist" datasource="#DSN#">
	select ID, name
	from artists
	where ID=#thisItem.artistID#
	order by name
</cfquery>
<cfquery name="thisLabel" datasource="#DSN#">
	select ID, name
	from labels
	where ID=#thisItem.labelID#
	order by sort
</cfquery>
<cfquery name="thisMedia" datasource="#DSN#">
	select ID, name
	from media
	where ID=#thisItem.mediaID#
	order by name
</cfquery>
<cfquery name="tracks" datasource="#DSN#">
	select *
	from catTracks
	where catID=#url.ID#
</cfquery>
<cfoutput query="thisItem">
	<p><b>#thisArtist.name#</b><br />
	#thisItem.title#<br />
	<small>#thisItem.catnum# #thisLabel.name# #thisMedia.name#</small></p>
</cfoutput>
<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		<cfset x=0>
		<cfoutput query="tracks">
		<cfset x=x+1>
			<tr>
				<td>#tSort#. #tName#</td>
				<td>
				<cfdirectory directory="d:\media" filter="oT#tracks.ID#.mp3" name="trackCheck" action="list">
					<cfif trackCheck.recordCount GT 0>
						<a href="#webPath#/media/oT#tracks.ID#.mp3"><img src="images/speaker.gif" width="16" height="14" border="0"></a><cfelse><img src="images/spacer.gif" height="1" width="1" />
					</cfif>
				</td>
				<td>
						<cfform name="trackLoad#x#" action="trackLoadAction.cfm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="ID" value="#url.ID#" />
							<input type="hidden" name="artistID" value="#thisItem.artistID#" />
							<input type="hidden" name="trackID" value="#tracks.ID#" />
							<cfif trackCheck.recordCount GT 0>
								<input type="submit" name="delete" value="Delete">
							<cfelse>
								<input type="file" name="uploadFile" size="35" class="inputBox"><input type="submit" name="upload" value="Upload">
							</cfif>
					</cfform>
				</td>
			</tr>
		</cfoutput>
	</table><cfform name="cancelForm" action="trackLoadAction.cfm" method="post">
			<cfoutput><input type="submit" name="cancel" value=" Done " /><input type="hidden" name="ID" value="#url.ID#" /></cfoutput>
		</cfform>
	<p>&nbsp;</p>
<cfinclude template="pageFoot.cfm">