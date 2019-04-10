<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfparam name="url.editItem" default="0">
<cfparam name="url.find" default="">
<cfset pageName="LISTS">
<cfinclude template="pageHead.cfm">

<cfquery name="thisLabel" datasource="#DSN#">
 select *
 from labels
 where ID=#url.ID#
</cfquery>
<cfform name="label" action="listsLabelsEditAction.cfm" method="post" enctype="multipart/form-data">
	<table border="1" cellpadding="2" style="border-collapse:collapse;">
		<cfoutput query="thisLabel">
			<tr>
				<td>Name:&nbsp;</td>
				<td><cfinput type="text" name="name" value="#name#" size="50" maxlength="100"></td>
			</tr>
			<tr>
				<td>Sort:&nbsp;</td>
				<td><cfinput type="text" name="sort" value="#sort#" size="50" maxlength="30"></td>
			</tr>
			<tr>
				<td valign="top">Logo:&nbsp;</td>
				<td valign="top">
			<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
			<tr>
				<td>
				<!---<cfdirectory directory="#serverPath#\images\labels" filter="#logofile#" name="artCheck" action="list">//--->
					<cfif logofile NEQ "">
						<img src="../images/labels/#logofile#" width="75" height="75" border="0"><input type="hidden" name="logofile" value="#logofile#" /><cfelse><img src="images/spacer.gif" height="75" width="75" />
					</cfif>
				</td>
				<td>
							<cfif logofile NEQ "">
								<a href="listLabelsEditAction.cfm?delete=#logofile#">DELETE IMAGE</a>
							<cfelse>
								<input type="file" name="uploadFile" size="35" class="inputBox"><input type="submit" name="upload" value="Upload">
							</cfif>
				</td>
			</tr>
	</table>
			<tr>
				<td colspan="2"><cfinput type="checkbox" name="active" value="yes" checked="#YesNoFormat(active)#"> Active&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2"><cfinput type="checkbox" name="special" value="yes" checked="#YesNoFormat(special)#"> Special&nbsp;</td>
			</tr>
		</cfoutput>
	</table>
	<p><cfinput type="submit" name="submit" value="Save Changes"><cfinput type="hidden" name="ID" value="#ID#"></p>
	<cfoutput><input type="hidden" name="letter" value="#url.letter#" /><input type="hidden" name="editItem" value="#url.editItem#" /></cfoutput>
</cfform>
<cfoutput><p><a href="listsLabelsDelete.cfm?ID=#url.ID#">DELETE</a></p></cfoutput>
<cfform name="reprice" action="listsLabelsEditReprice.cfm" method="post">
<cfoutput><input type="text" name="costAdjust" value="-0.50" /><input type="submit" name="reprice" value="Reprice" /><input type="hidden" name="labelID" value="#url.ID#" /><input type="hidden" name="find" value="#url.find#" /></cfoutput>
</cfform>
<cfinclude template="pageFoot.cfm">