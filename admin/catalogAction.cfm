<cfparam name="form.save" default="">
<cfparam name="form.activeIDs" default="">
<cfparam name="form.specIDs" default="">
<cfparam name="form.allIDs" default="">
<cfparam name="form.itemID" default="0">
<cfparam name="form.rcvbutton" default="">
<cfparam name="form.vendorID" default="0">
<cfif form.rcvbutton NEQ "">
<cfquery name="receiveItem" datasource="#DSN#">
	select *
    from catItemsQuery
    where ID=#form.itemID#
</cfquery>
<cfif Evaluate('form.rcvQty'&form.itemID) EQ ""><cfset rcvQty=0><cfelse><cfset rcvQty=Evaluate('form.rcvQty'&form.itemID)></cfif>
	<!---<cfif form.addONHANDshelfID EQ 0><p><font color="red">ERROR!!!!!</font> You did not specify a Vendor for catalog received. Click back and try again.</p><cfabort></cfif>//--->
    <cfquery name="auditONHAND" datasource="#DSN#">
    	insert into catRcvd (catItemID, dateReceived, qtyRcvd, rcvdShelfID, rcvdUserID)
        values (#form.itemID#,<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,#rcvQty#,#form.vendorID#,#Session.userID#)
    </cfquery>
    <!---<cfif form.ONORDER NEQ 0 AND form.addONHAND GT 0 AND addONHANDshelfID NEQ 24>
		<cfset thisONORDER=thisONORDER-form.addONHAND>
    </cfif>//--->
    <cfquery name="purchOrderEntries" datasource="#DSN#">
    	select *
        from purchaseOrderDetails
        where catItemID=#form.itemID# AND qtyRequested > qtyReceived AND completed=0 AND vendorID=#form.vendorID# order by dateRequested DESC
    </cfquery>
    <cfset todayRQty=rcvQty>
    <cfloop query="purchOrderEntries">
    	<cfset thisPOID=POItem_ID>
    	<cfset thisOnOrderQTY=qtyRequested-qtyReceived>
        <cfif todayRQty LT thisOnOrderQTY AND todayRQty GT 0>
            <cfquery name="adjustPO" datasource="#DSN#">
            	update purchaseOrderDetails
                set qtyReceived=#qtyReceived+todayRQty#
                where POItem_ID=#thisPOID#
            </cfquery>
            <cfset todayRQty=0>
        <cfelseif todayRQty EQ thisOnOrderQTY AND todayRQty GT 0>
            <cfquery name="adjustPO" datasource="#DSN#">
            	update purchaseOrderDetails
                set qtyReceived=qtyRequested, completed=1, dateReceived=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
                where POItem_ID=#thisPOID#
            </cfquery>
            <cfset todayRQty=0>
		<cfelseif todayRQty GT 0>
            <cfquery name="adjustPO" datasource="#DSN#">
            	update purchaseOrderDetails
                set qtyReceived=qtyRequested, completed=1, dateReceived=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">
                where POItem_ID=#thisPOID#
            </cfquery>
			<cfset todayRQty=todayRQty-thisOnOrderQTY>
        </cfif>
    </cfloop>
    <cfif receiveItem.albumStatusID EQ 44>
    	<cfset thisAlbumStatusID=21>
        <cfset thisReleaseDate=#varDateODBC#>
        <cfset thisDateUpdated=#varDateODBC#>
     <cfelseif (receiveItem.albumStatusID EQ 25 OR receiveItem.albumStatusID EQ 27) AND rcvQty GT 0>
     	<cfset thisAlbumStatusID=23>
        <cfset thisDateUpdated=#varDateODBC#>
        <cfset thisReleaseDate=receiveItem.releaseDate>
     <cfelse>
     	<cfset thisAlbumStatusID=receiveItem.albumStatusID>
     	<cfset thisDateUpdated=#varDateODBC#>
        <cfset thisReleaseDate=receiveItem.releaseDate>
     </cfif>
    <cfquery name="updateONHAND" datasource="#DSN#">
    	update catItems
        set ONHAND=ONHAND+<cfqueryparam value="#rcvQty#" cfsqltype="cf_sql_char">,
        	albumStatusID=#thisAlbumStatusID#,
            releaseDate=<cfqueryparam value="#thisReleaseDate#" cfsqltype="cf_sql_date">,
            DTdateUpdated=<cfqueryparam value="#thisDateUpdated#" cfsqltype="cf_sql_date">
       	where ID=#form.itemID#
    </cfquery>
<cfquery name="backorders" datasource="#DSN#">
        select *
        from orderItemsQuery
        where catItemID=<cfqueryparam value="#form.itemID#" cfsqltype="cf_sql_char"> AND adminAvailID=3 AND statusID<>7 AND backorderNoticeSent=0
    </cfquery>
    <cfif backorders.recordCount GT 0>
        <cfloop query="backorders">
        <cfquery name="customer" datasource="#DSN#">
            select *
            from custAccounts
            where ID=#custID#
        </cfquery>
        <cfset itemDescrip="#receiveItem.artist# #receiveItem.title# (#receiveItem.NRECSINSET#x#receiveItem.media#) [#receiveItem.label# - #receiveItem.catnum#]">
            <cfmail query="customer" to="#email#" from="info@downtown304.com" bcc="order@downtown304.com" subject="BACKORDERED ITEMS Back In Stock" type="html">
    <p>#firstName#,</p>
    <p>This item, which you have on backorder, is now available again:</p>
    <p>#itemDescrip#</p>
    <p>You can manage your backorders in the "My Account" section after you login on our website. Move this item to your cart, or REMOVE it from backorder there.</p>
    <p><a href="http://www.downtown304.com">Downtown304.com</a></p>
            </cfmail>
            </cfloop>
        </cfif>
        <cfif receiveItem.cost EQ 0 OR receiveItem.price EQ 0>
        	<cfset pageName="CATALOG">
        	<cfinclude template="pageHead.cfm">
            <cfoutput><h1>#receiveItem.Artist# - #receiveItem.title#</h1>
            <h2>#receiveItem.label# [#receiveItem.catnum#] (<cfif receiveItem.NRECSINSET GT 1>#receiveItem.NRECSINSET#x</cfif>#receiveItem.media#</h2>
            <form name="getPrice" action="catalogPriceAction.cfm" method="post">
            	<h2>COST: <input type="text" name="cost" value="#NumberFormat(receiveItem.cost,"0.00")#">&nbsp;&nbsp;&nbsp;&nbsp;
                PRICE: <input type="text" name="price" value="#NumberFormat(receiveItem.price,"0.00")#">&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="submit" value="Save" name="submit"></h2>
                <input type="hidden" name="ID" value="#form.itemID#" />
            </form></cfoutput>
            <cfinclude template="pageFoot.cfm"><cfabort>
        </cfif>
</cfif>
<cfif form.save NEQ "">
	<cfset allIDsArray=ListToArray(form.allIDs)>
	<cfloop from="1" to="#ArrayLen(allIDsArray)#" index="x">
		<cfif ListContains(activeIDs,allIDsArray[x])>
			<cfquery name="setActiveOn" datasource="#DSN#">
				update catItems
				set noReorder=1
				where ID=#allIDsArray[x]#
			</cfquery>
		<cfelse>
			<cfquery name="setActiveOff" datasource="#DSN#">
				update catItems
				set noReorder=0
				where ID=#allIDsArray[x]#
			</cfquery>
		</cfif>
	</cfloop>cost=dtBuy+1,
                        price=dtBuy+2
    <cfloop from="1" to="#ArrayLen(allIDsArray)#" index="x">
		<cfif ListContains(specIDs,allIDsArray[x])>
                <cfquery name="setSpecialOn" datasource="#DSN#">
                    update catItems
                    set specialItem=1,
                    	dtDateUpdated=<cfqueryparam value="#varDateODBC#" cfsqltype="cf_sql_date">,
                        albumStatusID=23
                        
                    where ID=#allIDsArray[x]#
                </cfquery>
		<cfelse>
			<cfquery name="setSpecialOff" datasource="#DSN#">
				update catItems
				set specialItem=0, cost=dtBuy, price=dtBuy*1.5, dtDateUpdated=releaseDate, albumStatusID=24
				where ID=#allIDsArray[x]# AND dtBuy>0
			</cfquery>
		</cfif>
	</cfloop>
</cfif>
<cflocation url="catalog.cfm">