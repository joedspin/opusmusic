<cfset pageName="ORDERS">
<cfparam name="form.search" default="">
<cfparam name="form.sTitle" default="">
<cfparam name="form.sArtist" default="">
<cfparam name="form.sLabel" default="">
<cfparam name="form.sCatnum" default="">
<cfparam name="form.sID" default="">
<cfparam name="Cookie.sTitle" default="">
<cfparam name="Cookie.sArtist" default="">
<cfparam name="Cookie.sLabel" default="">
<cfparam name="Cookie.sCatnum" default="">
<cfparam name="Cookie.sID" default="">
<cfparam name="Cookie.sortOrder" default="DESC">
<cfparam name="Cookie.orderBy" default="ID">
<cfparam name="url.showAll" default="false">
<cfparam name="url.sTitle" default="">
<cfparam name="url.sArtist" default="">
<cfparam name="url.sLabel" default="">
<cfparam name="url.sCatnum" default="">
<cfparam name="url.sID" default="">
<cfparam name="url.so" default="">
<cfparam name="url.ob" default="">
<cfparam name="url.emailsent" default="">
<cfparam name="form.orderID" default="">
<cfparam name="url.orderID" default="#form.orderID#">
<cfparam name="url.itemID" default="0">
<cfparam name="url.addQty" default="0">
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
<cfif url.so NEQ ""><cfset Cookie.sortOrder=url.so></cfif>
<cfif url.ob NEQ ""><cfset Cookie.orderBy=url.ob></cfif>
<cfset urlParam="sArtist=#Cookie.sArtist#&sTitle=#Cookie.sTitle#&sLabel=#Cookie.sLabel#&sCatnum=#Cookie.sCatnum#&sID=#form.sID#">
<cfinclude template="pageHead.cfm">
			<cfoutput><form id="sForm" name="sForm" method="post" action="ordersShop.cfm">
			<input type="hidden" name="orderID" value="#url.orderID#" /></cfoutput>
			<table border="1" cellpadding="2" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse:collapse;">
				<tr bgcolor="##000000">
					<td>CAT#</td>
					<td>LABEL</td>
					<td>ARTIST</td>
					<td>TITLE</td>
					<td>&nbsp;</td>
				</tr>
				<cfoutput>
					<tr>
						<td><input type="text" name="sCatnum" size="12" maxlength="20" value="#Cookie.sCatnum#"></td>
						<td><input type="text" name="sLabel" size="18" maxlength="30" value="#Cookie.sLabel#"></td>
						<td><input type="text" name="sArtist" size="18" maxlength="30" value="#Cookie.sArtist#"></td>
						<td><input type="text" name="sTitle" size="18" maxlength="30" value="#Cookie.sTitle#"></td>
						<td><input type="submit" name="search" value=" SEARCH " /></td>
					</tr>
				</cfoutput>
			</table>
		</form>
<cfquery name="thisOrder" datasource="#DSN#">
	select *, firstName, lastName
	from (orders LEFT JOIN custAccounts ON custAccounts.ID=orders.custID)
	where orders.ID=#url.orderID#
</cfquery>
<cfoutput query="thisOrder">
<h1><a href="ordersAllAvail.cfm?ID=#url.orderID#">#url.orderID#</a><br />
#firstName# #lastName# <br />
<a href="ordersPay.cfm?ID=#url.orderID#&printonly=true">FINISH AND CALCULATE SHIPPING</a></h1>
</cfoutput>
<cfform name="catResultsForm" action="#URLSessionFormat("ordersShopAction.cfm")#" method="post">
<cfif url.showAll><cfset showRows="-1"><cfelse><cfset showRows="100"></cfif>
	<cfif Cookie.sArtist NEQ "" OR Cookie.sLabel NEQ "" OR Cookie.sTitle NEQ "" OR Cookie.sCatnum NEQ "" OR Cookie.sID NEQ ""><cfquery name="catalogFind" datasource="#DSN#" maxrows="#showRows#">
		select catItemsQuery.*, catItems.mp3Loaded, catItems.jpgLoaded
		from catItemsQuery LEFT JOIN catItems ON catItems.ID=catItemsQuery.ID
		where catItemsQuery.artist LIKE <cfqueryparam value="%#Cookie.sArtist#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.label LIKE <cfqueryparam value="%#Cookie.sLabel#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.title LIKE <cfqueryparam value="%#Cookie.sTitle#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.catnum LIKE <cfqueryparam value="%#Cookie.sCatnum#%" cfsqltype="cf_sql_char"> AND
			catItemsQuery.dtID LIKE <cfqueryparam value="%#Cookie.sID#%" cfsqltype="cf_sql_char"> AND catItems.ONSIDE<>999
			order by catItemsQuery.#Cookie.orderBy# #Cookie.sortOrder#
	</cfquery>
    <style>form {margin-top: 0px; margin-bottom: 0px; margin-right: 0px; margin-left: 0px;}
    	.qty {text-align:center;}</style>
    
	<cfoutput>
    <form name="shopForm" action="ordersShopAction.cfm" id="shopForm" method="post">
    <input type="hidden" name="orderID" value="#url.orderID#" />
    <input type="hidden" name="itemID" id="itemID" value="0" />
    <table bgcolor="##CCCCCC" border="1" bordercolor="##999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
		
		<tr valign="middle">
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
            <td align="center" bgcolor="##000000">BGHT</td>
            <td align="center" bgcolor="##000000">SOLD</td>
            <td align="center" bgcolor="##000000">DMND</td>
            <td align="center" bgcolor="##000000">ORDR</td>
		</tr></cfoutput><br />

	<cfoutput query="catalogFind">
	<cfif (ONHAND LT 1 AND ONSIDE LT 1) OR albumStatusID GT 24><cfset oos='OOS'><cfelse><cfset oos=''></cfif>
		<tr bgcolor="##666666">
			<cfquery name="tracks" datasource="#DSN#">
				select *
				from catTracks
				where catID=#catalogFind.ID#
			</cfquery>
			
			<cfif catalogFind.jpgLoaded>
				<cfset imagefile="items/oI#catalogFind.ID#.jpg">
			<cfelseif logofile NEQ "">
				<cfset imagefile="labels/"&logofile>
			<cfelse>
				<cfset imagefile="labels/label_WhiteLabel.gif">
			</cfif>
  			<td align="center" valign="middle"><img src="../images/#imagefile#" width="25" height="25" border="0" /></td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#" align="center"><cfif url.itemID NEQ ID><input type="text" size="3" value="1" name="addQty#ID#" class="qty" /><input type="submit" name="addbutton" value="  ADD  " onclick="this.value='WAIT...';itemID.value='#ID#';" /><cfelse><font color="red">ADDED #url.addQty#</font></cfif><!---<a href="ordersShopAction.cfm?orderID=#url.orderID#&itemID=#ID#">ADD TO ORDER</a><cfif url.itemID EQ ID><br /><font color="red">ADDED</font></cfif>//---></td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#label#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#catnum#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#artist#</td>
			<td bgcolor="##CCCCCC" class="catDisplay#oos#">#title#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#shelfCode#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#ONHAND#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#ONSIDE#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#media#</td>
			<td align="center" bgcolor="##CCCCCC" class="catDisplay#oos#">#DollarFormat(price)#</td>
			<cfquery name="buyhist" dbtype="query">
            	select *
                from Application.buyHistoryAll
                where catItemID=#ID#
            </cfquery>
            <td align="center" bgcolor="##333333"><cfif buyhist.recordCount GT 0>#buyhist.BOUGHT#<cfelse>&nbsp;</cfif></td>
            <cfquery name="sellhist" dbtype="query">
            	select *
                from Application.sellHistoryAll
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
            <td align="center" bgcolor="##333333"><cfif onorder.recordCount GT 0>#onorder.ONORDER#<cfelse>&nbsp;</cfif></td>
		</tr>
        </cfoutput>
        <cfoutput>
	</table>
    </form>
		<cfif url.showAll EQ false>
			<a href="#URLSessionFormat("ordersShop.cfm?showAll=true")#">Show All Results</a>
		<cfelse>
			<a href="#URLSessionFormat("ordersShop.cfm?showAll=false")#">Show Max 100 Results</a>
		</cfif>
	</cfoutput>
</cfif>
</cfform>
		<p>&nbsp; </p>
		<p>&nbsp;</p>
		<cfinclude template="pageFoot.cfm">