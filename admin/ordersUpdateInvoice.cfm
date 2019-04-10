<cfparam name="url.undo" default="false">
<cfparam name="url.pageBack" default="orders.cfm">
<cfparam name="url.express" default="">
<cfparam name="url.ID" default="0">
<cfparam name="url.promo" default="no">
<html>
<head>

<SCRIPT language="JavaScript">
function submitform()
{
  document.updateInvoice.submit();
}
</SCRIPT> 
<title>Downtown 304 Invoicing</title>
</head>
<body <cfif url.express NEQ "">onload="javascript: submitform()"</cfif>>
<cfquery name="thisOrder" datasource="#DSN#">
	select *
	from orders
	where ID=#url.ID#
</cfquery>
<style type="text/css">
<!--
<cfif url.undo>
body, td {color: red; font-family:Arial, Helvetica, sans-serif;}
</cfif>
.style1 {
	font-size: x-small;
	font-family: Arial, Helvetica, sans-serif;
}
td {
	font-size: x-small;
	font-family: Arial, Helvetica, sans-serif;
}
.style2 {
	font-size: small;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style4 {
	font-size: x-small;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
td {vertical-align:top;}
input {font-size: xx-small; text-align: center;}
-->
</style>
<cfset nothingToInvoice=true>
<cfloop query="thisOrder">
<cfif custID EQ 2126><cflocation url="ordersUpdateInvoiceComplete.cfm?ID=#url.ID#&express=#url.express#"><cfset formaction="http://10.0.0.113/DT161/eGrid_Master/opusToolsUpdateCatalog.php"><cfelseif isVinylmania><cfset formaction="http://10.0.0.113/DT161/eGrid_Master/opusToolsUpdateVMInvoice.php"><cfelse><cfset formaction="http://10.0.0.113/DT161/eGrid_Master/opusToolsUpdateInvoice.php"></cfif>
<cfquery name="checkPending" datasource="#DSN#">
	select *
    from orderItemsQuery
    where orderID=#ID# and adminAvailID=2
</cfquery>
<cfif checkPending.recordCount GT 0>
	<p><font color="red">ALERT!!!</font><br />
    This order still has items at PENDING status. <cfoutput><a href="ordersEdit.cfm?ID=#ID#">Click here to EDIT the order.</a></cfoutput></p>
    <cfoutput query="checkPending">
#catnum# #label# #artist# #title#<br>
</cfoutput><cfabort>
</cfif>

<cfquery name="thisItems" datasource="#DSN#">
 SELECT *
	FROM orderItemsQuery
	where orderID=#ID# AND adminAvailID=4 AND shelfID=11 AND dtID<>0 AND dtID Is Not Null 
</cfquery>
<h1>Downtown 161 Invoice</h1>
<cfoutput><form name="updateInvoice" action="#formaction#" method="post"></cfoutput>
	    <span class="style2">
	    <cfset iAdd=0>
	    <cfif thisItems.recordCount NEQ 0>
        </cfif>
	    </span>
        <cfset dt161total=0>
<table border="1" cellpadding="2" cellspacing="0" style="border-collapse:collapse;" width="650">
    <cfif thisItems.recordCount NEQ 0><tr><td colspan="5"><p class="style2"><b><cfif url.undo>Remove from<cfelse>Add to</cfif> Invoice</b></p></td></tr>
		<cfset nothingToInvoice=false>
		
			<cfoutput query="thisItems">
				<cfset iAdd=iAdd+1>
				<tr>
					<td align="center"><input type="text" name="qtyA#iAdd#" size="2" maxlength="3" value="<cfif url.undo>-</cfif>#qtyOrdered#" /></td>
				  <td><input type="hidden" name="idA#iAdd#" value="#dtID#" />
                  		<input type="hidden" name="oidA#iAdd#" value="#orderItemID#" />
                        <cfif price EQ 0><cfset thisCost=0><cfelseif thisOrder.isVinylmania><cfset thisCost=buy><cfelse><cfset thisCost=cost></cfif>
					  <input type="hidden" name="priceA#iAdd#" value="#NumberFormat(thisCost,"0.00")#" />
					  <span class="style1">#catnum#</span></td>
                      
                  <td>#label#</td>
                  <td>#artist#</td>
                  <td>#title#</td>
                  <td>#DollarFormat(price)#</td>
				</tr>
                <cfset dt161total=dt161total+(qtyOrdered*price)>
			</cfoutput>
	</cfif>
	<cfoutput><input type="hidden" name="iAdd" value="#iAdd#" /></cfoutput>
<cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#ID# AND adminAvailID=5 AND left(shelfCode,1)='D' AND dtID<>0 AND dtID Is Not Null
</cfquery>
	<cfset iMove=0>
	<cfif thisItems.recordCount NEQ 0>
	<tr><td colspan="5"><p class="style2"><cfif url.undo>Remove from<cfelse>Move to</cfif> Invoice</p></td></tr>
	<cfset nothingToInvoice=false>
			<cfoutput query="thisItems">
				<cfset iMove=iMove+1>
				<tr>
					<td><input type="text" name="qtyM#iMove#" size="2" maxlength="3" value="<cfif url.undo>-</cfif>#qtyOrdered#" /></td>
				  <td><input type="hidden" name="idM#iMove#" value="#dtID#" />
					<input type="hidden" name="oidM#iMove#" value="#orderItemID#" />
                    <!---<cfif price EQ 0><cfset thisCost=0><cfelse><cfset thisCost=cost></cfif>//--->
                    <cfset thisCost=cost>
				  <input type="hidden" name="priceM#iMove#" value="#NumberFormat(thisCost,"0.00")#" />
					  <span class="style1">#catnum#</span></td>
                      
                  <td>#label#</td>
                  <td>#artist#</td>
                  <td>#title#</td>
                  <td>#DollarFormat(price)#</td>
				</tr>
			</cfoutput>
	</cfif>
    
    
    <cfset dt304total=0>
    
<cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#ID# AND (adminAvailID=5 OR adminAvailID=4) AND (left(shelfCode,1)<>'D' OR shelfCode='DO')
</cfquery>
	<cfif thisItems.recordCount NEQ 0>
	<tr><td colspan="5"><p class="style2">Imports</p></td></tr>
		
			<cfoutput query="thisItems">
				<tr>
					<td><input type="text" name="qtyMIm#ID#" size="2" maxlength="3" value="#qtyOrdered#" /></td>
				  <td><span class="style1">#catnum#</span></td>
                  <td>#label#</td>
                  <td>#artist#</td>
                  <td>#title#</td>
                  <td>#DollarFormat(price)#</td>
				</tr>
                <cfset dt304total=dt304total+(qtyOrdered*price)>
			</cfoutput>
		
	</cfif>
    <cfset thisImCt=thisItems.recordCount>
    
<cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#ID# AND adminAvailID=3 
</cfquery>
	<cfif thisItems.recordCount NEQ 0>
	<tr><td colspan="5"><p class="style2">Backordered</p></td></tr>
		
			<cfoutput query="thisItems">
				<tr>
					<td><input type="text" name="qtyBO#catnum#" size="2" maxlength="3" value="#qtyOrdered#" /></td>
				  <td><span class="style1">#catnum#</span></td>
                  <td>#label#</td>
                  <td>#artist#</td>
                  <td>#title#</td>
                  <td>#DollarFormat(price)#</td>
				</tr>
			</cfoutput>
		
	</cfif>
    <cfquery name="thisItems" datasource="#DSN#">
	SELECT *
	FROM orderItemsQuery
	where orderID=#ID# AND adminAvailID=1 
</cfquery>
	<cfif thisItems.recordCount NEQ 0>
	<tr><td colspan="5"><p class="style2">Not Available</p></td></tr>
		<cfset importCount=0>
			<cfoutput query="thisItems">
            					<tr>
					<td><input type="text" name="qtyNA#catnum#" size="2" maxlength="3" value="#qtyOrdered#" /></td>
				  <td><span class="style1">#catnum#</span></td>
                  <td>#label#</td>
                  <td>#artist#</td>
                  <td>#title#</td>
                  <td>#DollarFormat(price)#</td>
				</tr>
				<!---<cfset importCount=importCount+1>
				<tr>
					<td><input type="text" name="qtyMIm#ID#" size="2" maxlength="3" value="#qtyOrdered#" /></td>
                    <input type="hidden" name="art#importCount#" value="#Ucase(artist)#" />
                    <input type="hidden" name="tit#importCount#" value="#Ucase(title)#" />
                    <input type="hidden" name="lab#importCount#" value="#Ucase(label)#" />
                    <input type="hidden" name="med#importCount#" value="#DTFormatID#" />
                    <input type="hidden" name="pri#importCount#" value="#price#" />
                    <input type="hidden" name="cat#importCount#" value="#UCase(catnum)#" />
                    <input type="hidden" name="DT304ID#importCount#" value="#catItemID#" />
				  <td><span class="style1">#catnum#</span></td>
                  <td>#label#</td>
                  <td>#artist#</td>
                  <td>#title#</td>
				</tr>//--->
			</cfoutput>
		
	</cfif>
    
    </table>
    <input type="hidden" name="countImports" value="#thisImCt#" />
    
    
	<cfoutput><input type="hidden" name="iMove" value="#iMove#" />
	<input type="hidden" name="todaydate" value="#DateFormat(varDateODBC,"yyyy-mm-dd")#" />
	<input type="hidden" name="orderID" value="#url.ID#" />
	<input type="hidden" name="undo" value="#url.undo#" /></cfoutput>

<cfif iMove+iAdd GT 0><p><input type="submit" name="submit" value="Submit" /> &nbsp; &nbsp;
<cfif otherSiteID EQ 2><cfset orgID=8051><cfelse><cfset orgID=7214></cfif>
<cfif paymentTypeID EQ 5 AND shipID EQ 64><cfset orgID=6384></cfif>
<!---<input type="radio" name="orgID" value="8051"<cfif orgID EQ 8051> checked</cfif>> Discogs Invoice &nbsp; &nbsp;
<input type="radio" name="orgID" value="7214"<cfif orgID EQ 7214> checked</cfif>> Downtown 304 Invoice &nbsp; &nbsp;
<input type="radio" name="orgID" value="6384"<cfif orgID EQ 6384> checked</cfif>> Downtown 161 Invoice//--->
<input type="radio" name="orgID" value="7214" checked> Downtown 304 Invoice &nbsp; &nbsp;
<cfoutput>
<p>Downtown 161 Total: #DollarFormat(ceiling(dt161total))#<br>
Downtown 304 Total: #DollarFormat(ceiling(dt304total))#<br>
<b>Customer Total: #DollarFormat(ceiling(dt304total)+ceiling(dt161total))#</b></p>
</cfoutput>
<cfif orgID EQ 6384><p style="color:red;">Downtown 161 Cash Pickup</p></cfif><cfelse>
    <cfquery name="invoiced" datasource="#DSN#">
        update orders
        set issueResolved=1
        where ID=#url.ID#
    </cfquery>
    <cfif url.express NEQ "">
        <cflocation url="ordersPaid.cfm?ID=#url.ID#&express=#url.express#">
    <cfelse>
        <cflocation url="orders.cfm?editedID=#url.ID#">
    </cfif>
</cfif>
<!---<cfif nothingToInvoice><cfoutput><p><a href="ordersUpdateInvoiceComplete.cfm?ID=#url.ID#">Continue</a></p></cfoutput></cfif>
<cfoutput><p><a href="ordersEdit.cfm?ID=#url.ID#">Edit Order</a></p></cfoutput>//--->
</form>
</cfloop>
</body>
</html>