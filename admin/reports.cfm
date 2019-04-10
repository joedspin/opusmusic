<cfset pageName="REPORTS">
<cfinclude template="pageHead.cfm">
		<p style="font-size: medium">Reports</p>
		<table border="0" cellpadding="0" cellspacing="0">
        <tr><td valign="top"><p><cfoutput><span style="color: ##66CC00; font-size: small">Receiving</span><a href="reportsCatRcvd.cfm?crdate=#DateFormat(varDateODBC,"yyyy-mm-dd")#" target="_blank"><br />
  Catalog Received (today)</a></cfoutput><br />
                <!---<a href="reportsCatRcvd.cfm?cros=yes" target="_blank">ONSIDE Audits (today)</a><br />
                <a href="reportsONSIDESales.cfm" target="_blank">ONSIDE Sales (past week)</a>//---></p>
          <p><span style="color: #66CC00; font-size: small">Exporting Catalog</span><br />
            <a href="../dt304playerBuilder.cfm">Downtown 304 Player Builder</a><br />
              <!---<a href="reportsExportGEMM.cfm">Export for GEMM</a><br />
              <a href="reportsExportGEMMcostPlus.cfm">Export for GEMM Cost Plus</a><br />//--->
              <a href="reportsExportDISCOGS.cfm">Export for Discogs</a><br />
             <!--- <a href="reportsExportDISCOGSprodcleauct.cfm">Export for Discogs PRODUCT</a><br />//--->
              <a href="reportsExportMusicStack.cfm">Export for MusicStack</a><br />
              <!---<a href="reportsExportGEMMDT.cfm">DownTown161 Export for GEMM</a><br />
		<a href="reportsPARTNER.cfm">Partner Report</a><br />//--->
                <a href="reportsNewReleasesEmail.cfm" target="_blank">New Releases (HTML)</a><br />
                <a href="reportsNewReleasesFacebook.cfm" target="_blank">New Releases (Facebook)</a><br />
                <a href="reportsEmailNewsBrackets.cfm" target="_blank">New Releases (Bracket Codes)</a><br />
                <a href="reportsDT161Inventory.cfm" target="_blank">Downtown 161 Inventory</a><br />
                <a href="http://www.downtown304.com/dt161news.cfm?distro=true" target="_blank">Downtown 304 New Items</a><br />
                <a href="reportsDT304DistributionInventory.cfm?current=yes" target="_blank">Downtown 304 Distribution - Current</a><br />
                <a href="reportsDT304DistributionInventory.cfm" target="_blank">Downtown 304 Distribution - All</a><br />
                <a href="reportsDT304DistributionInventory.cfm?catalogFilter=classics" target="_blank">Downtown 304 Distribution - Classics</a><br />
                <a href="reportsDT304DistributionInventory_MetroLowInventory.cfm" target="_blank">Downtown 304 Distribution - Almost Gone</a><br>
                <a href="reportsImportInventoryOPEN.cfm" target="_blank">Downtown 304 - Inventory Report</a></p>
          <p><span style="color: #66CC00; font-size: small">Imports</span><br />
		    <a href="reportsImportInventory.cfm" target="_blank">Imports - List All </a><br />
            <!---<a href="reportsIMPORTSDT.cfm">Imports Listed on DT161</a><br />
            <a href="reportsImportInventory.cfm?sb=ONHAND">Import Inventory - sort by ONHAND</a><br />
            <a href="reportsImportInventory.cfm?sb=releaseDate">Import Inventory - sort by NEWS</a><br />//--->
		    <a href="reportsImportsOOS-QTY.cfm">Imports - ONHAND but not listed</a><br />
			  <a href="fixOnhandOutOfStock.cfm" target="_blank">Fix ONHAND but Out of Stock</a><br />
			  <a href="reportsPrereleaseNotReceived.cfm" target="_blank">Prereleases Not Received</a><br>
		    <a href="reportsImportsZeroes.cfm">Imports - Negative ONHAND</a></p>
		<p><span style="color: #66CC00; font-size: small">Research</span><br />
		      <a href="reportsPriceErrors.cfm" target="_blank">Price Errors</a><br />
              <a href="reportsPriceZeroes.cfm" target="_blank">Price Zeroes</a><br />
              <a href="ordersSalesOpen.cfm">Value of Open Orders</a><br />
		      <a href="reportsNewReleasesResearch.cfm" target="_blank">New Releases</a><br />
		      <a href="reportsNotifyMe.cfm" target="_blank">Email Me When Available</a><br />
		      <a href="reportsNoTracks.cfm" target="_blank">No Tracks</a><br />
              <a href="reportsNoSnippets.cfm" target="_blank">No Snippets</a><br />
		      <!---<a href="reportsSaleResearch.cfm" target="_blank">George T Sale</a><br />
              <a href="reportsGeorgeTWhiteLabels.cfm" target="_blank">George T White Labels</a><br />//--->
		      <a href="reportsTopSellers.cfm" target="_blank">Top Sellers</a><br />
		      <a href="reportsTopPending.cfm" target="_blank">Top Pending</a><br />
			<a href="reportsSpecial.cfm" target="_blank">Special Flag</a><br>
		        <a href="reportsTopPendingImports.cfm" target="_blank">Top Pending Imports</a><BR />
              <cfoutput> <!--- <a href="reportsResearchDT161discountALLMONTHS.cfm?mo=#DateFormat(varDateODBC,"m")#&yr=#DateFormat(varDateODBC,"yyyy")#" target="_blank">DT161 Cost Savings</a><br />//--->
              <a href="reportsNoSellHistory.cfm" target="_blank">No Sell History</a><BR />
              <a href="reportsDiscogs.cfm" target="_blank">Need Discogs ID</a><br>
		      <a href="reportsNotReceived.cfm">Quantity but not in stock</a><br>
              <a href="fixPriceSave.cfm?ret=reports.cfm">Restore Saved Prices</a></p>
		    
		<p><a href="ordersSalesByMonthURL.cfm?mo=#DateFormat(varDateODBC,"m")#&yr=#DateFormat(varDateODBC,"yyyy")#" target="_blank">Gross Sales This Month</a><br />
			<a href="ordersSalesByMonthOLD.cfm" target="_blank">Gross Sales All</a><br />
            <a href="reportsSalesTax.cfm">Sales Tax</a></p>
            <a href="reportsAnualPurchases.cfm?purchyear=#DateFormat(varDateODBC,"yyyy")-1#">Annual Purchases</a><br>
              <a href="reportsInventoryValue.cfm">Inventory Value</a><br />
              <a href="reportsDT161AnnualCost.cfm">161 Annual Cost</a></p>
            <cfset lastMo=DateFormat(varDateODBC,"m")-1>
            <cfset lastMoYr=#DateFormat(varDateODBC,"yyyy")#>
            <cfif lastMo EQ 0>
            	<cfset lastMo=12>
                <cfset lastMoYr=lastMoYr-1>
            </cfif>
            <p><a href="reportsUPS.cfm?mo=#lastMo#&yr=#lastMoYr#" target="_blank">UPS Shipments Last Month</a><br />
              <a href="reportsOrdersShipped.cfm">Recently Shipped Orders</a><br />
              <a href="reportsOrdersShipped.cfm?filter=2">Recently Shipped Discogs Orders</a><a href="reportsUPS.cfm?mo=#lastMo#&yr=#lastMoYr#" target="_blank"><br />
&nbsp;</a></p>
			</cfoutput></td>
            <td width="50">&nbsp;</td>
            <td valign="top"><!---<p><span style="color: #66CC00; font-size: small">On the Side </span><a href="reportsONSIDE.cfm?ID=status21"><br />
  ONSIDE Report - New Releases</a><br />
            	<a href="reportsONSIDE.cfm?statusID=22">ONSIDE Report - Recent Releases</a><br />
                <a href="reportsONSIDE.cfm?statusID=23">ONSIDE Report - Back in Stock</a><br />
                <a href="reportsONSIDE.cfm?statusID=24">ONSIDE Report - Regular</a><br />
                <a href="reportsONSIDE.cfm?statusID=25">ONSIDE Report - Out of Stock</a><br />
                <a href="reportsONSIDE.cfm?statusID=44">ONSIDE Report - Inactive</a><br />
                <a href="reportsONSIDEAll.cfm" target="_blank">ONSIDE Report - ALL</a></p>//--->
              <p><span style="color: #66CC00; font-size: small">Misc.</span><br />
              
                <a href="reports_WhiteLabelDJOnly.cfm" target="_blank">white label DJ ONLY</a><br />
                <a href="reports_PictureDiscs.cfm" target="_blank">Picture Discs</a><br />
                <a href="reports_Special.cfm" target="_blank">Special (by Search Criteria)</a><br />
                <a href="reportslabelListNoImages.cfm" target="_blank">Labels with no image</a><br />
                  <a href="reportsPromos.cfm" target="_blank">Promos</a><br />
                  <a href="reportsGRUSA.cfm">Domestic Inventory (Non-DT161)</a><br />
                  <a href="reportsInventoryMetro.cfm">Metro Inventory</a><br />
				  <a href="http://www.downtown304.com/dt161news.cfm?classics=metro" target="_blank">GST In Stock</a><br />
				  <a href="http://www.downtown304.com/dt161news.cfm?classics=george" target="_blank">GT In Stock</a><br />
                  <a href="reportsDT304InventoryONHAND.cfm">Inventory Value</a><br>
                  <a href="reportsInventoryGeorgeT.cfm">George T. Inventory</a><br />
                  <a href="reportsDiscogsPostage.cfm">Discogs Postage (1 Week)</a><br />
				  <a href="fixBackInStockToReg.cfm">Back In Stock to Regular</a><br />
                  <!---<a href="reportsBS.cfm" target="_blank">BS Shelf List</a><br />
                  <a href="reportsZShelf.cfm" target="_blank">Z Shelf List</a><br />//--->
                  
              		<a href="reportsImports107.cfm" target="_blank">10-inch and 7-inch</a><br />
              		<a href="reportsDT161Duplicates.cfm" target="_blank">DT161 Duplicate IDs</a><br />
              		<a href="reports_CustomerStats.cfm" target="_blank">Customer Stats</a><br>
					<a href="cleanOldMP3s.cfm" target="_blank">Clean Old MP3s</a></p>
              <p style="color: #66CC00; font-size: small">Vendors<br>
				  <cfoutput><a href="ordersSalesByMonthByVendor.cfm?vendorID=1059&weeknum=#week(DateAdd('d','-7',varDateODBC))#&yearnum=#DateFormat(DateAdd('d','-7',varDateODBC),'yyyy')#" target="_blank">GST Last Week</a><br>
             		<a href="ordersSalesByMonthByVendor.cfm?vendorID=1059&weeknum=#week(varDateODBC)#&yearnum=#DateFormat(varDateODBC,'yyyy')#" target="_blank">GST This Week</a></cfoutput></p>
              <cfquery name="vendors" datasource="#DSN#">
          	select *
            from shelf
            where isVendor=1
            order by partner
          </cfquery>
          <cfquery name="storeCusts" datasource="#DSN#">
          	select *
            from custAccounts
            where isStore=1
            order by username
          </cfquery>
          <cfform action="reportsPO.cfm" name="poReport" target="_blank" method="post">
              <cfselect id="vendorID" query="vendors" name="vendorID" value="ID" display="partner" class="inputBox"></cfselect><input type="submit" name="PO" value="PO" />
              </cfform>
			  <cfform action="reportsPOReceive.cfm" name="poReport" target="_blank" method="post">
              <cfselect id="vendorID" query="vendors" name="vendorID" value="ID" display="partner" class="inputBox"></cfselect><input type="submit" name="Receive" value="Receive" />
              </cfform>
              <cfform action="ordersSalesByMonthByVendor.cfm" name="salesReport" target="_blank" method="post">
              <cfselect id="vendorID" query="vendors" name="vendorID" value="ID" display="partner" class="inputBox"></cfselect><input type="submit" name="Sales" value="Sales" />
              </cfform>
              <cfform action="reportsInventoryByVendor.cfm" name="inventoryReport" target="_blank" method="post">
              <cfselect id="vendorID" query="vendors" name="vendorID" value="ID" display="partner" class="inputBox"></cfselect><input type="submit" name="Inventory" value="Inventory" />
              </cfform>
              <p style="font-size: small; color: #66CC00">Store Customers</p>
              <cfform action="reportsPOcustomer.cfm" name="poReportcust" target="_blank" method="post">
              <cfselect query="storeCusts" name="custID" value="ID" display="username" class="inputBox"><option value="0" selected>downtown304</option></cfselect><input type="submit" name="ORDER" value="ORDERS" />
              </cfform>
              <cfform action="reportsPOcustomerComplete.cfm" name="poReportcust" target="_blank" method="post">
              <cfselect query="storeCusts" name="custID" value="ID" display="username" class="inputBox"><option value="0" selected>downtown304</option></cfselect><input type="submit" name="ORDER" value="ORDERS COMPLETE" />
              </cfform>
              <p><br />&nbsp;</p></td>
                </tr>
                </table>
           
<cfquery name="hitLog" datasource="#DSN#">
	select *
	from hit_counter
	where pagename NOT LIKE '%OLD'
</cfquery>
<table width="500" border="0" cellpadding="4" cellspacing="2">
<tr bgcolor="#663300"><td colspan="3" bgcolor="#000000" class="style15"><span style="font-size: small; color: #66CC00"><font face="Arial, Helvetica, sans-serif">Site Statistics</font></span></td>
</tr>
<tr bgcolor="#999999">
	<td><span class="style17" style="color: #333333; font-weight: bold"><font face="Arial, Helvetica, sans-serif">Page</font></span></td>
	<td align="center">
	  <div align="center" class="style16" style="color: #333333; font-weight: bold"><span class="style13"><font face="Arial, Helvetica, sans-serif">Hits</font></span></div>	</td>
	<td><span class="style17" style="color: #333333; font-weight: bold"><font face="Arial, Helvetica, sans-serif">Since</font></span></td>
</tr>
<cfoutput query="hitLog">
<tr bgcolor="##CCCCCC">
	<td><span class="style16" style="color: ##000000"><font face="Arial, Helvetica, sans-serif"><cfif fullname NEQ "">#fullname#<cfelse>#pagename#</cfif></font></span></td>
	<td align="center">
	  <div align="right" class="style16" style="color: ##000000"><font face="Arial, Helvetica, sans-serif">#NumberFormat(hit_count,",")#</font></div>	</td>
	<td><span class="style16" style="color: ##000000"><font face="Arial, Helvetica, sans-serif">#DateFormat(sinceDate,"mmmm d, yyyy")#</font></span></td>
</tr>
</cfoutput>
</table>
<p>&nbsp;</p>
		<cfinclude template="pageFoot.cfm">