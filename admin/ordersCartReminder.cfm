<cfsetting requesttimeout="60000" enablecfoutputonly="no">
<cfquery name="ordersWaiting" datasource="#DSN#">
	select *
	from orders
	where statusID=1 AND DateDiff(day,dateUpdated,#varDateODBC#)>45 AND DateDiff(day,dateStarted,#varDateODBC#)<180
	order by dateStarted DESC
</cfquery>
<cfquery name="orderItemsQueryQ" datasource="#DSN#">
	select orderItemID, orderID, catnum, artist, title, label, albumStatusID, albumStatusName, ONHAND, ONSIDE, adminAvailID, qtyOrdered, shelfCode, media, NRECSINSET
	from orderItemsQuery
	where adminAvailID=2 AND statusID=1 AND ONHAND>0 AND albumStatusID<25
</cfquery>
<cfquery name="custAccountsQ" datasource="#DSN#">
	select *
	from custAccounts
</cfquery>
<cfquery name="custAddressesQueryQ" datasource="#DSN#">
	select *
	from custAddressesQuery
</cfquery>
<!---<p>Currently displaying <cfif url.maxrows EQ -1>ALL open carts<cfelse><cfoutput>#url.maxrows# most recently started carts</cfoutput></cfif>
<cfif url.maxrows NEQ 10><br /><a href="ordersOpenCarts.cfm?maxrows=10">Click here to show 10 open carts</a></cfif>
<cfif url.maxrows NEQ 20><br /><a href="ordersOpenCarts.cfm?maxrows=20">Click here to show 20 open carts</a></cfif>
<cfif url.maxrows NEQ 30><br /><a href="ordersOpenCarts.cfm?maxrows=30">Click here to show 30 open carts</a></cfif>
<cfif url.maxrows NEQ 0><br /><a href="ordersOpenCarts.cfm?maxrows=-1">Click here to show ALL open carts</a></cfif></p>//--->
		<cfloop query="ordersWaiting">
			<cfquery name="thisItems" dbtype="query">
				SELECT *
				FROM orderItemsQueryQ
				where orderID=#ID#
			</cfquery>
			<cfif thisItems.recordCount GT 0>
				<cfquery name="thisCust" dbType="query">
					select *
					from custAccountsQ
					where ID=#custID#
				</cfquery>
				<cfquery name="thisShipAddress" dbtype="query">
					select *
					from custAddressesQueryQ
					where ID=#shipAddressID#
				</cfquery>
<cfoutput><p>#thisCust.email#<br>
<cfloop query="thisItems">#qtyOrdered# X #artist# / #title# [#label#] [#catnum##shelfCode#] <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#<br></cfloop></p></cfoutput>
<cfif thisCust.email NEQ "">
<cfmail to="#thisCust.email#" bcc="joe@joedespinosa.com, info@downtown304.com" from="order@downtown304.com" subject="Your open order on Downtown 304 - 15% Off!" type="html">
<style>body {font-family: Arial, Helvetica, sans-serif; font-size: x-small;} td {font-family: Arial, Helvetica, sans-serif; font-size: xx-small;}</style>
<cfif thisCust.firstName NEQ ""><p>Hi #thisCust.firstName#,</p></cfif>
<p>I'd like to offer you 15% off the order you started at www.downtown304.com. You can remove some or add some more, the discount will apply to your whole order.</p>
<p>Just <a href="http://www.downtown304.com">visit the site</a> and use the promo code GIFT15JOE during checkout to receive the discount.</p>
<p>This discount code expires after October 15, 2016, so place your order soon to take advantage of the offer.</p>
<p>Here's what's currently in your shopping cart:</p>

			<table cellpadding="2" border="1" style="border-collapse:collapse; margin-top: 15px;" width="100%">
				<cfloop query="thisItems">
				<td valign="top" nowrap>#qtyOrdered# X #artist# / #title# [#label#] [#catnum##shelfCode#] <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#</td>
		</tr></cfloop>				
		</table>
<p>Sincerely,</p>
<p>Joe D'Espinosa<br>
Downtown 304<br>
www.downtown304.com</p>
</cfmail></cfif>	</cfif>

		</cfloop>