<cfquery name="deleteWishListAll" datasource="#DSN#">
	delete
    from wishList
    where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
</cfquery>
<cflocation url="profileWishlist.cfm">