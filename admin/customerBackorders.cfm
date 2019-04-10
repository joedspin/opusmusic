<cfparam name="url.custID" default="0">
	

<blockquote>
	<h1 style="margin-top: 12px;"><b>Customer</b> Backorders</h1>
</blockquote>
<cfquery name="myBackorders" datasource="#DSN#">
	select *
	from orderItemsQuery
	where custID=<cfqueryparam value="#url.custID#" cfsqltype="integer"> AND adminAvailID=3 AND statusID<>7
</cfquery>

<table border="1" bordercolor="#999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;">
<tr>
	<td>ITEM</td>
	<td>STATUS</td>
	<td>PRICE</td>
    <td>ACTIONS</td>
</tr>
<cfoutput query="myBackorders">
	<cfset instock=false>
	<tr>
    	<td>#artist#<br />
        #title#<br />
        #label# [#CATNUM#] <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
        <td><cfif (albumStatusID LT 25 AND ONHAND GT 0) OR ONSIDE GT 0><cfset instock=true><font color="green">IN STOCK</font><cfelseif albumStatusID EQ 44><font color="red">DELETED</font><cfelse><font color="yellow">OUT OF STOCK</font></cfif></td>
        <td>#DollarFormat(wholesalePrice)#</td>
        <td><a href="customerBackordersDelete.cfm?ID=#orderItemID#&custID=#url.custID#">REMOVE</a><br /></td>
    </tr>
</cfoutput>
</table>
<cfif myBackorders.recordCount EQ 0><p><b>NOTHING CURRENTLY ON BACKORDER</b></p></cfif>
