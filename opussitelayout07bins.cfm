<cfparam name="Session.username" default="">
<cfparam name="url.itemID" default="0">
<cfparam name="url.si" default="">
<cfparam name="url.cartTop" default="">
<!---<cfparam name="Cookie.cartTop" default="">
<cfparam name="Cookie.username" default="">//--->
<cfparam name="url.checkout" default="">
<cfparam name="url.user" default="yes">
<cfparam name="url.notify" default="">
<cfset binsOnly="true">
<cfif url.user EQ "no">
<p style="margin-left: 10px; margin-top: 10px; margin-right: 10px;"><font color="yellow" size="2">Please login to use the shopping cart</font>  <a href="http://www.downtown304.com/index.cfm?logout=true" target="_top">Click here</a> to reset your session and log in</p>
</cfif>
<cflock scope="session" timeout="20" type="exclusive">
	<cfparam name="Session.cart" default="">
</cflock>
<!---<cfif url.cartTop NEQ "">
	<cfset Cookie.cartTop=url.cartTop>
</cfif>//--->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0014)about:internet -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>opussitelayout07bins.jpg</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<cfinclude template="cartGetContents.cfm">
<style type="text/css">
td img {display: block;}
body {
	background-color: #000000;
	margin-left: 3px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: white;
}
.style2 {color: #00FF33}
.style3 {color: #333333}
</style>
<!--Fireworks 8 Dreamweaver 8 target.  Created Mon Oct 16 16:20:07 GMT-0400 (Eastern Daylight Time) 2006-->
</head>
<body>
<cfif url.notify NEQ "">
	<cfquery name="emailMeAdded" datasource="#DSN#">
    	select artist, title
        from catItemsQuery
        where ID=<cfqueryparam value="#url.notify#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfquery name="thisCustEmail" datasource="#DSN#">
    	select email
        from custAccounts
        where ID=#Session.userID#
    </cfquery>
    <cfoutput query="emailMeAdded">
    	<div style="margin-top:3px; padding-left: 12px; background-color:##006599; width:192px; overflow:hidden;"><p style="color:##FFFFFF">We will email you at<br />
        <b>#thisCustEmail.email#*</b><br />
        when this title is available:<br />
        &ldquo;#title#&rdquo;<br />
        <b>#artist#</b></p></div>
    </cfoutput>
</cfif>
<table border="0" cellpadding="0" cellspacing="0" width="207">
<!-- fwtable fwsrc="opussitelayout07bins.png" fwbase="opussitelayout07bins.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
<cfif url.checkout NEQ "start">
  <tr>
   <td><img src="images/spacer.gif" width="17" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="178" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="12" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td rowspan="3" colspan="3"><img name="opussitelayout07bins_r1_c1" src="images/opussitelayout07bins_r1_c1.jpg" width="207" height="44" border="0" id="opussitelayout07bins_r1_c1" usemap="#m_opussitelayout07bins_r1_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="6" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="35" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="3" border="0" alt="" /></td>
  </tr>
  <tr>
   <td background="images/opussitelayout07bins_r4_c1.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td valign="top" bgcolor="#333333">
   <cfset thisSub=0>
		<cfif cartContents.recordCount GT 0>
			<table cellpadding="1" cellspacing="0" border="0" style="border-collapse:collapse;">
			<cfoutput query="cartContents">
<!---				<tr>
					<td valign="top"><a href="cartAction.cfm?cRemove=#orderItemID#" onClick="return confirm('Are you sure you want to delete this item from your cart?');"><img src="images/remove.jpg" width="9" height="10" border="0" align="left" vspace="2" /></a></td>
					<td valign="top">#qtyOrdered#</td>
					<td valign="top"><a href="opussitelayout07main.cfm?af=#artistID#" target="opusviewmain" title="View Titles by this Artist">#Left(artist,20)#</a><br /><a href="opussitelayout07main.cfm?sID=#catItemID#" target="opusviewmain" title="View Details and Recommendations">#Left(title,20)#</a></td>
				</tr>//--->
				<cfset thisSub=thisSub+qtyOrdered*price>
			</cfoutput>
			<tr><td><cfoutput>#cartContents.recordCount#</cfoutput> Items in cart</td></tr>
			</table>
			<cfoutput><p><b>Order Subtotal: #DollarFormat(thisSub)#</b></p></cfoutput>
			<cfif Session.userID NEQ 0 AND Session.userID NEQ ""><cfoutput><p><a href="http://downtown304.com/checkOut.cfm?dsu=#URLEncodedFormat(Encrypt(Session.userID,'y6DD3cxo86zHGO'))#" target="_top">View Cart | Check Out</a></p></cfoutput><!---?userID=<cfoutput>#Session.userID#</cfoutput>//--->
			<cfelse>
			<p><font color="yellow">Please login before checking out</font></p></cfif>
		<cfelse>
			<p>EMPTY</p>
			<cfparam name="Session.username" default="">
			<cfif Session.username EQ ""><p>Login to see your saved cart.</p></cfif>
		</cfif></td>
   <td background="images/opussitelayout07bins_r4_c3.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="78" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="2" colspan="3"><img name="opussitelayout07bins_r5_c1" src="images/opussitelayout07bins_r5_c1.jpg" width="207" height="12" border="0" id="opussitelayout07bins_r5_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="7" border="0" alt="" /></td>
  </tr>
 </cfif>  <tr>
   <td><img src="images/spacer.gif" width="1" height="5" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="2" colspan="3"><img name="opussitelayout07bins_r7_c1" src="images/opussitelayout07bins_r7_c1.jpg" width="207" height="40" border="0" id="opussitelayout07bins_r7_c1" usemap="#m_opussitelayout07bins_r7_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="17" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="23" border="0" alt="" /></td>
  </tr>

  <tr>
   <td rowspan="3" background="images/opussitelayout07bins_r9_c1.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td rowspan="3" valign="top" bgcolor="#333333">
   <cfif Session.userID NEQ 0>
	<cfquery name="binContents" datasource="#DSN#">
		select listenBin.*, catTracks.*, catItemsQuery.*,catItemsQuery.ID As thisItemID
		from (listenBin LEFT JOIN catTracks ON listenBin.catItemID = catTracks.ID) LEFT JOIN catItemsQuery ON catTracks.catID = catItemsQuery.ID
		where custID=<cfqueryparam value="#Session.userID#" cfsqltype="integer">
		order by listenBin.dateAdded DESC
	</cfquery>
		<cfif binContents.recordCount GT 0>
			<table border="0" cellpadding="2" cellspacing="0">
				<cfoutput query="binContents">
				<cfif mp3Alt NEQ 0><cfset trID=mp3Alt><cfelse><cfset trID=catItemID></cfif>
				<tr>
					<td valign="top">
						<table cellpadding="1" cellspacing="0" border="0" width="10"style="border-collapse:collapse;">
			<tr class="oTrack"><td><a href="opussitelayout07player.cfm?oClip=#trID#" target="opusviewplayer" class="detailsTracks"><img src="images/play.gif" width="9" height="10" border="0" /></a></td></tr>
			<tr><td><a href="binAction.cfm?rClip=#ID#"><img src="images/remove.jpg" width="9" height="10" border="0" /></a></td></tr>
			<tr><td><cfif ((ONHAND GT 0 AND albumStatusID LT 25) OR ONSIDE GT 0) AND ONSIDE NEQ 999><a href="cartAction.cfm?cAdd=#catID#" target="opusviewbins"><img src="images/cart.jpg" width="9" height="10" border="0" /></a><cfelse>&nbsp;</cfif></td></tr>			
			</table></td>
					<td valign="top">
						<b><a href="opussitelayout07main.cfm?af=#artistID#" target="opusviewmain" title="View Titles by this Artist">#Left(artist,20)#</a></b><br />
						<i><a href="opussitelayout07main.cfm?sID=#thisItemID#" target="opusviewmain" title="View Details and Recommendations">#Left(title,20)#</a></i><br />
						#Left(tName,20)#
					</td>
				</tr>
				</cfoutput>
			</table>
		<cfelse>
			<p>empty</p>
		</cfif>
	<cfelse>
		<cfif url.si EQ "no">
			<p>You must be signed in to use this feature</p>
		<cfelse>
			<p>EMPTY</p>
		</cfif>
	</cfif>
	</td>
   <td rowspan="3" background="images/opussitelayout07bins_r9_c3.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="59" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="5" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="59" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="2"><img name="opussitelayout07bins_r12_c1" src="images/opussitelayout07bins_r12_c1.jpg" width="195" height="12" border="0" id="opussitelayout07bins_r12_c1" alt="" /></td>
   <td><img name="opussitelayout07bins_r12_c3" src="images/opussitelayout07bins_r12_c3.jpg" width="12" height="12" border="0" id="opussitelayout07bins_r12_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="12" border="0" alt="" /></td>
  </tr>
  <tr>
   <td rowspan="3" colspan="3" background="images/opussitelayout07bins_r13_c1.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img src="images/spacer.gif" width="1" height="15" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="3"><img name="opussitelayout07bins_r16_c1" src="images/opussitelayout07bins_r16_c1.jpg" width="207" height="1" border="0" id="opussitelayout07bins_r16_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>
  <tr>
   <td colspan="3"><img name="opussitelayout07bins_r17_c1" src="images/opussitelayout07bins_r17_c1.jpg" width="207" height="9" border="0" id="opussitelayout07bins_r17_c1" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="9" border="0" alt="" /></td>
  </tr>
</table>
<!--- ALSO BOUGHT FEATURE //--->
<!---<cfparam name="url.itemID" default="0">
<cfquery name="thisItem" datasource="#DSN#">
	select *
	from catItemsQuery
	where ID=<cfqueryparam value="#url.itemID#" cfsqltype="cf_sql_integer">
</cfquery>
<cfif thisItem.recordCount GT 0>
<cfloop query="thisItem">
<cfset thisArtistID=thisItem.artistID>
<cfset thisLabelID=thisItem.labelID>
<cfset thisArtist=thisItem.artist>
<cfset thisLabel=thisItem.label>
</cfloop>
<cfset abMsg1="Customers who bought">
<cfset abMsg2="also bought these titles:">
<cfquery name="alsoBought" datasource="#DSN#" maxrows="30">
	select *
	FROM alsoBoughtQuery
	where abItemID=<cfqueryparam value="#url.itemID#" cfsqltype="cf_sql_integer"> AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0)
</cfquery>
<cfif alsoBought.recordCount EQ 0>
	<cfset abMsg1="If you like">
	<cfset abMsg2="you might also like these titles:">
	<cfquery name="alsoBought" datasource="#DSN#" maxrows="30">
		select *, ID As abID from catItemsQuery
		where (artistID=#thisArtistID# OR artist LIKE '%#thisArtist#%') AND ID<><cfqueryparam value="#url.itemID#" cfsqltype="cf_sql_integer"> AND artistID<>728 AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0)
	</cfquery>
</cfif>
<cfif alsoBought.recordCount EQ 0>
	<cfquery name="alsoBought" datasource="#DSN#" maxrows="30">
		select *, ID As abID from catItemsQuery
		where (labelID=#thisLabelID# OR label LIKE '%#thisLabel#%') AND ID<><cfqueryparam value="#url.itemID#" cfsqltype="cf_sql_integer"> AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0)
	</cfquery>
</cfif>

<cfif alsoBought.recordCount GT 0>
<cfoutput query="thisItem">
<p style="font-size: xx-small; margin-top: 4px; margin-bottom: 4px; margin-left: 6px;">#abMsg1#
<b>#artist#</b> 
"#title#" #abMsg2#</p>
</cfoutput>
<cfif alsoBought.recordCount GT 5>
	<cfset oRand=RandRange(1,alsoBought.recordCount-5)>
<cfoutput query="alsoBought" startrow="#oRand#" maxrows=5>
<p style="font-size: xx-small; margin-top: 4px; margin-bottom: 4px; margin-left: 6px;"><b><a href="opussitelayout07main.cfm?af=#artistID#" target="opusviewmain" title="View All Items by this Artist">#artist#</a></b><br><a href="opussitelayout07main.cfm?sID=#abID#" target="opusviewmain" title="View Item Details">#title#</a></p>
</cfoutput>
</cfif>
</cfif>
</cfif>//--->
<!--- END ALSO BOUGHT FEATURE //--->
<p align="center"><a href="opusship.cfm" target="opusviewmain">Shipping</a> &nbsp;|&nbsp; <a href="opuscontact.cfm" target="opusviewmain">Contact Us</a> &nbsp;|&nbsp; <a href="opushelp.cfm" target="opusviewmain">Help</a></p>
<p align="center"><img src="images/cards.jpg" alt="We accept PayPal, MasterCard, American Express, and Visa" width="147" height="26" /><br />
 <a href="http://www.facebook.com/pages/Downtown-304/22600676199" target="_blank"><img src="images/find_us_on_facebook_badge.gif" alt="facebook" width="144" height="44" vspace="4" border="0" /></a></p>
<table cellpadding="0" cellspacing="0" border="0" align="left">
	<tr>
    	<td colspan="5" align="center"><div style="position:relative; left:19px;">

<script type="text/javascript" data-pp-pubid="defb552e89" data-pp-placementtype="170x100"> (function (d, t) {
"use strict";
var s = d.getElementsByTagName(t)[0], n = d.createElement(t);
n.src = "//paypal.adtag.where.com/merchant.js";
s.parentNode.insertBefore(n, s);
}(document, "script"));
</script></div>
</td>
    </tr>
	<tr>
		<td width="15" rowspan="9"><img src="images/spacer.gif" width="15" height="15" /></td>
		<td align="left" colspan="3"><p><b>Key to Symbols</b></td>
	</tr>
	<tr>
		<td><img src="images/spacer.gif" width="12" height="6" /></td>
		<td><img src="images/spacer.gif" width="3" height="6" /></td>
		<td><img src="images/spacer.gif" width="12" height="6" /></td>
	</tr>
	<tr>
	  <td align="center" bgcolor="#009933" width="12" height="12"><div align="center" class="style2"><font style="font-size: x-small;">&gt;</font></div></td>
		<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
		<td>= Play in Listening Booth</td>
	</tr>
	<tr>
		<td><img src="images/spacer.gif" width="12" height="3" /></td>
		<td><img src="images/spacer.gif" width="3" height="3" /></td>
		<td><img src="images/spacer.gif" width="12" height="3" /></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#0066CC" width="12" height="12"><span class="style2"><font style="font-size: x-small;">B</font></span></td>
		<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
		<td>= Add to Listening Bin</td>
  </tr>
	  <tr>
		<td><img src="images/spacer.gif" width="12" height="3" /></td>
		<td><img src="images/spacer.gif" width="3" height="3" /></td>
		<td><img src="images/spacer.gif" width="12" height="3" /></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#00CC33" width="12" height="12"><span class="style3"><font style="font-size: x-small;">C</font></span></td>
		<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
		<td>= Add to Cart</td>
  </tr>
	  <tr>
		<td><img src="images/spacer.gif" width="12" height="3" /></td>
		<td><img src="images/spacer.gif" width="3" height="3" /></td>
		<td><img src="images/spacer.gif" width="12" height="3" /></td>
	</tr>
	<tr>
		<td align="center" bgcolor="#FF0000" width="12" height="12"><span class="style1">X</span></td>
		<td align="center" width="3"><img src="images/spacer.gif" width="3" height="12" /></td>
		<td>= Remove </td>
  </tr>
</table>



<map name="m_opussitelayout07bins_r1_c1" id="m_opussitelayout07bins_r1_c1">
<area shape="rect" coords="158,12,171,29" href="opussitelayout07bins.cfm?cartTop=false" alt="" />
</map>
<map name="m_opussitelayout07bins_r7_c1" id="m_opussitelayout07bins_r7_c1">
<area shape="rect" coords="158,9,171,26" href="javascript:;" alt="" />
</map>
</body>
</html>
