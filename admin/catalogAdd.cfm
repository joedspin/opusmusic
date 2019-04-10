<cfparam name="Cookie.shelfselect" default="15">
<cfparam name="Cookie.countryselect" default="2">
<cfset pageName="CATALOG">
<cfinclude template="pageHead.cfm">
<cfquery name="backendCountries" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	select ID, name
	from country
	order by name
</cfquery>
<cfquery name="backendGenres" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,20,0)#">
	select ID, name
	from genres
	order by name
</cfquery>
<cfquery name="backendMediaTypes" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,10,0)#">
	select ID, name
	from media
	order by name
</cfquery>
<cfquery name="backendShelfs" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,30,0)#">
	select ID, code, partner
	from shelf
	order by partner
</cfquery>
<cfquery name="backendCondition" datasource="#DSN#" cachedwithin="#CreateTimeSpan(0,1,40,0)#">
	select ID, condition
	from condition
	order by ID
</cfquery>
		<table border="0" cellpadding="10" cellspacing="0"><tr><td bgcolor="#999999">
		<h1>Catalog: Add</h1>
		<cfform name="catAddForm" action="catalogAddAction.cfm" method="post"><table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="#000000">
      <tr>
				<td colspan="3"><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">ARTIST</td>
          </tr>
        </table></td>
        </tr>
      <tr>
			<td bgcolor="#FFFFFF" colspan="3"><cfinput type="text" name="addArtistName" maxlength="255" size="75" class="inputBox"><input type="hidden" name="artistID" value="0" /></td>
		</tr>
		<!---<tr>
        <td colspan="3"><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">ARTIST</td>
          </tr>
        </table></td>
        </tr>
      <tr>
        <td bgcolor="#FFFFFF" colspan="3"><cfselect query="artists" name="artistID" value="ID" display="name">
					<option value="0" selected="yes">Choose an artist...</option>
					<option value="0">Add a New Artist</option> 
				</cfselect></td>
			</tr>
			<tr>
				<td colspan="3"><img src="images/spacer.gif" height="5" width="100" /></td>
			</tr>//--->
			<tr>
				<td colspan="3"><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">RELEASE TITLE</td>
          </tr>
					 </table></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF" colspan="3"><cfinput type="text" name="title" maxlength="255" size="75" class="inputBox" required="yes" message="RELEASE TITLE is required"></td>
				</tr>
			<tr>
				<td colspan="3"><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">COMMENT</td>
          </tr>
					 </table></td>
			</tr>
            
			<tr>
				<td bgcolor="#FFFFFF" colspan="3"><cfinput type="text" name="comment" maxlength="150" size="75" class="inputBox"></td>
				</tr>
			<tr>
				<td colspan="3"><img src="images/spacer.gif" height="5" width="100" /></td>
			</tr>

			<tr>
				<td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">LABEL</td>
          </tr>
					 </table></td>
					 <td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">CATALOG #</td>
          </tr>
					 </table></td>
					 <td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">RELEASE DATE</td>
          </tr>
					 </table></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF"><!---<cfselect query="labels" name="labelID" value="ID" display="name">
					<option value="0" selected="yes">Choose a label...</option>
				</cfselect>//---><cfinput type="text" name="addLabelName" maxlength="255" size="25" class="inputBox"></td>
				<td bgcolor="#FFFFFF"><cfinput type="text" name="catnum" maxlength="30" size="25" class="inputBox" required="yes" message="CATALOG ## is required"></td>
				<td bgcolor="#FFFFFF"><cfinput type="text" name="releaseDate" maxlength="10" size="25" class="inputBox" required="yes" message="RELEASE DATE is required" value="#DateFormat(varDateODBC,"mm/dd/yyyy")#"></td>
			</tr>
			<tr>
				<td colspan="3"><img src="images/spacer.gif" height="5" width="100" /></td>
			</tr>
			<tr>
				<td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">MEDIA</td>
          </tr>
					 </table></td>
					 <td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel" align="center">GENRE / RE-ISSUE / SPECIAL</td>
          </tr>
					 </table></td>
					 <td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel"># PIECES IN SET</td>
          </tr>
					 </table></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF"><cfselect query="backendMediaTypes" name="mediaID" value="ID" display="name" selected="1">
				</cfselect></td>
				<td bgcolor="#FFFFFF"><cfselect query="backendGenres" name="genreID" value="ID" display="name" selected="1">
					<option value="0">Choose a genre...</option>
				</cfselect> </td>
				<td bgcolor="#FFFFFF"><cfinput type="text" name="NRECSINSET" maxlength="10" size="25" class="inputBox" value="1"></td>
			</tr>
			<tr>
				<td colspan="3"><img src="images/spacer.gif" height="5" width="100" /></td>
			</tr>
			<tr>
				<td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">PRICE</td>
          </tr>
					 </table></td>
					 <td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">COST / WHOLESALE PRICE</td>
          </tr>
					 </table></td>
					 <td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">DISCOGS ID#</td>
          </tr>
					 </table></td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF"><cfinput type="text" name="price" maxlength="10" size="25" class="inputBox" required="yes" message="PRICE is required" validate="float" value="0.00"></td>
				<td bgcolor="#FFFFFF"><cfinput type="text" name="cost" maxlength="10" size="10" class="inputBox" value="0.00" required="yes" message="COST is required" validate="float"><cfinput type="text" name="wholesalePrice" maxlength="10" size="10" class="inputBox" value="0.00" required="yes" message="WHOLESALE PRICE is required" validate="float"></td>
				<td bgcolor="#FFFFFF"><cfinput type="text" name="discogsID" maxlength="10" size="10" class="inputBox" value="0" required="yes" message="Discogs ID is required, if not known, put 0"></td>
			</tr>
			<tr>
				<td colspan="3"><img src="images/spacer.gif" height="5" width="100" /></td>
			</tr>
			<tr>
				<td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">ORDER 304</td>
          </tr>
					 </table></td>
					 <td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">VENDOR</td>
          </tr>
					 </table></td>
					 <td><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td class="dataLabel">COUNTRY</td>
          </tr>
					 </table></td>
			</tr>
                       
			<tr>
				<td bgcolor="#FFFFFF"><cfinput type="text" name="ORDER304" maxlength="4" size="25" class="inputBox" value="0" required="yes" message="ORDER 304 is required (but can be zero)">
				<!---<cfselect name="CONDITION_MEDIA_ID" query="backendCondition" value="ID" display="condition" selected="1"></cfselect>
				<cfselect name="CONDITION_COVER_ID" query="condition" value="ID" display="condition" selected="1"></cfselect>//---></td>
				<td bgcolor="#FFFFFF"><cfselect query="backendShelfs" name="shelfID" value="ID" display="partner" selected="#Cookie.shelfselect#"></cfselect></td>
				<td bgcolor="#FFFFFF"><cfselect query="backendCountries" name="countryID" value="ID" display="name" selected="#Cookie.countryselect#"></cfselect></td>
				</td>
			</tr>
             <tr>
            	<td colspan="3">
                	<table>
                    	<tr>
                            <td valign="top" style="font-size: 12px">
                                <cfinput type="checkbox" name="reissue" value="Yes"> Reissue<br>
                                <cfinput type="checkbox" name="remastered" value="Yes"> Remastered
                            </td>
                            <td valign="top"  style="font-size: 12px">
                                <cfinput type="checkbox" name="vinyl180g" id="vinyl180g" value="Yes"> 180g Vinyl<br>
                                <cfinput type="checkbox" name="limitedEdition" value="Yes"> Limited Edition
                            </td>
                            <td valign="top"  style="font-size: 12px">
                                <cfinput type="checkbox" name="repress" value="Yes"> Re-press<br>
                                <cfinput type="checkbox" name="warehouseFind" value="Yes"> Warehouse Find
                            </td>
                            <td valign="top"  style="font-size: 12px">
                                <cfinput type="checkbox" name="dt304exclusive" value="Yes"> Exclusive<br>
                                <cfinput type="checkbox" name="notched" value="Yes"> Notched
                            </td>
						</tr>
                    </table>
                </td>
            </tr>
    </table>
		<div align="right" style="margin-top: 10px;">Catalog Number Confirm: 
		  <input type="text" name="catConfirm" size="12" />
		# Tracks: <input type="text" name="numtrx" size="4" maxlength="2" style="text-align:center" value="0"><input type="submit" name="submit" value=" DONE " /> <input type="submit" name="submit" value=" ADD " /></div>
		</cfform>
		</td></tr></table>
		<p>&nbsp;</p>
		<cfinclude template="pageFoot.cfm">