<cfquery name="artistCharts" datasource="#DSN#">
	select artistID, artist, listName, ID, listDate
	from artistListsQuery
	where artistID<>15387 AND active=1
	order by listDate DESC
</cfquery>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>opus lists</title>
<script language="javascript" src="scripts/opusscript.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="styles/opusstyles.css" />
<style type="text/css">
td img {display: block;}body {
	background-color: #000000;
}
.style3 {
	color: #FFFFFF;
	font-size: small;
	font-weight: bold;
}
</style>
</head>
<body>
<cfinclude template="topNav.cfm">
	<a href="javascript: history.go(-1);" onmouseout="MM_nbGroup('out');" onmouseover="MM_nbGroup('over','buttonBack','images/buttonBack_f2.jpg','images/buttonBack_f3.jpg',1);" onclick="MM_nbGroup('down','navbar1','buttonBack','images/buttonBack_f3.jpg',1);"><img src="images/buttonBack.jpg" alt="" name="buttonBack" width="37" height="10" hspace="5" vspace="5" border="0" id="buttonBack" /></a>
<table border="0" align="center" cellpadding="0" cellspacing="0">
<!-- fwtable fwsrc="opussitelayout07lists.png" fwbase="opussitelayout07lists.jpg" fwstyle="Dreamweaver" fwdocid = "685216091" fwnested="0" -->
  <tr>
   <td><img src="images/spacer.gif" width="13" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="12" height="1" border="0" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt="" /></td>
  </tr>

  <tr>
   <td><img name="opussitelayout07lists_r1_c1" src="images/opussitelayout07lists_r1_c1.jpg" width="13" height="10" border="0" id="opussitelayout07lists_r1_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r1_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r1_c3" src="images/opussitelayout07lists_r1_c3.jpg" width="12" height="10" border="0" id="opussitelayout07lists_r1_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="10" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r2_c1" src="images/opussitelayout07lists_r2_c1.jpg" width="13" height="24" border="0" id="opussitelayout07lists_r2_c1" alt="" /></td>
   <td align="left" valign="top" bgcolor="#006599"><span class="style3">ARTIST PLAY LISTS</span></td>
   <td><img name="opussitelayout07lists_r2_c3" src="images/opussitelayout07lists_r2_c3.jpg" width="12" height="24" border="0" id="opussitelayout07lists_r2_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="24" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r3_c1" src="images/opussitelayout07lists_r3_c1.jpg" width="13" height="6" border="0" id="opussitelayout07lists_r3_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r3_c2.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img name="opussitelayout07lists_r3_c3" src="images/opussitelayout07lists_r3_c3.jpg" width="12" height="6" border="0" id="opussitelayout07lists_r3_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="6" border="0" alt="" /></td>
  </tr>
  <tr>
   <td background="images/opussitelayout07lists_r4_c1.jpg"><img src="images/spacer.gif" width="1" heigth="1" /></td>
   <td valign="top" bgcolor="#333333"><table border=0 cellpadding=4 cellspacing=0>
     <cfoutput query="artistCharts">
	 <tr>
       <td align="left"><a href="artistCharts.cfm?artistID=#artistID#&chartID=#ID#"><b>#artist#</b> &nbsp;&nbsp;#listName#</a>&nbsp;&nbsp; (#DateFormat(listDate,"mmmm yyyy")#)</td>
     </tr>
	 </cfoutput>  
	 <!---<tr>
	 	<td align="left"><a href="artistChartsList.cfm">See Complete List of Artist Play Lists &gt;&gt;</a></td>
	 </tr>  //--->
</table></td>
   <td background="images/opussitelayout07lists_r4_c3.jpg"><img src="images/spacer.gif" width="1" height="1" /></td>
   <td><img src="images/spacer.gif" width="1" height="78" border="0" alt="" /></td>
  </tr>
  <tr>
   <td><img name="opussitelayout07lists_r5_c1" src="images/opussitelayout07lists_r5_c1.jpg" width="13" height="12" border="0" id="opussitelayout07lists_r5_c1" alt="" /></td>
   <td background="images/opussitelayout07lists_r5_c2.jpg"><img src="images/spacer.gif" height="1" width="1" /></td>
   <td><img name="opussitelayout07lists_r5_c3" src="images/opussitelayout07lists_r5_c3.jpg" width="12" height="12" border="0" id="opussitelayout07lists_r5_c3" alt="" /></td>
   <td><img src="images/spacer.gif" width="1" height="12" border="0" alt="" /></td>
  </tr>
</table>
</body>
</html>
