		<cfparam name="url.backtoreg" default="">
		<cfparam name="url.special" default="">
		<cfoutput>
		<table border="0" cellpadding="5" cellspacing="0">
      <tr>
		<td><img src="images/spacer.gif" width="1" height="10"></td>
        <!---<td><font color="white" style="font-size: 16px;"><b>Catalog</b></font></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>//--->
		<td><a href="#URLSessionFormat("catalogAdd.cfm")#">ADD ITEM</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
		<td><a href="#URLSessionFormat("catalogDTHistory.cfm")#">161 Import History</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
		<!---<td><a href="#URLSessionFormat("catalogDTPreReleases.cfm")#">161 Pre-Releases</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>//--->
		<!---<td><a href="catalogBACKTOREG.cfm">Back -> Regular</a>&nbsp;&nbsp;&nbsp;<cfif url.backtoreg NEQ ""><font color="red"><b>#url.backtoreg# ITEMS FIXED</b></font></cfif></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>//--->
		<td><a href="listsPlayListsEdit.cfm?staff=true">Staff Picks</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
		<td><a href="catalog_ViewOnly.cfm" target="dt304distviews">View Only</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
		<!---<td><a href="listsLabelsFeatured.cfm">Featured Label</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
		<td><a href="catalog.cfm?special=special">Find Special</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>//--->
        <td><a href="catalogEdit.cfm?findReissue=yes">Find Reissue</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
        <td><a href="catalog.cfm?findDT161Dups=true">Find 161 Duplicates</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
		<!---<td><a href="catalogSpecialSend.cfm">Send Special</a><cfif url.special EQ "sent"> <font color="red">SENT</font></cfif></td>
        <td><img src="images/spacer.gif" width="10" height="10"></td>//--->
        <!---<td><a href="http://www.downtown304.com/blueLightSaleReview.cfm" target="_blank">Blue Light</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>//--->
        <td><a href="discogsSplitScreen.htm" target="_top">Discogs Split Screen</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
        <td><a href="catalog.cfm?pricelist=odd">Price Oddities</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
		<td><a href="http://www.downtown304.com/resetCacheOverrideJTD.cfm" target="_blank">Force Cache Refresh</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
        <td><a href="catalogEdit.cfm?newest=find">Find Newest</a></td>
		<td><img src="images/spacer.gif" width="10" height="10"></td>
		</tr>
		</table>
		
		</cfoutput>

		<!---<a href="#URLSessionFormat("listsLabelsAdd.cfm")#">ADD LABEL</a>&nbsp;&nbsp;&nbsp;//--->

        
		<!---<a href="#URLSessionFormat("catalogReview.cfm")#">Catalog Review</a>&nbsp;&nbsp;&nbsp;//--->
		<!---<a href="#URLSessionFormat("catalogNewReleases.cfm")#" target="_blank">New Release Report</a>&nbsp;&nbsp;&nbsp;//--->
		<!---<a href="catalog.cfm?zeroes=yes">Minuses</a>&nbsp;&nbsp;&nbsp;//--->

		<!---<a href="catalog.cfm?ob=ID&so=DESC">Fix Sort</a>&nbsp;&nbsp;&nbsp;
		<a href="http://www.downtown304.com/opussitelayout07main.cfm?group=new&clearit=flush">Flush NR Cache</a>
		<a href="#URLSessionFormat("catalogSales.cfm")#">RESEARCH</a>//--->