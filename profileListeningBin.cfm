<cfinclude template="pageHead.cfm">
<style>
	body {background-color:#333333}
</style>
<blockquote>
	<h1 style="margin-top: 12px;"><b><font color="#66FF00">My Account</font></b> Listening Bin</h1>
</blockquote>
<!---<cfquery name="myBin" datasource="#DSN#">
	select *
	from listeningBinQuery
	where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
	order by dateAdded DESC
</cfquery>//--->
<cfquery name="myBin" datasource="#DSN#">
		select listenBin.ID AS binID, catTracks.*, catItemsQuery.*,catItemsQuery.ID As catItemID
		from (listenBin LEFT JOIN catTracks ON listenBin.catItemID = catTracks.ID) LEFT JOIN catItemsQuery ON catTracks.catID = catItemsQuery.ID
		where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
		order by listenBin.dateAdded DESC
	</cfquery>
<cfif myBin.recordCount NEQ 0>
<table border="1" bordercolor="#999999" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" width="100%">
<tr>
	<td style="color:white">ITEM</td>
	<td style="color:white">STATUS</td>
	<td style="color:white">PRICE</td>
    <td style="color:white">ACTIONS</td>
</tr>
<cfoutput query="myBin">
	<cfset instock=false>
	<tr>
    	<td style="color:white"><a href="opussitelayout07main.cfm?sID=#catitemID#">#artist#</a><br />
        <a href="opussitelayout07main.cfm?sID=#catItemID#">#title#</a><br />
        <font style="font-size: xx-small;">#label# [#CATNUM#]</font> <cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
        <td style="color:white"><cfif (albumStatusID LT 25 AND ONHAND GT 0) OR ONSIDE GT 0><cfset instock=true><font color="green">IN STOCK</font><cfelseif albumStatusID EQ 25><font color="yellow">OUT OF STOCK</font><cfelse><font color="red">OUT OF PRINT</font></cfif></td>
        <td style="color:white">#DollarFormat(price)#</td>
        <td style="color:white"><a href="profileListeningBinDelete.cfm?ID=#binID#">REMOVE</a><br /><cfif instock><a href="cartAction.cfm?cAdd=#catItemID#" target="opusviewbins">ADD TO CART</a></cfif></td>
    </tr>
</cfoutput>
</table>
<cfelse><p><b>NOTHING CURRENTLY IN YOUR LISTENING BIN</b></p></cfif>
<blockquote>
	<p><a href="profile.cfm">Back to My Account</a></p>
</blockquote>
<cfinclude template="pageFoot.cfm">