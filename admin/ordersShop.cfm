<cfset pageName="ORDERS">
<cfset Cookie.discogsID="">
<cfparam name="form.search" default="">
<cfparam name="form.sTitle" default="">
<cfparam name="form.sArtist" default="">
<cfparam name="form.sLabel" default="">
<cfparam name="form.sCatnum" default="">
<cfparam name="form.sID" default="">
<cfparam name="form.sActive" default="All">
<cfparam name="Cookie.sTitle" default="">
<cfparam name="Cookie.sArtist" default="">
<cfparam name="Cookie.sLabel" default="">
<cfparam name="Cookie.sCatnum" default="">
<cfparam name="Cookie.sID" default="">
<cfparam name="Cookie.sActive" default="All">
<cfparam name="Cookie.sortOrder" default="DESC">
<cfparam name="Cookie.orderBy" default="ID">
<cfparam name="Cookie.priceCheck" default="no">
<cfparam name="url.showAll" default="false">
<cfparam name="url.sTitle" default="">
<cfparam name="url.sArtist" default="">
<cfparam name="url.sLabel" default="">
<cfparam name="url.sCatnum" default="">
<cfparam name="url.sID" default="">
<cfparam name="url.so" default="">
<cfparam name="url.ob" default="">
<cfparam name="url.emailsent" default="">
<cfparam name="url.orderID" default="0">
<cfparam name="form.orderID" default="#url.orderID#">
<cfparam name="url.itemID" default="0">
<cfparam name="form.itemID" default="#url.itemID#">
<cfparam name="url.addQty" default="0">
<cfparam name="url.sortcartorder" default="catnum">
<cfparam name="url.resetPrice" default="">
<cfparam name="form.resetPrice" default="#url.resetPrice#">
<cfif url.sTitle NEQ ""><cfset form.sTitle=url.sTitle></cfif>
<cfif url.sArtist NEQ ""><cfset form.sArtist=url.sArtist></cfif>
<cfif url.sLabel NEQ ""><cfset form.sLabel=url.sLabel></cfif>
<cfif url.sCatnum NEQ ""><cfset form.sCatnum=url.sCatnum></cfif>
<cfif url.sID NEQ ""><cfset form.sID=url.sID></cfif>
<cfif form.sTitle NEQ "" OR form.search NEQ ""><cfset Cookie.sTitle=form.sTitle></cfif>
<cfif form.sArtist NEQ "" OR form.search NEQ ""><cfset Cookie.sArtist=form.sArtist></cfif>
<cfif form.sLabel NEQ "" OR form.search NEQ ""><cfset Cookie.sLabel=form.sLabel></cfif>
<cfif form.sCatnum NEQ "" OR form.search NEQ ""><cfset Cookie.sCatnum=form.sCatnum></cfif>
<cfif form.sID NEQ "" OR form.search NEQ ""><cfset Cookie.sID=form.sID></cfif>
<cfif form.sActive NEQ "" OR form.search NEQ ""><cfset Cookie.sActive=form.sActive></cfif>
<cfif url.so NEQ ""><cfset Cookie.sortOrder=url.so></cfif>
<cfif url.ob NEQ ""><cfset Cookie.orderBy=url.ob></cfif>
<cfset urlParam="sArtist=#Cookie.sArtist#&sTitle=#Cookie.sTitle#&sLabel=#Cookie.sLabel#&sCatnum=#Cookie.sCatnum#&sID=#form.sID#&sActive=#Cookie.sActive#">
<cfif Cookie.sActive EQ "Active"><cfset activeString=" AND (ONHAND>0 OR ONSIDE>0) AND ONSIDE<>999"><cfelse><cfset activeString=""></cfif>
<cfquery name="clearInvoiceFlag" datasource="#DSN#">
	update orders
    set issueResolved=0
    where ID=#form.orderID#
</cfquery>
<cfif form.resetPrice NEQ "">
	<cfquery name="resetItemPrice" datasource="#DSN#">
    	update orderItems
        set price=#form.resetPrice#
        where orderID=#form.orderID# AND catitemID=#form.itemID#
    </cfquery>
</cfif>
<cfinclude template="pageHead.cfm">

			<table border="0" width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
            <tr><td valign="top"><cfoutput><form id="sForm" name="sForm" method="post" action="ordersShop.cfm">
			<input type="hidden" name="orderID" value="#form.orderID#" /></cfoutput>
			
            <table border="1" cellpadding="2" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse:collapse;">
				<tr bgcolor="##000000">
					<td>CAT#</td>
					<td>LABEL</td>
					<td>ARTIST</td>
					<td>TITLE</td>
					<td colspan="2"><cfoutput><a href="#URLSessionFormat("ordersShop.cfm?orderID=#form.orderID#&so=DESC&ob=releaseDate")#">Newest to Oldest</a></cfoutput></td>
                    <td rowspan="2" align="center" valign="middle"><input type="submit" name="search" value=" SEARCH " tabindex="1" style="font-size: xx-small;" /><br /><input type="button" name="clear" value="  CLEAR   " style="font-size: xx-small;"  onclick="clearBoxes();" /></td>
				</tr>
				<cfoutput>
					<tr>
						<!---<td><input type="text" name="sCatnum" size="12" maxlength="20" value="#Cookie.sCatnum#"></td>
						<td><input type="text" name="sLabel" size="18" maxlength="30" value="#Cookie.sLabel#"></td>
						<td><input type="text" name="sArtist" size="18" maxlength="30" value="#Cookie.sArtist#"></td>
						<td><input type="text" name="sTitle" size="18" maxlength="30" value="#Cookie.sTitle#"></td>//--->
                        <td><input type="text" name="sCatnum" size="12" maxlength="20" autofocus></td>
						<td><input type="text" name="sLabel" size="18" maxlength="30"></td>
						<td><input type="text" name="sArtist" size="18" maxlength="30"></td>
						<td><input type="text" name="sTitle" size="18" maxlength="30"></td>
                        <td><input type="radio" name="sActive" value="Active"<cfif Cookie.sActive EQ "Active"> checked</cfif>> Active </td>
                        <td><input type="radio" name="sActive" value="All"<cfif Cookie.sActive EQ "All"> checked</cfif>> All&nbsp;</td>
                    
					</tr>
                    </table>
				</cfoutput>
		</form>
<cfquery name="thisOrder" datasource="#DSN#">
	select *, firstName, lastName, billingName, isStore, issueRaised
	from (orders LEFT JOIN custAccounts ON custAccounts.ID=orders.custID)
	where orders.ID=#form.orderID#
</cfquery>

<!---<cfform name="catResultsForm" action="#URLSessionFormat("ordersShopAction.cfm")#" method="post">//--->
<cfif url.showAll><cfset showRows="-1"><cfelse><cfset showRows="100"></cfif>
	<cfif Cookie.sArtist NEQ "" OR Cookie.sLabel NEQ "" OR Cookie.sTitle NEQ "" OR Cookie.sCatnum NEQ "" OR Cookie.sID NEQ ""><cfquery name="shopCatFind" dbtype="query">
		select *
		from allItems
		where LOWER(artist) LIKE <cfqueryparam value="%#LCase(Cookie.sArtist)#%" cfsqltype="cf_sql_char"> AND
			LOWER(label) LIKE <cfqueryparam value="%#LCase(Cookie.sLabel)#%" cfsqltype="cf_sql_char"> AND
			LOWER(title) LIKE <cfqueryparam value="%#LCase(Cookie.sTitle)#%" cfsqltype="cf_sql_char"> AND
			LOWER(catnum) LIKE <cfqueryparam value="%#LCase(Cookie.sCatnum)#%" cfsqltype="cf_sql_char"> AND
			ONSIDE<>999 #activeString#
			order by #Cookie.orderBy# #Cookie.sortOrder#
	</cfquery>
    <style>form {margin-top: 0px; margin-bottom: 0px; margin-right: 0px; margin-left: 0px;}
    	.qty {text-align:center;}</style>
    
	<cfoutput>
    <form name="shopForm" action="ordersShopAction.cfm" id="shopForm" method="post">
		<p><input type="checkbox" name="priceCheck" value="yes"<cfif cookie.priceCheck EQ "yes"> checked</cfif>> Price Check <cfoutput>#cookie.priceCheck#</cfoutput></p>
	<input type="hidden" name="issueRaised" id="issuedRaised" value="#thisOrder.issueRaised#">
    <input type="hidden" name="isStore" id="isStore" value="#thisOrder.isStore#">
    <input type="hidden" name="isVM" id="isVM" value="#thisOrder.isVinylmania#" />
    <input type="hidden" name="orderID" value="#form.orderID#" />
    <input type="hidden" name="itemID" id="itemID" value="0" />
    <input type="hidden" name="itemIsDT" id="itemIsDT" value="no" />
    <input type="hidden" name="otherSiteID" id="otherSiteID" value="#thisOrder.otherSiteID#">
    <table bgcolor="##CCCCCC" border="1" bordercolor="##999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		
		<tr valign="top">
			<td align="center" bgcolor="##000000" class="catDisplayHead"><img src="../images/email06.gif" width="14" height="11" /></td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">SHOP</td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=label&so=ASC&showAll=#url.showAll#">^</a>&nbsp;LABEL&nbsp;<a href="catalog.cfm?ob=label&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=catnum&so=ASC&showAll=#url.showAll#">^</a>&nbsp;CAT##&nbsp;<a href="catalog.cfm?ob=catnum&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=artist&so=ASC&showAll=#url.showAll#">^</a>&nbsp;ARTIST&nbsp;<a href="catalog.cfm?ob=artist&so=DESC&showAll=#url.showAll#">v</a></td>
			<td bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=title&so=ASC&showAll=#url.showAll#">^</a>&nbsp;TITLE&nbsp;<a href="catalog.cfm?ob=title&so=DESC&showAll=#url.showAll#">v</a></td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">SHELF</td>
			<td colspan="2" align="center" bgcolor="##000000" class="catDisplayHead">ONHAND</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead">MEDIA</td>
			<td align="center" bgcolor="##000000" class="catDisplayHead"><a href="catalog.cfm?#urlParam#&ob=price&so=ASC&showAll=#url.showAll#">^</a>&nbsp;PRICE&nbsp;<a href="catalog.cfm?ob=price&so=DESC&showAll=#url.showAll#">v</a></td>
            <td align="center" bgcolor="##000000" class="catDisplayHead">COST</td>
            <td align="center" bgcolor="##000000" class="catDisplayHead">WHOLESALE</td>
            <td align="center" bgcolor="##000000" class="catDisplayHead">VENDOR ID</td>
            <!---<td align="center" bgcolor="##000000">BGHT</td>
            <td align="center" bgcolor="##000000">SOLD</td>
            <td align="center" bgcolor="##000000">DMND</td>
            <td align="center" bgcolor="##000000">ORDR</td>//--->
		</tr></cfoutput><br />

	<cfoutput query="shopCatFind">
	<cfif (ONHAND LT 1 AND ONSIDE LT 1) OR albumStatusID GT 24><cfset oos='OOS'><cfelse><cfset oos=''></cfif>
		<tr bgcolor="##666666">
			<cfif shopCatFind.fullImg NEQ "">
				<cfset imagefile="items/oI#shopCatFind.ID#full.jpg">
			<cfelseif shopCatFind.jpgLoaded>
				<cfset imagefile="items/oI#shopCatFind.ID#.jpg">
			<cfelseif shopCatFind.logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><a href="catalogEdit.cfm?ID=#ID#" target="catEditFrame"><img src="../images/#imagefile#" width="25" height="25" border="0" /></a></td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#" align="center" nowrap><cfif form.itemID NEQ ID><input type="text" size="3" value="1" name="addQty#ID#" class="qty" onClick="this.value=''; " /><input type="submit" name="addbutton" value="  ADD  " onclick="this.value='WAIT...';itemID.value='#ID#';<cfif left(shelfCode,1) EQ 'D'>itemIsDT.value='yes';</cfif>" /><cfelse><font color="red">ADDED #url.addQty#</font></cfif><!---<a href="ordersShopAction.cfm?orderID=#form.orderID#&itemID=#ID#">ADD TO ORDER</a><cfif form.itemID EQ ID><br /><font color="red">ADDED</font></cfif>//---></td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#label#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#catnum#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#artist#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#title#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#shelfCode#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#ONHAND#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#ONSIDE#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#"><cfif NRECSINSET NEQ 1>#NRECSINSET#x</cfif>#media#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#DollarFormat(price)#</td>
            <td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#DollarFormat(cost)#</td>
            <td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#DollarFormat(wholesalePrice)#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#"><a href="http://10.0.0.113/DT161/eGrid_Master/LindasToolsPlantsByLabel.php?ID=#vendorID#" target="_blank">#vendorID#</a></td>
			<!---<cfquery name="buyhist" dbtype="query">
            	select *
                from buyHistoryAll
                where catItemID=#ID#
            </cfquery>
            <td align="center" bgcolor="##333333"><cfif buyhist.recordCount GT 0>#buyhist.BOUGHT#<cfelse>&nbsp;</cfif></td>
            <cfquery name="sellhist" dbtype="query">
            	select *
                from sellHistoryAll
                where catItemID=#ID#
            </cfquery>
            <td align="center" bgcolor="##333333"><cfif sellhist.recordCount GT 0>#sellhist.SOLD#<cfelse>&nbsp;</cfif></td>
            <cfquery name="demand" dbtype="query">
            	select *
                from Application.demandAll
                where catItemID=#ID#
            </cfquery>
            <td align="center" bgcolor="##333333"><cfif demand.recordCount GT 0>#demand.INCART#<cfelse>&nbsp;</cfif></td>
			<cfquery name="onorder" dbtype="query">
            	select *
                from Application.onOrderAll
                where catItemID=#ID#
            </cfquery>
            <td align="center" bgcolor="##333333"><cfif onorder.recordCount GT 0>#onorder.ONORDER#<cfelse>&nbsp;</cfif></td>//--->
		</tr>
        </cfoutput>
        
	</table>
    </form></cfif>
			</td><td width="15">&nbsp;</td>
            <td valign="top">
            <cfoutput query="thisOrder">
             
<h1>#form.orderID# <!---<cfif thisOrder.isVinylmania>[Vinylmania Order]<cfelse>[<a href="ordersMakeVM.cfm?orderID=#form.orderID#">Convert to Vinylmania</a>]</cfif>//--->&nbsp&nbsp&nbsp<a href="ordersAllAvail.cfm?ID=#form.orderID#">161</a><br />
<cfif isStore>#billingName#<cfelse>#firstName# #lastName#</cfif>
<!---<cfif thisOrder.custID EQ 2126><a href="ordersAllAvail.cfm?ID=#form.orderID#&express=express&start=161">Express Checkout</a><cfelse><cfif thisOrder.isVinylmania><a href="ordersAllAvail.cfm?ID=#form.orderID#&express=vinylmania">Vinylmania Checkout</a><cfelse><a href="ordersAllAvail.cfm?ID=#form.orderID#&express=express">Express Checkout</a></cfif></cfif>//---></h1> 
</cfoutput>
            <cfset pageSub=0>
            <cfset itemCount=0>
            <!---select orderItems.*, catItems.catnum
                from (orderItems LEFT JOIN catItems ON orderItems.catItemID=catItems.ID)
                where orderID=#form.orderID#
                order by catItems.catnum//--->
            
            <cfquery name="thisOrderItems" datasource="#DSN#">
            	select *
                from orderItemsQuery
                where orderID=#form.orderID#
                order by orderItemID
            </cfquery>
            <table border="1" bordercolor="#000000" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" width="320" align="right">
            <cfoutput>
            <tr bgcolor="##333333">
                	<td colspan="3" align="left"><a href="orders.cfm?flagToPrint=#form.orderID#">Ready to Print</a></td>
                    <td colspan="3" align="right"><a href="ordersEdit.cfm?ID=#form.orderID#">Edit Order</a></td>
                </tr>
				</cfoutput>
            	<cfif thisOrderItems.recordCount GT 0>
				<cfoutput query="thisOrderItems">
                	<!---<cfquery name="thisCartRow" dbtype="query">
                    	select *
                        from allItems
                        where ID=#catItemID#
                    </cfquery>//--->
                    <cfset rowQty=qtyOrdered>
                    <cfset itemCount=itemCount+rowQty>
                    <!---<cfloop query="thisCartRow">//--->
	                <tr bgcolor="white">
                    	<td valign="top" style="color:black; font-size: xx-small;" align="right">#rowQty#</td>
                        <td valign="top" style="color:black; font-size: xx-small;">#catnum#</td>
                        <td valign="top" style="color:black; font-size: xx-small;">#Artist#</td>
                        <td valign="top" style="color:black; font-size: xx-small;">#Title#</td>
                        <td valign="top" style="color:black; font-size: xx-small;"><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
                        <td valign="top" style="color:black; font-size: xx-small;" align="right">
                        <cfif priceOverride NEQ 0><cfset thisPrice=priceOverride><cfelse><cfset thisPrice=price></cfif>#DollarFormat(thisPrice)#</td>
                        </tr>
                      <!---</cfloop>//--->
                      <cfset pageSub=pageSub+(rowQty*thisPrice)>
                </cfoutput>
                <cfelse>
                <tr bgcolor="white">
                	<td colspan="6" align="center" nowrap style="color:black; font-size: xx-small;">--NOTHING ON ORDER YET--</td>
                </tr>
                </cfif>
                <cfoutput>
                    <tr bgcolor="white">
                        <td nowrap style="color:black; font-size: xx-small;"><b>#itemCount#</b></td>
                        <td colspan="4" nowrap style="color:black; font-size: xx-small;">&nbsp;</td>
                        <td nowrap style="color:black; font-size: xx-small;"><b>#DollarFormat(pageSub)#</b></td>
                    </tr>
                </cfoutput>
            </table>
          
		
</td>
<!---</cfform>//--->
            </tr></table>
            <cfoutput>
		<cfif url.showAll EQ false>
			<a href="#URLSessionFormat("ordersShop.cfm?showAll=true")#">Show All Results</a>
		<cfelse>
			<a href="#URLSessionFormat("ordersShop.cfm?showAll=false")#">Show Max 100 Results</a>
		</cfif>
	</cfoutput>
		<p>&nbsp; </p>
		<p>&nbsp;</p>
		<cfinclude template="pageFoot.cfm">