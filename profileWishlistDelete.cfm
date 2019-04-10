<cfparam name="url.ID" default="0">
<cfquery name="deleteWishlist" datasource="#DSN#">
	delete
    from wishList
    where wishID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cflocation url="profileWishlist.cfm">