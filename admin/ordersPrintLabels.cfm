<!---<cfdirectory directory="#serverPath#/admin" filter="ordersPrintLabels.pdf" name="checkForPDF" action="list">
<cfif checkForPDF.recordCount GT 0>
	<cffile action="delete" file="#serverPath#/admin/ordersPrintLabels.pdf">
</cfif>//--->	
<cfset person="">
<cfset billingAddressID="">
<cfset custEmail="">
<cfparam name="url.ID" default="0">
<cfquery name="thisOrder" datasource="#DSN#">
	select [orders].[ID] As orderID, datePurchased, custID, shipAddressID, billingAddressID, statusID, specialInstructions, [shippingRates].[name] As ShipMethod, otherSiteOrderNum, orders.otherSiteID As otherSiteID, otherSites.name As otherSite from ((orders LEFT JOIN shippingRates ON shipID=shippingRates.ID) LEFT JOIN otherSites ON orders.otherSiteID=otherSites.otherSiteID)
    where [orders].[ID]=#url.ID#
</cfquery>

<cfif thisOrder.recordCount GT 0>
<!---<cfdocument filename="ordersPrintLabels.pdf" format="pdf" overwrite="yes" marginleft=".5" margintop="0.3" marginright="0.5" marginbottom="0.3" >//--->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304 : Orders Print Labels</title>
<style type="text/css">
<!--
.style2 {
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style3 {font-family: "Courier New", Courier, monospace}
.style4 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
}
.style6 {
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 16px;
}
.style8 {font-size: 16px}
-->
</style>
</head>

<body onLoad="javascript:window.print();">
<style>
<!--
body, td {font-family:Arial, Helvetica, sans-serif; font-size:12px;}
td {vertical-align:top;}
.labelText {font-size: 14px;}
.shipMethod {font-size: 20px;}
.verySmall {font-size: 7px;}
.item {font-size: 11px;}
.orderID {font-family:"Courier New", Courier, monospace; font-size:28px; font-weight: bold;}
-->
</style>
<cfoutput query="thisOrder">
<cfquery name="thisBilling" datasource="#DSN#">
        select phone1
        from custAddresses
        where ID=#billingAddressID#
    </cfquery>
    <!---<cfquery name="thisShipping" datasource="#DSN#">
	select firstName + ' ' + lastName As shipName, add1 As Ship1, add2 As Ship2, add3 As Ship3, city + ', ' + state + stateprov + ' ' + postcode As Ship4, 
		country As Ship5, phone1, email
        from custAddressesQuery where ID=#shipAddressID#
</cfquery>//--->
<cfquery name="thisShipping" datasource="#DSN#">
    select *
    from custAddressesQuery
    where ID=#shipAddressID#
</cfquery>

<table border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td><table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top"><p><img src="images/Downtown304_LabelHead.jpg" width="448" height="76" /><br />
		&nbsp;</p>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
		<tr><td bgcolor="##000000"><img src="spacer.gif" width="1" height="2" /></td></tr>
	</table>
		<cfloop query="thisShipping">
        <cfset shipName=UCase(firstName)&" "&UCase(lastName)>
        <cfset person=shipName>
        <cfif Left(person,1) EQ " "><cfset person=Right(person,Len(person)-1)></cfif>
        <cfif Left(shipName,1) EQ " " AND Len(shipName) GT 1><cfset custName=Right(shipName,Len(shipName)-1)><cfelse><cfset custName=shipName></cfif>
        <cfset custEmail=email>
        <cfset shipAdd4=city&", "&state&stateprov&" "&postcode>
        <cfset shipAdd4nocode=city&", "&state&stateprov>
        <blockquote><p class="labelText">&nbsp;<br />#custName#
		<cfif add1 NEQ ""><br />#UCase(add1)#</cfif>
		<cfif add2 NEQ ""><br />#UCase(add2)#</cfif>
		<cfif add3 NEQ ""><br />#UCase(add3)#</cfif>
		<cfif shipAdd4 NEQ ""><br />#UCase(shipAdd4)#</cfif>
		<cfif country NEQ "" AND country NEQ "United States"><br />#UCase(country)#</cfif></p></blockquote></cfloop></td>
      </tr>
      <!--- postclub headers: contact name, company, add 1, add 2, add 3, town city, country, zip, tel, email, weight, pieces, des of goods, value, currency, reference, shp depart code, shprs contact name, notes 
      <cfset postclubOutput=""""&custName&""","""","""&UCase(add1)&""","""&UCase(add2)&""","""&UCase(add3)&""","""&shipAdd4nocode&""","""&UCase(country)>//--->
      <tr>
        <td><img src="images/spacer.gif" width="30" height="10"></td>
      </tr>
    </table></td>
    <td width="25" class="verySmall" style="vertical-align:bottom;"><img src="../images/spacer.gif" width="50" height="1"></td>
    <td width="250" nowrap style="vertical-align:bottom;">
	<table>
    <tr>
    	<td nowrap valign="bottom"><b>Order ##:</b></td>
        <td width="15">&nbsp;</td>
        <td nowrap><p class="orderID">#orderID#</p></td>
    </tr>
          <tr>
        <td nowrap><b>Order Date:</b></td>
        <td width="15">&nbsp;</td>
        <td nowrap>#DateFormat(datePurchased,"mm/dd/yyyy")#</td>
      </tr>
      <tr>
        <td nowrap><b>Email:</b></td>
        <td width="15">&nbsp;</td>
        <td nowrap>#custEmail#</td>
      </tr>
      <tr>
        <td nowrap><b>Customer ID:</b></td>
        <td width="15">&nbsp;</td>
        <td nowrap>#custID#</td>
      </tr>
    </table>
      </td>
  </tr>
  </table>
  <p class="shipMethod"><b>#shipMethod#</b><cfif specialInstructions NEQ ""><br />
		#specialInstructions#</cfif><br />
        <cfif Trim(otherSiteOrderNum)NEQ "">#otherSite# <cfif otherSiteID EQ 2>Discogs Order ##10096-</cfif>#otherSiteOrderNum#<br></cfif>
		&nbsp;</p>
 <p>&nbsp;</p>
<cfquery name="thisOrderItems" datasource="#DSN#">
	select *
    from orderItemsQuery
    where adminAvailID<7 AND adminAvailID>3 AND orderID=#url.ID#
</cfquery>
 <table width="100%" border="0" cellspacing="0" cellpadding="1">
<cfloop query="thisOrderItems">
  <tr>
	<td width="3%" class="item">#shelfCode#</td>
	<td width="2%" class="item">#QtyOrdered#</td>
	<td width="6%" class="item">#catnum#</td>
	<td width="20%" class="item">#label#</td>
	<td width="34%" class="item">#artist#</td>
	<td width="35%" class="item">#title#</td>
  </tr>
</cfloop>
</table>
</cfoutput>
<!---<cfif thisOrder.otherSiteID NEQ 0>
<p>&nbsp;</p>
<hr noshade>
<p>&nbsp;</p>
<!--- code for accepting these promo codes is in checkOutShipAction.cfm //--->
<cfif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")+1#-02-28" AND DateFormat(varDateODBC,"yyyy-mm-dd") GT "#DateFormat(varDateODBC,"yyyy")#-11-30" ><cfset endDate="31 MARCH #DateFormat(varDateODBC,"yyyy")+1#"><cfset pCode="DJNY304">
<cfelseif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-05-31"><cfset endDate="30 JUNE #DateFormat(varDateODBC,"yyyy")#"><cfset pCode="NYC304">
<cfelseif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-08-31"><cfset endDate="30 SEPTEMBER #DateFormat(varDateODBC,"yyyy")#"><cfset pCode="VIN304">
<cfelseif DateFormat(varDateODBC,"yyyy-mm-dd") LTE "#DateFormat(varDateODBC,"yyyy")#-11-30"><cfset endDate="31 DECEMBER #DateFormat(varDateODBC,"yyyy")#"><cfset pCode="REC304">
</cfif>
  <p align="center"><span class="style4">NEXT TIME, SHOP DIRECTLY ON OUR WEBSITE <strong>www.downtown304.com</strong><br>
    You&rsquo;ll find more to choose from, soundclips, images, and lower prices!</span><span class="style6"></span><span class="style2"><br>
      <br>
      <cfoutput><span class="style8">USE THIS PROMO CODE FOR 5% OFF YOUR FIRST ORDER: <span class="style3">#pCode#</span><br>
      CODE EXPIRES: <span class="style3">#endDate#</span></span></span></cfoutput>
  </p></cfif>//---></body>
</html>
<!---</cfdocument>EQ "NYC304" AND ) OR (checkPromo EQ "DJNY304" AND )//--->
</cfif>
<cfmail to="info@downtown304.com" from="order@downtown304.com" subject="DT304 Address #person#" type="html">
<style><!--
body {font-family: Arial, Helvetica, sans-serif; }
-->
</style>
<cfloop query="thisOrder">

<cfloop query="thisShipping">
<p>#custName#<cfif add1 NEQ ""><br />
#UCase(add1)#</cfif><cfif add2 NEQ ""><br />
#UCase(add2)#</cfif><cfif add3 NEQ ""><br />
#UCase(add3)#</cfif><cfif shipAdd4 NEQ ""><br />
#UCase(shipAdd4)#</cfif><cfif country NEQ "" AND country NEQ "United States"><br />
#UCase(country)#</cfif><cfif email NEQ ""><br />
#email#</cfif><cfif phone1 NEQ ""><br />
#phone1#</cfif></p></cfloop>
</cfloop>
</cfmail>
<!---<cfset y=3>
<cfloop from="1" to="40000" index="x">
	<cfset y=x*x+y*x+y*y+x*y*x>
</cfloop>
<cflocation url="ordersPrintLabels.pdf" addtoken="no">//--->