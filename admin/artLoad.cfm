<cfset pageName="CATALOG">
<cfparam name="url.allowthumb" default="false">
<cfinclude template="pageHead.cfm">
<cfquery name="thisItem" datasource="#DSN#">
	select *
	from catItemsQuery
	where ID=#url.ID#
</cfquery>
<style>td {vertical-align:top;"}</style>
<cfoutput query="thisItem">
	<p><b>#artist#</b><br />
	#title#<br />
	<small>#catnum# #label# <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</small></p>
</cfoutput>
<table border="1" cellpadding="2" cellspacing="5">
	<cfoutput>
			<tr>
            	<td colspan="2"><h1>Front (300 x 300)</h1></td>
                <td colspan="2"><h1>Back (300 x 300)</h1></td>
			<tr>
				<td>
				
					<cfif thisItem.fullImg NEQ "">
						<img src="../images/items/oI#url.ID#full.jpg" width="300" height="300" border="0"><cfelse><img src="images/spacer.gif" height="75" width="75" />
					</cfif>
					
				</td>
				<td>
						<cfform name="artLoad" action="artLoadAction.cfm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="ID" value="#url.ID#" />
							<cfif thisItem.fullImg NEQ "">
								<input type="submit" name="deleteFull" value="Delete">
							<cfelse>
								<input type="file" name="uploadFileFull" size="35" class="inputBox"><input type="submit" name="uploadFull" value="Upload">
							</cfif>
					</cfform>
				</td>
                				<td>
					<cfif thisItem.altImg NEQ "">
						<img src="../images/items/oI#url.ID#back.jpg" width="300" height="300" border="0"><cfelse><img src="images/spacer.gif" height="75" width="75" />
					</cfif>
					
				</td>
				<td>
						<cfform name="artLoad" action="artLoadAction.cfm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="ID" value="#url.ID#" />
							<cfif thisItem.altImg NEQ "">
								<input type="submit" name="deleteAlt" value="Delete">
							<cfelse>
								<input type="file" name="uploadFileAlt" size="35" class="inputBox"><input type="submit" name="uploadAlt" value="Upload">
							</cfif>
					</cfform>
				</td>
			</tr>
            	<tr>	
                	<td colspan="4"><h1>Thumbnail image (75 x 75)</h1></td>
                </tr>
            <tr>
				<td>
					<cfif thisItem.jpgLoaded>
						<img src="../images/items/oI#url.ID#.jpg" width="75" height="75" border="0"><cfelse><img src="images/spacer.gif" height="75" width="75" />
					</cfif>
					
				</td>
				<td colspan="3">
						<cfif url.allowthumb EQ "true"><cfform name="artLoad" action="artLoadAction.cfm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="ID" value="#url.ID#" />
							<cfif thisItem.jpgLoaded>
								<input type="submit" name="delete" value="Delete">
							<cfelse>
								<input type="file" name="uploadFile" size="35" class="inputBox"><input type="submit" name="upload" value="Upload">
							</cfif>
					</cfform><cfelse>
                    <a href="artLoad.cfm?ID=#url.ID#&allowthumb=true">Click here to load a thumbnail</a>
                    </cfif>
				</td>
			</tr>
		</cfoutput>
	</table><cfform name="cancelForm" action="artLoadAction.cfm" method="post">
			<cfoutput><input type="submit" name="cancel" value=" Done " /> <input type="submit" name="item" value=" Return to Item Details " /><input type="hidden" name="ID" value="#url.ID#" /></cfoutput>
		</cfform>
	<p>&nbsp;</p>
<cfinclude template="pageFoot.cfm">