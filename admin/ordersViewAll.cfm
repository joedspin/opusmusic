<cfset pageName="ORDERS">
<cfset pageSub="POPORDERS">
<cfinclude template="pageHead.cfm">
<cfdirectory directory="#serverPath#/admin" filter="ordersPrintPicklists.pdf" name="checkForPDF" action="list">
<cfif checkForPDF.recordCount GT 0>
	<cffile action="delete" file="#serverPath#/admin/ordersPrintPicklists.pdf">
</cfif>
<cfparam name="url.ID" default="0">
<cfparam name="url.IDlist" default="">
<cfset orderInfo="">
<cfif url.ID NEQ 0>
	<cfset orderInfo="orders.ID="&url.ID>
<cfelse>
	<!---<cfset orderInfo="issueRaised=0 AND (statusID=2 OR statusID=3)"> REMOVED THIS TO CHANGE THE CRITERIA FROM "NOT YET PICKED" TO JUST "NOT YET PRINTED" (Below)//--->
    <cfif url.IDlist EQ "">
		<cfset orderInfo="ID=0">
    <cfelse>
	    <cfset orderInfo="ID IN (#url.IDlist#)">
    </cfif>
</cfif>
<cfquery name="allOrders" datasource="#DSN#">
	select *, otherSites.name as otherSiteName
	from ((orders left join paymentTypes ON orders.paymentTypeID=paymentTypes.PaymtID) LEFT JOIN otherSites ON orders.otherSiteID=otherSites.otherSiteID)
	where #orderInfo#
    order by datePurchased
</cfquery>
<cfif allOrders.recordCount GT 0>
<cfdocument filename="ordersPrintPicklists.pdf" format="pdf" overwrite="yes" marginleft=".3" margintop="0.3" marginright="0.3" marginbottom="0.3" pagetype="letter">

<!---//--->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304 : Orders Print Labels</title>
</head>

<body>
<style>
<!--
body {font-family: Arial, Helvetica, sans-serif; font-size: 11px; line-height:120%;}
p {font-family: Arial, Helvetica, sans-serif; font-size: 11px; line-height:120%;}
table {border-style: hidden; padding:0px;}
td {font-family: Arial, Helvetica, sans-serif; font-size: 10px; vertical-align:top; border-style: hidden; padding:2px; line-height: 120%;}
h1 {font-size: 20px; margin-bottom: 20px;}
h2 {font-size: 14px; margin-bottom: 10px;}
h3 {font-size: 12px; margin-bottom: 0px;}
.shipbill {line-height: 120%;}
.itemstatus {font-size: 9px; vertical-align:middle; text-align: center;}
-->
</style>
<cfset lastID=0>
<cfoutput query="allOrders">
	<cfif ID NEQ lastID>
		<cfif lastID NEQ 0>
        	<cfdocumentitem type="pagebreak"></cfdocumentitem>
		</cfif>
        <cfset lastID=ID>
	</cfif>
<cfquery name="thisCard" datasource="#DSN#">
	select *
	from userCardsQuery
	where ID=#userCardID#
</cfquery>
<cfif thisCard.ccNum NEQ ""><cfset procDetails="#thisCard.PayAbbrev# ending in #Right(Decrypt(thisCard.ccNum,encryKey71xu),4)#"><cfelse><cfset procDetails=""></cfif>
<cfset paymType=thisCard.ccTypeID>
<cfquery name="thisCust" datasource="#DSN#">
	select *
	from custAccounts
	where ID=#custID#
</cfquery>
<cfquery name="thisShipOption" datasource="#DSN#">
	select *
	from shippingRates
	where ID=#shipID#
</cfquery>
<cfquery name="thisShipping" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#shipAddressID#
</cfquery>
<cfquery name="thisBilling" datasource="#DSN#">
	select *
	from custAddressesQuery
	where ID=#billingAddressID#
</cfquery>
<cfif otherSiteID GT 0><cfset orderTitle="#otherSiteName#"><cfelseif thisCust.isStore EQ 1><cfset orderTitle="Distribution"><cfelse><cfset orderTitle="Downtown 304"></cfif>
<cfif thisCust.isStore><cfset orderName=thisCust.billingName><cfelse><cfset orderName=thisCust.firstName&" "&thisCust.lastName></cfif>
<cfset orderHead="<h1>"&orderTitle&" Order : "&NumberFormat(lastID,"00000")&"</h1>
<h2>"&orderName&" ("&#thisCust.username#&")</h2>
<h3>"&DateFormat(datePurchased,"mmmm d, yyyy")&"</h3>
<p>Customer email: "&thisCust.email&"<br>&nbsp;</p>">
<cfif thisCust.badCustomer><cfset orderHead="<h1>BAD **** DO NOT PICK ***</h1>"&orderHead></cfif>
#orderHead#
<cfloop query="thisShipOption"><h1>#name#</h1></cfloop>


<cfquery name="thisItems" datasource="#DSN#"><!--- adminAvailID=2 AND statusID<6 AND statusID>1 AND //--->
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE, NRECSINSET, media, albumStatusName
	FROM orderItemsQuery
	where shelfID=11 AND orderID=#lastID#  AND vendorID NOT IN (5650,6978,2811,2131)
	group by catnum, label, artist, title, ONSIDE, NRECSINSET, media, albumStatusName
	order by label, catnum, Sum(qtyOrdered) DESC
</cfquery>
<cfif thisItems.recordCount GT 0>
<h2>Downtown 161 (Warehouse)</h2>
<table border="0" style="border-collapse:collapse;" cellpadding="3" cellspacing="0" width="100%">
<cfset total=0>
<!---<cfset toggle=0>//--->
<cfloop query="thisItems">
<!---<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>//--->
<tr>
	<!---<td width="8" align="center"><!---<cfif UCase(left(media,2)) EQ "CD" OR left(media,2) EQ "10" OR left(media,1) EQ "7">#left(media,2)#<cfelse>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</cfif>//--->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="8" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>//--->
	<td width="8" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	<td>#UCase(label)#</td>
	<td>#UCase(catnum)#</td>
	<td>#UCase(artist)#</td>
	<td>#UCase(title)#</td>
	<td class="itemstatus">#Left(albumStatusName,"4")#</td>
</tr>
</cfloop>
<tr>
    <!---<td>&nbsp;</td>
    <td>&nbsp;</td>//--->
    <td align="center"><b>#total#</b></td>
    <td colspan="6">&nbsp;</td>
</tr>
</table>
	</cfif>

<cfquery name="thisItems" datasource="#DSN#"><!--- adminAvailID=2 AND statusID<6 AND statusID>1 AND //--->
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE, NRECSINSET, media, albumStatusName
	FROM orderItemsQuery
	where shelfID=11 AND orderID=#lastID# AND vendorID IN (5650,6978,2811,2131)
	group by catnum, label, artist, title, ONSIDE, NRECSINSET, media, albumStatusName
	order by label, catnum, Sum(qtyOrdered) DESC
</cfquery>
<cfif thisItems.recordCount GT 0>
<h2>Metro</h2>
<table border="0" style="border-collapse:collapse;" cellpadding="3" cellspacing="0" width="100%">
<cfset total=0>
<!---<cfset toggle=0>//--->
<cfloop query="thisItems">
<!---<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>//--->
<tr>
	<!---<td width="8" align="center"><!---<cfif UCase(left(media,2)) EQ "CD" OR left(media,2) EQ "10" OR left(media,1) EQ "7">#left(media,2)#<cfelse>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</cfif>//--->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="8" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>//--->
	<td width="8" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	<td>#UCase(label)#</td>
	<td>#UCase(catnum)#</td>
	<td>#UCase(artist)#</td>
	<td>#UCase(title)#</td>
	<td class="itemstatus">#Left(albumStatusName,"4")#</td>
</tr>
</cfloop>
<tr>
    <!---<td>&nbsp;</td>
    <td>&nbsp;</td>//--->
    <td align="center"><b>#total#</b></td>
    <td colspan="6">&nbsp;</td>
</tr>
</table>
</cfif>


<cfquery name="opusItems" datasource="#DSN#"><!--- adminAvailID=2 AND statusID<6 AND statusID>1 AND  //--->
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE, shelfCode, NRECSINSET, media, albumStatusName
	FROM orderItemsQuery
	where shelfID<>11 AND orderID=#lastID# AND shelfID NOT IN (2080,1064,1059,2127,2131,2136)
	group by catnum, label, artist, title, ONSIDE, shelfCode, NRECSINSET, media, albumStatusName
	order by label, catnum, Sum(qtyOrdered) DESC
</cfquery>
<cfif opusItems.recordCount GT 0>
<h2>Downtown 304</h2>
<table border="0" style="border-collapse:collapse;" cellpadding="3" cellspacing="0" width="100%">
<cfset total=0>
<!---<cfset toggle=0>//--->
<cfloop query="opusItems">
<!---<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>//--->
	<!---<td width="8" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="8" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>//--->
<tr>
	<td width="8" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	<td>#UCase(label)#</td>
	<td>#UCase(catnum)#</td>
	<td>#UCase(artist)#</td>
	<td>#UCase(title)#</td>
	<td align="center">#shelfCode#</td>
	<td class="itemstatus">#Left(albumStatusName,"4")#</td>
</tr>
</cfloop>
<tr>
    <!---<td>&nbsp;</td>
    <td>&nbsp;</td>//--->
    <td align="center"><b>#total#</b></td>
    <td colspan="7">&nbsp;</td>
</tr>
</table>
</cfif>

<cfquery name="opusItems" datasource="#DSN#"><!--- adminAvailID=2 AND statusID<6 AND statusID>1 AND  //--->
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE, shelfCode, NRECSINSET, media, albumStatusName
	FROM orderItemsQuery
	where shelfID<>11 AND orderID=#lastID# AND shelfID IN (1059,2127,2131,2136)
	group by catnum, label, artist, title, ONSIDE, shelfCode, NRECSINSET, media, albumStatusName
	order by label, catnum, Sum(qtyOrdered) DESC
</cfquery>
<cfif opusItems.recordCount GT 0>
<h2>Polite</h2>
<table border="0" style="border-collapse:collapse;" cellpadding="3" cellspacing="0" width="100%">
<cfset total=0>
<!---<cfset toggle=0>//--->
<cfloop query="opusItems">
<!---<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>//--->
	<!---<td width="8" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="8" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>//--->
<tr>
	<td width="8" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	<td>#UCase(label)#</td>
	<td>#UCase(catnum)#</td>
	<td>#UCase(artist)#</td>
	<td>#UCase(title)#</td>
	<td align="center">#shelfCode#</td>
	<td class="itemstatus">#Left(albumStatusName,"4")#</td>
</tr>
</cfloop>
<tr>
    <!---<td>&nbsp;</td>
    <td>&nbsp;</td>//--->
    <td align="center"><b>#total#</b></td>
    <td colspan="7">&nbsp;</td>
</tr>
</table>
</cfif>

<cfquery name="opusItems" datasource="#DSN#"><!--- adminAvailID=2 AND statusID<6 AND statusID>1 AND  //--->
	SELECT catnum, Sum(qtyOrdered) As totalOrdered, label, artist, title, ONSIDE, shelfCode, NRECSINSET, media, albumStatusName
	FROM orderItemsQuery
	where shelfID<>11 AND orderID=#lastID# AND shelfID IN (2080,1064)
	group by catnum, label, artist, title, ONSIDE, shelfCode, NRECSINSET, media, albumStatusName
	order by label, catnum, Sum(qtyOrdered) DESC
</cfquery>
<cfif opusItems.recordCount GT 0>
<h2>George T</h2>
<table border="0" style="border-collapse:collapse;" cellpadding="3" cellspacing="0" width="100%">
<cfset total=0>
<!---<cfset toggle=0>//--->
<cfloop query="opusItems">
<!---<cfif toggle EQ 0><tr><cfset toggle=1><cfelse><tr style="background-color: ##CCCCCC;"><cfset toggle=0></cfif>//--->
	<!---<td width="8" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="8" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>//--->
<tr>
	<td width="8" align="center">&nbsp;&nbsp;#totalOrdered#&nbsp;&nbsp;</td>
	<cfset total=total+totalOrdered>
    <td><cfif NRECSINSET GT 1>#NRECSINSET#x</cfif>#media#</td>
	<td>#UCase(label)#</td>
	<td>#UCase(catnum)#</td>
	<td>#UCase(artist)#</td>
	<td>#UCase(title)#</td>
	<td align="center">#shelfCode#</td>
	<td class="itemstatus">#Left(albumStatusName,"4")#</td>
</tr>
</cfloop>
<tr>
    <!---<td>&nbsp;</td>
    <td>&nbsp;</td>//--->
    <td align="center"><b>#total#</b></td>
    <td colspan="7">&nbsp;</td>
</tr>
</table>
</cfif>

<p>&nbsp;</p>
<table border="0" style="border-collapse:collapse;" cellpadding="8" cellspacing="0" width="100%">
	<tr>
		<td valign="top" width="50%" class="shipbill">
	<p><b>Ship to:</b><br />
		<cfloop query="thisShipping">
		#thisShipping.firstName# #thisShipping.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country#<br>
		#phone1#</p>
	</cfloop>
	</td>
	<td valign="top" width="50%" class="shipbill">
	<p><b>Bill to:</b><br />
		<cfloop query="thisBilling">
		#thisBilling.firstName# #thisBilling.LastName#<br />
		#add1#<br />
		<cfif add2 NEQ "">#add2#<br /></cfif>
		<cfif add3 NEQ "">#add3#<br /></cfif>
		#city# <cfif state NEQ "">#state# </cfif><cfif stateprov NEQ "">#stateprov# </cfif> #postcode#<br />
		#country#<br>
		#phone1# </p>
	</cfloop></td></tr>
	<tr>
	<td valign="top" class="shipbill"><p><cfif NOT isGEMM><b>Shipping Method:</b><br />
	<cfset thisShipping=orderShipping>
	<cfloop query="thisShipOption">
		#name# (#shippingTime#) #DollarFormat(thisShipping)#
	</cfloop><cfelse><b>#comments#</b></cfif></p></td>
	<td valign="top" class="shipbill"><p>Order Sub-Total: <b>#DollarFormat(orderSub)#</b><br>
	
	<cfif orderTax GT 0>NY Sales Tax (8.875%): <b>#DollarFormat(orderTax)#</b><br /></cfif>
	Order Total: <b>#DollarFormat(orderTotal)#</b></p>
	<cfloop query="thisCard">
<p>#procDetails#<br>
#thisCard.PayAbbrev#<br />
<cfif ccNum NEQ "">Ending in #Right(Decrypt(ccNum,encryKey71xu),4)#<br /></cfif>
#ccFirstName# #ccName# [userCard ID: #thisCard.ID#]</p>
</cfloop>
<h3>#payType#</h3>
	</td></tr></table>
	<cfif specialInstructions NEQ ""><p style="font-size: medium;"><b>SPECIAL INSTRUCTIONS:</b><br>
		#specialInstructions#</p></cfif>
        <cfif thisCust.custNotes NEQ ""><p style="font-size: medium;"><b>CUSTOMER NOTES:</b><br>
   #Replace(thisCust.custNotes,linefeed,'<br>','all')#</p></cfif>
        <cfif Trim(otherSiteOrderNum) NEQ ""><p style="font-size: medium;"><b>#allOrders.otherSiteName# Order ##<cfif otherSiteID EQ 2>10096-</cfif>#otherSiteOrderNum#</b></p></cfif>
	<!---<cfdocumentitem type="pagebreak"></cfdocumentitem>
	#orderHead#
    <h1><cfloop query="thisShipOption">#name#</cfloop></h1>
	<p><cfif NOT isGEMM><b>Shipping Method:</b><br />
	<cfset thisShipping=orderShipping>
	<cfloop query="thisShipOption">
		#name# (#shippingTime#) #DollarFormat(thisShipping)#
	</cfloop><cfelse><b>#comments#</b></cfif></p>
	<cfloop query="thisCard">
		<p>#procDetails#<br>
		#thisCard.PayAbbrev#<br />
		<cfif ccNum NEQ "">Ending in #Right(Decrypt(ccNum,encryKey71xu),4)#<br /></cfif>
		Name on Card: #ccFirstName# #ccName# [userCard ID: #thisCard.ID#]</p>
	</cfloop>
	<cfif specialInstructions NEQ ""><p style="font-size: medium;"><b>SPECIAL INSTRUCTIONS:</b><br>
		#specialInstructions#</p></cfif>//--->
</cfoutput>
</body>
</html>
</cfdocument>
<!---<h1><a href="ordersPrintPicklists.pdf" target="_blank">Print Orders</a></h1>//--->
<cfif url.ID NEQ 0>
	<cfoutput><script>setTimeout("location.href = 'ordersViewAllFinished.cfm?ID=#url.ID#';",1500);</script></cfoutput>
<cfelse>
	<h1>Orders are now displayed in a pop-up window.</h1>
	<cfoutput><h1><a href="ordersViewAllFinished.cfm?IDlist=#url.IDlist#">CLICK HERE ONLY IF EVERYTHING PRINTED OK</h2></cfoutput>
</cfif>
<!---<cflocation url="ordersPrintPicklists.pdf" addtoken="no">/--->
<cfelse>
<script>
function popOrders() {
}
</script>
<h1>Nothing to Print</h1>
<h2><a href="orders.cfm">Click here to continue</a></h2>
</cfif>
<cfinclude template="pageFoot.cfm">
