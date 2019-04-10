<cfparam name="url.ID" default="0">
<cfparam name="url.express" default="">
<cfparam name="url.start" default="">
<cfparam name="url.pageBack" default="orders.cfm">
<cfparam name="url.killInactive" default="false">
<cfparam name="url.revealPics" default="false">
<cfparam name="url.shelf" default="no">
<cfset pageName="ORDERS">
<cfset pageSub="EDIT">
<cfinclude template="pageHead.cfm">
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<cfquery name="checkBad" datasource="#DSN#">
	select *
	from custAccounts
	where badCustomer=1 AND ID=#thisOrder.custID#
</cfquery>
	
<cfif url.shelf EQ "yes"><cfinclude template="ordersShelfList.cfm"></cfif>	
<cfif checkBad.recordCount EQ 0>
<cfquery name="thisItems" datasource="#DSN#">
    SELECT *
    FROM orderItemsQuery
    where orderID=#ID#
</cfquery>
<cfloop query="thisItems">
	<cfquery name="ForceOutOfStock" datasource="#DSN#">
		update catItems
		set albumStatusID=27
		where ONHAND<=(select sum(qtyOrdered) from orderItemsQuery where catItemID=#catItemID# AND adminAvailID IN (2,4,5) AND statusID NOT IN (1,7)) AND ID=#catItemID# AND albumStatusID<25
	</cfquery>
</cfloop>
</cfif>
	
<cfset onlyImports=true>
<!--- Select the items for DT161 first so the "Invoice" flag can be properly set //--->
<cfquery name="thisItems" datasource="#DSN#">
    SELECT *
    FROM orderItemsQuery
    where shelfID=11 AND orderID=#ID#  AND vendorID NOT IN (5650,6978,2811)
    order by label, catnum
</cfquery>
<cfif thisItems.recordCount GT 0><cfset onlyImports=false></cfif>
<cfquery name="Application.allShipOptions" datasource="#DSN#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	select ID as shippingOptionID, *
	from shippingRatesQuery
	order by countryID, cost1Record DESC
</cfquery>
<cfquery name="otherSites" datasource="#DSN#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
	select * 
	from otherSites
	order by otherSiteID
</cfquery>
	
<cfform name="opusProcess" method="post" action="ordersEditAction.cfm">
		
	<cfoutput query="thisOrder">
    	<cfset thisShipID=shipID>
			<cfquery name="fixStatus" datasource="#DSN#">
				UPDATE orderItems
				set adminAvailID=2
				where adminAvailID=0 AND orderID=#ID#
			</cfquery>

			<!---<cfquery name="thisShipAddress" datasource="#DSN#">
				select *
				from custAddressesQuery
				where ID=#shipAddressID#
			</cfquery>//--->
			<cfquery name="custAddresses" datasource="#DSN#">
				select *
				from custAddressesQuery
				where custID=#custID#
				order by useFirst DESC
			</cfquery>

			<cfquery name="thisStatus" datasource="#DSN#">
				select statusName
				from orderStatus
				where ID=#statusID#
			</cfquery>
            <cfquery name="thisCust" datasource="#DSN#">
				select *
				from custAccounts
				where ID=#custID#
			</cfquery>
            <cfloop query="thisCust">
            	<p style="font-size: medium; font-weight: bold; color:black;"><b>Order ###NumberFormat(url.ID,"00000")#</b> - <a href="customersOpusEdit.cfm?ID=#thisOrder.custID#"><cfif isStore>#billingName#<cfelse>#firstName# #lastName#</cfif></a> [#username#]</p>
            	<cfset thisCustEmail=email>
            </cfloop>
					<p><cfinput type="checkbox" value="yes" name="allowedits" checked="no"> Allow Edits</p>
	<p><b>Started: </b> #DateFormat(dateStarted,"mm/dd/yy")# / 
						<cfif datePurchased NEQ ""><b>Checked Out: </b>#DateFormat(datePurchased,"mm/dd/yy")#</cfif><cfif dateShipped NEQ ""><b>Shipped: </b>#DateFormat(dateShipped,"mm/dd/yy")#</cfif>&nbsp;&nbsp;&nbsp;[<font color="orange">#UCase(thisStatus.statusName)#</font>]<br />
						<a href="ordersClose.cfm?ID=#thisOrder.ID#">CLOSE</a> |
                        <a href="ordersDelete.cfm?ID=#thisOrder.ID#">DELETE ALL</a> |
                        <a href="ordersUnfinalize.cfm?ID=#thisOrder.ID#">UNFINALIZE</a> |
						<!---<a href="ordersEmailAdmin.cfm?ID=#thisOrder.ID#&paid=7">EMAIL ADMIN</a> |//--->
						<a href="ordersDuplicate.cfm?ID=#thisOrder.ID#">RESHIP</a> |
                        <a href="ordersReset.cfm?ID=#thisOrder.ID#">Reset Cart</a> |
                        <a href="ordersItemsNotAvailable.cfm?ID=#thisOrder.ID#">Inactive Report</a> |
                        <a href="ordersPrintConfirmation.cfm?ID=#thisOrder.ID#" target="_blank">INVOICE</a> |
                        <cfif statusID NEQ 4><a href="ordersPaid.cfm?ID=#url.ID#&paid=4">PAID</a> |<cfelse><a href="ordersPaid.cfm?ID=#url.ID#&paid=2">NOT PAID</a> |</cfif>
                      	<a href="ordersPrintLabels.cfm?ID=#thisOrder.ID#">Packing List</a> |
                        <a href="ordersVerifyImport.cfm?ID=#thisOrder.ID#" target="_blank">Verify Import</a> |
                        <a href="ordersEdit.cfm?ID=#thisOrder.ID#&revealPics=true">Reveal Pics</a>
                       
 <p>3rd Party Site: <cfselect name="otherSiteID" query="otherSites" display="name" value="otherSiteID" selected="#otherSiteID#"></cfselect><!---	<cfinput type="checkbox" value="Yes" checked="#isGEMM#" name="isGEMM"> GEMM Order//--->&nbsp;&nbsp;&nbsp;
            <input type="hidden" name="express" value="#url.express#" />
			<input type="checkbox" value="1" name="readyToPrint" <cfif readyToPrint>checked</cfif> /> Ready to Print &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="1" name="picklistPrinted" <cfif picklistPrinted>checked</cfif> /> Picklist Printed &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="1" name="issueRaised" <cfif issueRaised>checked</cfif> /> Order Picked &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="1" name="issueResolved" checked /> Invoiced &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="1" name="isVinylmania" <cfif isVinylmania>checked</cfif> /> Vinylmania<input type="hidden" name="onlyImports" value="#YesNoFormat(onlyImports)#" /> <input type="hidden" name="custID" value="#custID#" /><input type="hidden" name="statusID" value="#statusID#" /><br />
            Discogs Order ##10096-<cfinput type="text" name="otherSiteOrderNum" value="#Trim(otherSiteOrderNum)#" size="12" maxlength="25"><cfif Val(otherSiteOrderNum) NEQ 0> <a href="https://www.discogs.com/sell/order/10096-#Trim(otherSiteOrderNum)#" target="discogsFrame">Go</a></cfif></p>
            
<cfquery name="iStat" datasource="#DSN#" cachedwithin="#CreateTimeSpan(1,0,0,0)#">
    select *
    from orderItemStatus
    where ID>1
</cfquery>	
<style>
h1 {margin-top: 6px; margin-bottom: 6px; margin-left: 6px; font-size: small; font-weight: bold;}
</style>
  <!---<cfquery name="thisItems" datasource="#DSN#">
				SELECT *
				FROM orderItemsQuery
				where orderID=#ID#
				order by adminAvailID, label, catnum
			</cfquery>//--->		
	<cfset totalItemCount=0>		
		<table cellpadding="3" cellspacing="0" border="1" style="border-collapse:collapse;">
						
                        <tr><td colspan="21"><h1>Downtown 161</h1></td></tr>

		



							<cfloop query="thisItems">
                            <cfset totalItemCount=totalItemCount+1>
							<tr>
								<cfset thisItemID=orderItemID>
								<cfset thisItemStatID=adminAvailID>
                                <cfif url.revealPics><cfif fullImg NEQ "">
            	<cfset imagefile="items/oI#catItemID#full.jpg">
			<cfelseif jpgLoaded>
				<cfset imagefile="items/oI#catItemID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><img src="../images/#imagefile#" width="75" height="75" border="0" /></a></td></cfif>
            <td nowrap><cfselect name="stat#thisItemID#" query="iStat" display="name" value="ID" selected="#thisItemStatID#" style="font-size: xx-small;"></cfselect></td>
									
								<td nowrap><input type="text" name="price#thisItemID#" value="#DollarFormat(price)#" size="4"  style="font-size: xx-small;"/></td>
                                <cfif url.killInactive AND albumStatusName EQ "Inactive"><cfset thisQTY=0><cfelse><cfset thisQTY=qtyOrdered></cfif>
								<td nowrap><cfinput type="text" size="2" style="padding: 0px; font-size: xx-small;" maxlength="3" value="#thisQTY#" name="qty#thisItemID#"><!---<input type="checkbox" name="invoiced" value="yes" <cfif dt161invoiceConfirm EQ 1>checked</cfif>>//---></td>
								<td><input type="checkbox" name="moveItem" value="#orderItemID#"></td>
                                <td nowrap><a href="catalogEdit.cfm?ID=#catItemID#" target="catEdit">#catnum#</a></td>
								<td nowrap>#Left(label,10)#</td>
								<td nowrap>#Left(artist,20)#</td>
								<td nowrap>#Left(title,20)#</td>
                                <td nowrap><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
                                <td nowrap>#shelfCode#</td>
                                <td nowrap><a href="ordersItemDeleteAction.cfm?ID=#thisItemID#&pageBack=ordersEdit.cfm?ID=#url.ID#">DEL</a></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
                            <td nowrap>N<cfif albumStatusID NEQ 21><input type="checkbox" name="makeNew" value="#catItemID#"></cfif></td>
							<td nowrap>B<cfif albumStatusID NEQ 23><input type="checkbox" name="makeBackInStock" value="#catItemID#"></cfif></td>
                            <td nowrap>R<cfif albumStatusID NEQ 24><input type="checkbox" name="makeRegular" value="#catItemID#"></cfif></td>
                            <td nowrap>O<cfif albumStatusID NEQ 25 AND albumStatusID NEQ 27><input type="checkbox" name="makeOutOfStock" value="#catItemID#"></cfif></td>
							<td nowrap>I<cfif albumStatusID NEQ 44><input type="checkbox" name="makeInactive" value="#catItemID#"></cfif></td>
							<td nowrap><cfif albumStatusID GT 24><font color="##FF0000"><b>#albumStatusName#</b></font><cfelse>#albumStatusName#</cfif></td>
							<td><cfif discogsID GT 0><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">Discogs</a><cfelse>&nbsp;</cfif></td>
					</tr>
			</cfloop>
            
            
             <tr><td colspan="21"><h1>Metro (Top Shelf)</h1></td></tr>

		<cfquery name="thisItems" datasource="#DSN#">
            SELECT *
            FROM orderItemsQuery
            where shelfID=11 AND orderID=#ID# AND vendorID IN (5650,6978,2811)
            order by label, catnum
        </cfquery>
							<cfloop query="thisItems">
                            <cfset onlyImports=false>
                            <cfset totalItemCount=totalItemCount+1>
							<tr>
								<cfset thisItemID=orderItemID>
								<cfset thisItemStatID=adminAvailID>
                                <cfif url.revealPics><cfif fullImg NEQ "">
            	<cfset imagefile="items/oI#catItemID#full.jpg">
			<cfelseif jpgLoaded>
				<cfset imagefile="items/oI#catItemID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><img src="../images/#imagefile#" width="75" height="75" border="0" /></a></td></cfif>
            <td nowrap><cfselect name="stat#thisItemID#" query="iStat" display="name" value="ID" selected="#thisItemStatID#" style="font-size: xx-small;"></cfselect></td>
									
								<td nowrap><input type="text" name="price#thisItemID#" value="#DollarFormat(price)#" size="4"  style="font-size: xx-small;"/></td>
                                <cfif url.killInactive AND albumStatusName EQ "Inactive"><cfset thisQTY=0><cfelse><cfset thisQTY=qtyOrdered></cfif>
								<td nowrap><cfinput type="text" size="2" style="padding: 0px; font-size: xx-small;" maxlength="3" value="#thisQTY#" name="qty#thisItemID#"><!---<input type="checkbox" name="invoiced" value="yes" <cfif dt161invoiceConfirm EQ 1>checked</cfif>>//---></td>
								<td><input type="checkbox" name="moveItem" value="#orderItemID#"></td>
                                <td nowrap><a href="catalogEdit.cfm?ID=#catItemID#" target="catEdit">#catnum#</a></td>
								<td nowrap>#Left(label,10)#</td>
								<td nowrap>#Left(artist,20)#</td>
								<td nowrap>#Left(title,20)#</td>
                                <td nowrap><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
                                <td nowrap>#shelfCode#</td>
                                <td nowrap><a href="ordersItemDeleteAction.cfm?ID=#thisItemID#&pageBack=ordersEdit.cfm?ID=#url.ID#">DEL</a></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
                            <td nowrap>N<cfif albumStatusID NEQ 21><input type="checkbox" name="makeNew" value="#catItemID#"></cfif></td>
							<td nowrap>B<cfif albumStatusID NEQ 23><input type="checkbox" name="makeBackInStock" value="#catItemID#"></cfif></td>
                            <td nowrap>R<cfif albumStatusID NEQ 24><input type="checkbox" name="makeRegular" value="#catItemID#"></cfif></td>
                            <td nowrap>O<cfif albumStatusID NEQ 25 AND albumStatusID NEQ 27><input type="checkbox" name="makeOutOfStock" value="#catItemID#"></cfif></td>
							<td nowrap>I<cfif albumStatusID NEQ 44><input type="checkbox" name="makeInactive" value="#catItemID#"></cfif><cfif albumStatusID GT 24><font color="##FF0000"><b>#albumStatusName#</b></font><cfelse>#albumStatusName#</cfif></td>
							<td><cfif discogsID GT 0><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">Discogs</a><cfelse>&nbsp;</cfif></td>
					</tr>
			</cfloop>
            
            
            <tr><td colspan="20"><h1>Downtown 304</h1></td></tr>
                        <cfquery name="thisItems" datasource="#DSN#">
                            SELECT *
                            FROM orderItemsQuery
                            where shelfID<>11 AND orderID=#ID# AND shelfID NOT IN (2080,1064,1059,2127,2131,2136)
                            order by label, catnum
                        </cfquery>
          
							<cfloop query="thisItems">
							<cfif price EQ 0><tr bgcolor="red"><cfelse><tr></cfif>
								<cfset thisItemID=orderItemID>
								<cfset thisItemStatID=adminAvailID>
							<cfif url.revealPics><cfif fullImg NEQ "">
            	<cfset imagefile="items/oI#catItemID#full.jpg">
			<cfelseif jpgLoaded>
				<cfset imagefile="items/oI#catItemID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><img src="../images/#imagefile#" width="75" height="75" border="0" /></a></td></cfif>
                            <td nowrap><cfselect name="stat#thisItemID#" query="iStat" display="name" value="ID" selected="#thisItemStatID#" style="font-size: xx-small;"></cfselect>
							<td nowrap><input type="text" name="price#thisItemID#" value="#DollarFormat(price)#" size="4"  style="font-size: xx-small;"/></td>
                            <cfif url.killInactive AND albumStatusName EQ "Inactive"><cfset thisQTY=0><cfelse><cfset thisQTY=qtyOrdered></cfif>
								<td nowrap><cfinput type="text" size="2" style="padding: 0px; font-size: xx-small;" maxlength="3" value="#thisQTY#" name="qty#thisItemID#"></td>
                                <td><input type="checkbox" name="moveItem" value="#orderItemID#"></td>
								<td nowrap><a href="catalogEdit.cfm?ID=#catItemID#" target="catEdit">#catnum#</a></td>
								<td nowrap>#Left(label,10)#</td>
								<td nowrap>#Left(artist,20)#</td>
								<td nowrap>#Left(title,20)#</td>
                                <td nowrap><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
                                <td nowrap>#shelfCode#</td>
                                <td nowrap><a href="ordersItemDelete.cfm?ID=#thisItemID#">DEL</a></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
                            <td nowrap>N<cfif albumStatusID NEQ 21><input type="checkbox" name="makeNew" value="#catItemID#"></cfif></td>
							<td nowrap>B<cfif albumStatusID NEQ 23><input type="checkbox" name="makeBackInStock" value="#catItemID#"></cfif></td>
                            <td nowrap>R<cfif albumStatusID NEQ 24><input type="checkbox" name="makeRegular" value="#catItemID#"></cfif></td>
                            <td nowrap>O<cfif albumStatusID NEQ 25 AND albumStatusID NEQ 27><input type="checkbox" name="makeOutOfStock" value="#catItemID#"></cfif></td>
							<td nowrap>I<cfif albumStatusID NEQ 44><input type="checkbox" name="makeInactive" value="#catItemID#"></cfif><cfif albumStatusID GT 24><font color="##FF0000"><b>#albumStatusName#</b></font><cfelse>#albumStatusName#</cfif></td>
                            <td><cfif discogsID GT 0><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">Discogs</a><cfelse>&nbsp;</cfif></td>
                        
					</tr>
			</cfloop>
            
             <tr><td colspan="20"><h1>Polite</h1></td></tr>
                        <cfquery name="thisItems" datasource="#DSN#">
                            SELECT *
                            FROM orderItemsQuery
                            where shelfID<>11 AND orderID=#ID# AND shelfID IN (1059,2127,2131,2136)
                            order by label, catnum
                        </cfquery>
          
							<cfloop query="thisItems">
							<cfif price EQ 0><tr bgcolor="red"><cfelse><tr></cfif>
								<cfset thisItemID=orderItemID>
								<cfset thisItemStatID=adminAvailID>
							<cfif url.revealPics><cfif fullImg NEQ "">
            	<cfset imagefile="items/oI#catItemID#full.jpg">
			<cfelseif jpgLoaded>
				<cfset imagefile="items/oI#catItemID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><img src="../images/#imagefile#" width="75" height="75" border="0" /></a></td></cfif>
                            <td nowrap><cfselect name="stat#thisItemID#" query="iStat" display="name" value="ID" selected="#thisItemStatID#" style="font-size: xx-small;"></cfselect>
							<td nowrap><input type="text" name="price#thisItemID#" value="#DollarFormat(price)#" size="4"  style="font-size: xx-small;"/></td>
                            <cfif url.killInactive AND albumStatusName EQ "Inactive"><cfset thisQTY=0><cfelse><cfset thisQTY=qtyOrdered></cfif>
								<td nowrap><cfinput type="text" size="2" style="padding: 0px; font-size: xx-small;" maxlength="3" value="#thisQTY#" name="qty#thisItemID#"></td>
                                <td><input type="checkbox" name="moveItem" value="#orderItemID#"></td>
								<td nowrap><a href="catalogEdit.cfm?ID=#catItemID#" target="catEdit">#catnum#</a></td>
								<td nowrap>#Left(label,10)#</td>
								<td nowrap>#Left(artist,20)#</td>
								<td nowrap>#Left(title,20)#</td>
                                <td nowrap><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
                                <td nowrap>#shelfCode#</td>
                                <td nowrap><a href="ordersItemDelete.cfm?ID=#thisItemID#">DEL</a></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
                            <td nowrap>N<cfif albumStatusID NEQ 21><input type="checkbox" name="makeNew" value="#catItemID#"></cfif></td>
							<td nowrap>B<cfif albumStatusID NEQ 23><input type="checkbox" name="makeBackInStock" value="#catItemID#"></cfif></td>
                            <td nowrap>R<cfif albumStatusID NEQ 24><input type="checkbox" name="makeRegular" value="#catItemID#"></cfif></td>
                            <td nowrap>O<cfif albumStatusID NEQ 25 AND albumStatusID NEQ 27><input type="checkbox" name="makeOutOfStock" value="#catItemID#"></cfif></td>
							<td nowrap>I<cfif albumStatusID NEQ 44><input type="checkbox" name="makeInactive" value="#catItemID#"></cfif><cfif albumStatusID GT 24><font color="##FF0000"><b>#albumStatusName#</b></font><cfelse>#albumStatusName#</cfif></td>
                            <td><cfif discogsID GT 0><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">Discogs</a><cfelse>&nbsp;</cfif></td>
                        
					</tr>
			</cfloop>
            
             <tr><td colspan="20"><h1>George T</h1></td></tr>
                        <cfquery name="thisItems" datasource="#DSN#">
                            SELECT *
                            FROM orderItemsQuery
                            where shelfID<>11 AND orderID=#ID# AND shelfID IN (2080,1064)
                            order by label, catnum
                        </cfquery>
          
							<cfloop query="thisItems">
							<cfif price EQ 0><tr bgcolor="red"><cfelse><tr></cfif>
								<cfset thisItemID=orderItemID>
								<cfset thisItemStatID=adminAvailID>
							<cfif url.revealPics><cfif fullImg NEQ "">
            	<cfset imagefile="items/oI#catItemID#full.jpg">
			<cfelseif jpgLoaded>
				<cfset imagefile="items/oI#catItemID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><img src="../images/#imagefile#" width="75" height="75" border="0" /></a></td></cfif>
                            <td nowrap><cfselect name="stat#thisItemID#" query="iStat" display="name" value="ID" selected="#thisItemStatID#" style="font-size: xx-small;"></cfselect>
							<td nowrap><input type="text" name="price#thisItemID#" value="#DollarFormat(price)#" size="4"  style="font-size: xx-small;"/></td>
                            <cfif url.killInactive AND albumStatusName EQ "Inactive"><cfset thisQTY=0><cfelse><cfset thisQTY=qtyOrdered></cfif>
								<td nowrap><cfinput type="text" size="2" style="padding: 0px; font-size: xx-small;" maxlength="3" value="#thisQTY#" name="qty#thisItemID#"></td>
                                <td><input type="checkbox" name="moveItem" value="#orderItemID#"></td>
								<td nowrap><a href="catalogEdit.cfm?ID=#catItemID#" target="catEdit">#catnum#</a></td>
								<td nowrap>#Left(label,10)#</td>
								<td nowrap>#Left(artist,20)#</td>
								<td nowrap>#Left(title,20)#</td>
                                <td nowrap><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
                                <td nowrap>#shelfCode#</td>
                                <td nowrap><a href="ordersItemDelete.cfm?ID=#thisItemID#">DEL</a></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
							<td nowrap><cfif ONHAND LT 1><font color="red"><cfelse><font color="##00FF33"></cfif>#NumberFormat(ONHAND,"000")#</font></td>
                            <td nowrap>N<cfif albumStatusID NEQ 21><input type="checkbox" name="makeNew" value="#catItemID#"></cfif></td>
							<td nowrap>B<cfif albumStatusID NEQ 23><input type="checkbox" name="makeBackInStock" value="#catItemID#"></cfif></td>
                            <td nowrap>R<cfif albumStatusID NEQ 24><input type="checkbox" name="makeRegular" value="#catItemID#"></cfif></td>
                            <td nowrap>O<cfif albumStatusID NEQ 25 AND albumStatusID NEQ 27><input type="checkbox" name="makeOutOfStock" value="#catItemID#"></cfif></td>
							<td nowrap>I<cfif albumStatusID NEQ 44><input type="checkbox" name="makeInactive" value="#catItemID#"></cfif><cfif albumStatusID GT 24><font color="##FF0000"><b>#albumStatusName#</b></font><cfelse>#albumStatusName#</cfif></td>
                            <td><cfif discogsID GT 0><a href="http://www.discogs.com/release/#discogsID#" target="discogsFrame">Discogs</a><cfelse>&nbsp;</cfif></td>
                        
					</tr>
			</cfloop>
            
          </table>
          <p><cfinput type="submit" name="fSubmit" value="Save Changes"> <cfinput type="submit" name="fSubmit" value="Save"> <cfinput type="submit" name="fSubmit" value="Shop"> <cfinput type="submit" name="fSubmit" value="Combine"> <cfinput type="submit" name="fSubmit" value="Shelf List"> <cfinput type="submit" name="fSubmit" value="Cost"> <cfinput type="submit" name="fSubmit" value="Store Prices"> <cfinput type="submit" name="fSubmit" value="Reveal Pics">  <!---<cfinput type="submit" name="fSubmit" value="1.25 Markup"> //---><cfinput type="submit" name="fSubmit" value="2 Percent Discount"> <cfinput type="submit" name="fSubmit" value="5 Percent Discount"> <cfinput type="submit" name="fSubmit" value="10 Percent Discount"> <cfinput type="submit" name="fSubmit" value="20 Percent Discount">  <!---<cfinput type="submit" name="fSubmit" value="BS $2.00"> //---><cfinput type="submit" name="fSubmit" value="Reset Prices"> <cfinput type="submit" name="fSubmit" value="Zero Out Prices"></p>
         <table border="0" cellpadding="0"><tr><td valign="top"><p>Shipping Option:<br />
         <select name="shipID" style="font-size: xx-small;">
          	<cfloop query="Application.allShipOptions">
            	<cfif shippingOptionID EQ thisShipID><option value="#shippingOptionID#" selected>#country# - #name#</option><cfelse><option value="#shippingOptionID#">#country# - #name#</option></cfif>
            </cfloop>
          </select>&nbsp;&nbsp;<cfif shipID EQ 64><input type="checkbox" value="1" name="pickupReady" <cfif pickupReady>checked</cfif> />Pickup Ready<cfelse><input type="hidden" name="pickedUp" value="#YesNoFormat(pickupReady)#" /></cfif>
					<input type="hidden" name="pageBack" value="#url.pageBack#" />
			<input type="hidden" name="ID" value="#url.ID#" /></p></td><td colspan="2"><p>#thisCust.custNotes#</p></td></tr>

			<cfif custAddresses.recordCount GT 0>

	<tr>
	<cfset oneIsChecked=false>
	<cfloop query="custAddresses">
		<cfset checkedString="">
		<cfif custAddresses.ID EQ thisOrder.shipAddressID>
			<cfset checkedString="checked">
			<cfset oneIsChecked=true>
		</cfif>
		<cfif NOT oneIsChecked>
			<cfif useFirst OR custAddresses.RecordCount EQ 1>
				<cfset checkedString="checked">
				<cfset oneIsChecked=true>
			</cfif>
		</cfif>
		<td valign="top">
			<table border="0" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
			<tr>
			<td valign="top"><input type="radio" name="shipAddressID" value="#custAddresses.ID#" #checkedString#></td>
			<td><b>#addName#</b><br />
			#firstName# #LastName#<br />
			#add1#<br />
			<cfif add2 NEQ "">#add2#<br /></cfif>
			<cfif add3 NEQ "">#add3#<br /></cfif>
			#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
			#thisCustEmail#<br>
				<cfif country NEQ "United States">#country#</cfif> [ <a href="customerAddressesEdit.cfm?ID=#custAddresses.ID#&retOrderID=#url.ID#">edit</a> ]</li></td>
			</tr>
			</table>		</td>
	    
	</cfloop>	</cfif>
	<td valign="top"><a href="customerAddressesAdd.cfm?retOrderID=#url.ID#&custID=#thisOrder.custID#">Add New Address</a></td>
    <td valign="top"><p align="right">Comments or Special Requests:<br /><textarea name="comments" rows="8" cols="40">#specialInstructions#</textarea></p></td>
	</tr>
    
	</table>


          <cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#userCardID#
</cfquery>
<cfif thisCard.ccNum NEQ ""><cfset procDetails="#thisCard.PayAbbrev# ending in #Right(Decrypt(thisCard.ccNum,encryKey71xu),4)#"><cfelse><cfset procDetails=""></cfif>
<cfset paymType=thisCard.ccTypeID>
          	<cfloop query="thisCard">
<p>#procDetails#<br>
#thisCard.PayAbbrev#<br />
<cfif ccNum NEQ "">Ending in #Right(Decrypt(ccNum,encryKey71xu),4)#<br /></cfif>
#ccFirstName# #ccName# [userCard ID: #thisCard.ID#]<!---<br>
#transactionID#//---></p>
</cfloop>
<!---<h3>#payType#</h3>//--->
          <p><b>Subtotal:</b> #DollarFormat(orderSub)#<br />
                       <b>Tax:</b> #DollarFormat(orderTax)#<br />
                       <b>Shipping:</b> #DollarFormat(orderShipping)#<br />
                       <b>Total:</b> #DollarFormat(orderTotal)#</p>
           

<p><input type="text" name="adminPassword" value="" size="10" /><cfinput type="submit" name="fSubmit" value="Admin Save"></p>
<p>&nbsp;</p>	
	</cfoutput>
<p>Load catalog numbers:<br>
<cftextarea name="loadcatnums" cols="60" rows="5"></cftextarea></p>
</cfform>
<cfoutput><p><a href="ordersEdit.cfm?ID=#url.ID#&killInactive=true">Kill Inactive Items</a><br>
<a href="ordersMakeCash.cfm?ID=#url.ID#">Change to Cash</a></p></cfoutput>
<cfform name="customerForm" action="ordersCustomerChange.cfm" method="post">
Reassign this order to a different customer by typing the new customer's username here:<br />
<cfinput type="text" name="newcustusername" maxlength="50" size="20" required="yes"><cfinput type="submit" name="submit" value="Reassign"><br />NOTE: ALL OTHER CHANGES ON THIS PAGE WILL BE LOST<cfinput type="hidden" name="orderID" value="#url.ID#"> 
</cfform>
<cfoutput><p><a href="ordersMarkFinal.cfm?ID=#thisOrder.ID#">MARK FINAL (don't process quantities)</a></p></cfoutput>
<!---<cfoutput><p align="right"><a href="ordersDT161PriceReset.cfm?ID=#url.ID#">DT161 50 cent markup force</a></p></cfoutput>//--->
<cfinclude template="pageFoot.cfm">
<!---<cfif url.express NEQ "" AND url.start NEQ "161"><cflocation url="ordersUpdateInvoice.cfm?ID=#url.ID#&express=#url.express#"></cfif>//--->