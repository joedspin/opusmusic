<cfparam name="pageName" default="">
<cfparam name="pageSub" default="">
<cfparam name="url.ID" default="0">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 304 Site Admin :: <cfoutput>#pageName#</cfoutput></title>
<link rel="stylesheet" type="text/css" href="styles/opusadmin.css" />
<script language="javascript" src="scripts/opusadmin.js" type="text/javascript"></script>


</head>
<cfif pageSub EQ "POPORDERS">
	<body onload="javascript:popOrders();window.location.hash = '#edited';">
<cfelseif pageSub EQ "MAIN" AND url.editedPaid EQ 'yes'>
	<cfoutput><body onLoad="javascript:window.open('ordersPrintLabels.cfm?ID=#url.editedID#');window.location.hash = '##edited';"></cfoutput>
<cfelseif pageName EQ "ORDERS" AND pageSub EQ "EDIT" AND url.express NEQ "">
	<cfoutput><body onLoad="javascript:window.open('ordersPrintConfirmation.cfm?ID=#url.ID#');window.location.hash = '##edited';"></cfoutput>
<cfelse>
	<body><!--- onload="window.location.hash = '#edited';"//--->
</cfif>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">

  <tr> 
    <td>
	<table border="0" cellpadding="5" cellspacing="0">
      <tr>
		<td><img src="images/spacer.gif" width="1" height="10"></td>
        <td><a href="catalog.cfm">CATALOG</a></td>
		<td><img src="images/spacer.gif" width="15" height="10"></td>
        <td><a href="orders.cfm">ORDERS</a></td>
		<td><img src="images/spacer.gif" width="15" height="10"></td>
        <td><a href="customers.cfm">CUSTOMERS</a></td>
		<td><img src="images/spacer.gif" width="15" height="10"></td>
        <td><a href="lists.cfm">LISTS</a></td>
		<td><img src="images/spacer.gif" width="15" height="10"></td>
        <td><a href="reports.cfm">REPORTS</a></td>
		<td><img src="images/spacer.gif" width="15" height="10"></td>
        <td><form id="logoutform" name="logoutform" method="post" action="index.cfm"><input name="Logout" class="button" type="submit" id="Logout" value="LOGOUT" /></form></td><td><img src="images/spacer.gif" width="15" height="10"></td>
        <td><a href="ijoc">IJoC </a></td>
      </tr>
    </table></td>
  </tr>
  <tr>
  	<td>
		<hr noshade ><cfif pageName NEQ "Login"><cfinclude template="#pageName#Menu.cfm"></cfif></td>
  </tr>
  <!---
  <tr>
    <td bgcolor="#CCCCCC"><img src="images/spacer.gif" width="10" height="10" /></td>
  </tr>//--->
	<tr>
		<td><table border="0" cellspacing="0" cellpadding="15">
      <tr>
        <td><!--- PAGE BODY STARTS HERE //--->
		
		
		
		