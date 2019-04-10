
	<cfquery name="shippedItems" datasource="#DSN#">
		SELECT *
		FROM orderItemsQuery
		where orderID=#url.ID# AND (adminAvailID=6 OR (statusID<6 AND (adminAvailID=4 OR adminAvailID=5)))
	</cfquery>
	<!---<cfquery name="notAvailItems" datasource="#DSN#">
		select *
		from orderItemsQuery
		where orderID=#url.ID# AND adminAvailID=1
	</cfquery>//--->
	<cfquery name="backorderedItems" datasource="#DSN#">
		select *
		from orderItemsQuery
		where orderID=#url.ID# AND adminAvailID=3
	</cfquery>
	<cfquery name="thisUpdatedOrder" datasource="#DSN#">
		select *
		from orders
		where ID=#url.ID#
	</cfquery>
<!---<cfif (thisShipOption.ID EQ 64 AND thisUpdatedOrder.statusID NEQ 6) OR thisShipOption.ID NEQ 64>//--->

		<cfif thisShipOption.ID EQ 64 AND thisUpdatedOrder.pickupReady AND (thisUpdatedOrder.statusID EQ 3 OR thisUpdatedOrder.statusID EQ 4)>
            <cfset orderMSG="READY">
            <cfset orderStat="Your order is ready for pick up. Call 718-501-4320 or email order@downtown304.com to arrange a time. Our core office hours are Monday through Friday noon to 6pm.">
            <cfset orderAvail="These items were available and are ready to pick up. Call 718-501-4320 or email order@downtown304.com to arrange a time. Our core office hours are Monday through Friday noon to 6pm.">
        <cfelseif thisShipOption.ID EQ 64 AND thisUpdatedOrder.pickupReady AND thisUpdatedOrder.statusID EQ 6>
            <cfset orderMSG="COMPLETE">
            <cfset orderStat="Your order is ready for pick up">
            <cfset orderAvail="These items were available and are ready to pick up. Call 718-501-4320 or email order@downtown304.com to arrange a time. Our core office hours are Monday through Friday noon to 6pm.">
        <cfelseif thisShipOption.ID EQ 64 AND thisUpdatedOrder.statusID EQ 6>
            <cfset orderMSG="COMPLETE">
            <cfset orderStat="Your order has been picked up">
            <cfset orderAvail="These items were available and were picked up">
        <cfelseif thisShipOption.ID EQ 71>
            <cfset orderMSG="REFUND">
            <cfset orderStat="Your refund has been processed">
            <cfset orderAvail="You have been refunded for the following items">
        <cfelseif url.notice EQ "moneyorder">
			<cfset orderMSG="MONEY ORDER">
            <cfset orderStat="Your order is ready to ship">
            <cfset orderAvail="The following items are available and your total due is shown below">
		<cfelse>
            <cfset orderMSG="SHIPPED">
            <cfset orderStat="Your order has shipped">
            <cfset orderAvail="These items were available and have shipped">
        </cfif>
	<cfmail to="#thisCust.email#" from="order@downtown304.com" subject="Downtown 304 Order #NumberFormat(url.ID,"00000")# #orderMSG#" type="html"><html><head>
	<style>
	<!--
	body, td {font-family:Arial, Helvetica, sans-serif; font-size: x-small;}
	td {padding: 0px;}
	//-->
	</style></head>
	<body>
	<p><b>#orderStat#<br />
	#DateFormat(varDateODBC,"mm/dd/yyyy")#</b></p>
	<p>-------------------------------------------------</p>
	<h1>Order Summary</h1>
	<p><b>#orderAvail#:</b></p>
	<table border="1" style="border-collapse:collapse;" width="100%"><br />
	<tr bgcolor="##CCCCCC">
		<td align="center">QTY</td>
		<td>CATNUM</td>
		<td>LABEL</td>
		<td>ARTIST</td>
		<td>TITLE</td>
		<td>MEDIA</td>
		<cfif otherSiteID EQ 0><td align="center">PRICE</td></cfif>
		<td align="center">SHELF</td>
	</tr>
	<cfloop query="shippedItems">
	<tr>
			<td align="center">#qtyOrdered#</td>
			<td valign="top">#catnum#</td>
			<td valign="top">#label#</td>
			<td valign="top">#artist#</td>
			<td valign="top">#title#</td>
			<td valign="top"><cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
			<cfif otherSiteID EQ 0><td valign="top" align="right">#DollarFormat(price)#</td></cfif>
			<td valign="top" align="center">#shelfCode#</td>
		</tr>
	</cfloop>
	</table>
	<cfif otherSiteID EQ 0><p><b>Order Sub-Total: #DollarFormat(thisUpdatedOrder.orderSub)#</b></p></cfif>
		<p><b>Shipping Method:</b><br />
		<cfloop query="thisShipOption">
			#name# <cfif thisShipOption.ID NEQ 71>(#shippingTime#) </cfif><cfif thisShipOption.ID NEQ 64>#DollarFormat(thisUpdatedOrder.orderShipping)#</cfif>
		</cfloop></p>
		<cfif otherSiteID EQ 0><cfif thisUpdatedOrder.orderTax GT 0><p><b>NY Sales Tax (8.875%):</b> #DollarFormat(thisUpdatedOrder.orderTax)#</p></cfif></cfif>
		<cfif otherSiteID EQ 0><p><b>Order Total: </b>#DollarFormat(thisUpdatedOrder.orderTotal)#</p></cfif>
	<!---<cfif notAvailItems.recordCount GT 0><p><b>The following items are no longer available (you have not been charged for these items):</b><br />
	<cfloop query="notAvailItems">
		#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#]<br />
	</cfloop></p></cfif>//--->
	<cfif backorderedItems.recordCount GT 0><p><b>The following items are backordered (you have not been charged for these items). We will notify you when they are available again:</b><br />
	<cfloop query="backorderedItems">
		#qtyOrdered# x #artist# #title# #label# [#catnum#][<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#][#shelfCode#]<br />
	</cfloop></p></cfif>
	<cfif thisShipOption.ID NEQ 64>
		<p><b>Ship to:</b><br />
			<cfloop query="thisShipping">
			#firstName# #LastName#<br />
			#add1#<br />
			<cfif add2 NEQ "">#add2#<br /></cfif>
			<cfif add3 NEQ "">#add3#<br /></cfif>
			#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
			#country# </p>
		</cfloop>
		<p><b>Bill to:</b><br />
			<cfloop query="thisBilling">
			#firstName# #LastName#<br />
			#add1#<br />
			<cfif add2 NEQ "">#add2#<br /></cfif>
			<cfif add3 NEQ "">#add3#<br /></cfif>
			#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
			#country# </p>
		</cfloop><br />
		<p><b>Payment: </b><br />
			<cfif thisCard.RecordCount GT 0>
				<cfloop query="thisCard">
					#PayAbbrev# ending in #Right(ccNum,4)#
				</cfloop>
			<cfelseif thisUpdatedOrder.paymentTypeID EQ 6>
				Money Order<br />
			</cfif>
		</p>
        <cfelse>
        	<cfloop query="thisShipping">
            #firstName# #LastName# (#thisCust.email#)
            </cfloop>
		</cfif>
		</body>
		</html>
	</cfmail>
<!---</cfif>//--->