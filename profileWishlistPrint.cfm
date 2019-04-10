<cfparam name="url.custID" default="0">
<style>
	td {font-family:Arial, Helvetica, sans-serif; font-size:10px;}
	h1 {font-family:Arial, Helvetica, sans-serif;}
</style>
<h1>Downtown 304 Wishlist</h1>
<cfif isNumeric(url.custID) AND url.custID NEQ 0>
	<cfset searchCustID=url.custID>
<cfelse>
	<cfset searchCustID=Session.userID>
</cfif>
<cfquery name="myWishlist" datasource="#DSN#">
	select *
	from wishListQuery
	where custID=<cfqueryparam value="#searchCustID#" cfsqltype="integer">
	order by dateAdded DESC
</cfquery>
<cfif myWishlist.recordCount NEQ 0>
<table border="1" bordercolor="black" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" width="100%">
<tr>
	<td style="font-weight:bold;">LABEL</td>
    <td style="font-weight:bold;">CATALOG NUMBER</td>
    <td style="font-weight:bold;">MEDIA</td>
    <td style="font-weight:bold;">ARTIST</td>
    <td style="font-weight:bold;">TITLE</td>
	<td style="font-weight:bold;">STATUS</td>
	<td style="font-weight:bold;">PRICE</td>
</tr>
<cfoutput query="myWishlist">
	<cfif Trim(catnum) NEQ "">
	<cfset instock=false>
	<tr>
        <td>#label#</td>
        <td>#CATNUM#</td>
		<td>#media#<cfif NRECSINSET GT 1>x#NRECSINSET#</cfif></td>
    	<td>#artist#</td>
        <td>#title#</td>
        <td><cfif (albumStatusID LT 25 AND ONHAND GT 0) OR ONSIDE GT 0><cfset instock=true>IN STOCK<cfelseif albumStatusID EQ 25>OUT OF STOCK<cfelse>OUT OF PRINT</cfif></td>
        <td>#DollarFormat(price)#</td>
    </tr>
    </cfif>
</cfoutput>
</table>
<cfelse><p><b>NOTHING CURRENTLY IN YOUR WISHLIST</b></p></cfif>
