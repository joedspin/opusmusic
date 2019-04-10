<cfparam name="url.custID" default="0">
<cfinclude template="pageHead.cfm">
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">My Account</font></b> Wishlist</h1>
</blockquote>
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
<table border="1" bordercolor="#999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" width="100%">
<tr>
	<td style="color:white">ITEM</td>
	<td style="color:white">STATUS</td>
	<td style="color:white">PRICE</td>
    <td style="color:white">ACTIONS</td>
</tr>
<cfoutput query="myWishlist">	
	<cfif Trim(catnum) NEQ "">
	<cfset instock=false>
	<tr>
    	<td style="color:white"><a href="opussitelayout07main.cfm?sID=#catitemID#">#artist#</a><br />
        <a href="opussitelayout07main.cfm?sID=#catitemID#">#title#</a><br />
        <font style="font-size: xx-small;">#label# [#CATNUM#]</font> <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
        <td style="color:white"><cfif (albumStatusID LT 25 AND ONHAND GT 0) OR ONSIDE GT 0><cfset instock=true><font color="green">IN STOCK</font><cfelseif albumStatusID EQ 25><font color="yellow">OUT OF STOCK</font><cfelse><font color="red">OUT OF PRINT</font></cfif></td>
        <td style="color:white">#DollarFormat(price)#</td>
        <td style="color:white"><a href="profileWishlistDelete.cfm?ID=#wishID#">REMOVE</a><br /><cfif instock><a href="cartAction.cfm?cAdd=#catItemID#" target="opusviewbins">ADD TO CART</a></cfif></td>
    </tr>
    </cfif>
</cfoutput>
</table>
<cfelse><p><b>NOTHING CURRENTLY IN YOUR WISHLIST</b></p></cfif>
<blockquote>
	<p><cfoutput><a href="profileWishListPrint.cfm?custID=#searchCustID#" target="_blank">Printable List / Excel compatible</a><br /></cfoutput>
    <a href="profileWishListWipe.cfm">Clear My Wishlist</a><br />
    <a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">