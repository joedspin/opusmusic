<cfinclude template="pageHead.cfm">
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">My Account</font></b> Backorders</h1>
</blockquote>
<cfquery name="myBackorders" datasource="#DSN#">
	select *
	from orderItemsQuery
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer"> AND adminAvailID=3 AND statusID<>7
</cfquery>

<table border="1" bordercolor="#999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" width="100%">
<tr>
	<td style="color:white">ITEM</td>
	<td style="color:white">STATUS</td>
	<td style="color:white">PRICE</td>
    <td style="color:white">ACTIONS</td>
</tr>
<cfoutput query="myBackorders">
	<cfset instock=false>
	<tr>
    	<td style="color:white"><a href="opussitelayout07main.cfm?sID=#catitemID#">#artist#</a><br />
        <a href="opussitelayout07main.cfm?sID=#catitemID#">#title#</a><br />
        <font style="font-size: xx-small;">#label# [#CATNUM#]</font> <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
        <td style="color:white"><cfif (albumStatusID LT 25 AND ONHAND GT 0) OR ONSIDE GT 0><cfset instock=true><font color="green">IN STOCK</font><cfelseif albumStatusID EQ 44><font color="red">DELETED</font><cfelse><font color="yellow">OUT OF STOCK</font></cfif></td>
        <td style="color:white">#DollarFormat(price)#</td>
        <td style="color:white"><a href="profileBackordersDelete.cfm?ID=#orderItemID#">REMOVE</a><br /><cfif instock><a href="cartAction.cfm?bAdd=#orderItemID#" target="opusviewbins">MOVE TO CART</a></cfif></td>
    </tr>
</cfoutput>
</table>
<cfif myBackorders.recordCount EQ 0><p><b>NOTHING CURRENTLY ON BACKORDER</b></p></cfif>
<blockquote>
	<p><a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">