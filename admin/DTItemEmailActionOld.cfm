<cfsetting requesttimeout="6000">
<cfset lineFeed=chr(13)&chr(10)>
<cfparam name="form.ID" default="0">
<cfparam name="form.pageBack" default="catalogReview.cfm">
<cfparam name="form.custMessage" default="">
<cfparam name="Session.userEmail" default="">
<cfif Session.userEmail EQ "">
	<cflogout>
	<cfset userMessage="Your email address is not loaded, please login again.<br>Sorry for the inconvenience.">
	<cfinclude template="loginform.cfm">
	<cfabort>
</cfif>
<cfquery name="catalogFind" datasource="#DSN#">
	select *
	from catItemsQuery
	where ID=#form.ID#
</cfquery>
<cfmail query="catalogFind" to="#Session.userEmail#" from="joe@downtown161.com" subject="DOWNTOWN 161 :: #label# #catnum#" type="html">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Downtown 161</title>
	<script language="JavaScript" type="text/JavaScript" src="http://www.downtown161.com/dt161.js"></script>
	<script language="javascript">
<!--
var page = "catalog";

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("##")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v6.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}
//-->
</script>
<style>
<!--
body {  
  	background-color: white;
	font-family: Arial, Helvetica, sans-serif;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-left: 10px;
	margin-right: 10px;
}
.bgtable {
	background-repeat: repeat-x;
}
.header {
	font-size: 11px; 
	line-height: 14px;
	color: ##FF0000;
}
.title {
	font-weight: bold;
}

a {text-decoration : underline;}
a:link { color: ##a51c4a;}
a:visited { color: ##a51c4a;} 
a:hover { color: ##a51c4a;} 
a:active { color: ##a51c4a;} 


.default {
	font-family: verdana;
	color: ##666666;
	font-size: 10px; 
	line-height: 14px;
}
.rsb {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	line-height: 12px;
	color: ##666666;
	background-color : ##C6C7C6;
}
.footer {
	font-family: verdana;
	color: ##999999;
	font-size: 9px; 
	line-height: 10px;
}
.footer a {text-decoration : none;}
.footer a:link { color: ##999999;}
.footer a:visited { color: ##999999;} 
.footer a:hover { color: ##a51c4a;} 
.footer a:active { color: ##a51c4a;} 
.catDisplay {
	font-family: Arial, Helvetica, sans-serif;
	font-size:x-small;
	color:##333333;}
.catDisplay {
	font-family: Arial, Helvetica, sans-serif;
	font-size:x-small;
	color:##000000;
	margin-top: 0px;
	margin-bottom: 0px;
	line-height:80%;
	color:##333333;}
.catDisplayOOS {
	font-family: Arial, Helvetica, sans-serif;
	font-size:x-small;
	color:##666666;
	margin-top: 0px;
	margin-bottom: 0px;
	line-height:80%;
	color:##333333;}
.detailsArtist {
	font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	line-height: 120%;
	color:##333333;
	letter-spacing: normal;
}
.detailsTitle {
	font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	line-height: 120%;
	color:##333333;
	font-weight: bold;
}
.detailsLabel {
	font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	line-height: 120%;
	color:##333333;
}
.detailsTracks {
	font-family: Arial, Helvetica, sans-serif;
	font-size: xx-small;
	line-height: 80%;
	color:##333333;
}
td img {display: block;}
.style1 {font-size: medium}
.style3 {
	font-size: 14px;
	font-family: Arial, Helvetica, sans-serif;
	color: ##FFCC00;
	font-weight: bold;
}
//-->
</style>
</head>
<body onLoad="MM_preloadImages('images/DTstatusMenu_r1_c1_f3.jpg','images/DTstatusMenu_r1_c1_f2.jpg','images/DTstatusMenu_r1_c2_f3.jpg','images/DTstatusMenu_r1_c2_f2.jpg','images/DTstatusMenu_r1_c3_f3.jpg','images/DTstatusMenu_r1_c3_f2.jpg','images/DTstatusMenu_r1_c4_f3.jpg','images/DTstatusMenu_r1_c4_f2.jpg')">
<table border="0" cellpadding="20" cellspacing="0" class="bgTable" width="100%" align="center" background="http://www.downtown161.com/img/bkg.jpg" >
<tr><td>
<cfif form.custMessage NEQ "">
<table border="0" cellpadding="20" cellspacing="10" width="795" bgcolor="##FFFFFF" align="center">
<tr>
<td bgcolor="##5C707D" class="style3">#Replace(custMessage,lineFeed,"<br>")#</td>
</tr>
</table>
</cfif>
<table border="0" cellpadding="0" cellspacing="10" width="795" bgcolor="##FFFFFF" align="center">
<tr>
<td>
<table border="0" cellpadding="0" cellspacing="0" width="775" class="topnav">
	<tr valign="top">
	<td width="375"><a href="http://www.downtown161.com/index.php"><img src="http://www.downtown161.com/img/logo.gif" width="375" height="60" alt="" border="0"></a></td>
	<td><a href="http://www.downtown161.com/about.html" target="_top" onMouseOver="MM_swapImage(\'nav_about\',\'\',\'http://www.downtown161.com/img/nav/nav_about_on.gif\',1)" onMouseOut="MM_swapImgRestore();"><img name="nav_about" src="http://www.downtown161.com/img/nav/nav_about.gif" width="100" height="60" border="0" alt=""></a></td>
		<td><a href="http://www.downtown161.com/artists.html" target="_top"><img name="nav_artists" onMouseOver="MM_swapImage(\'nav_artists\',\'\',\'http://www.downtown161.com/img/nav/nav_artists_on.gif\',1)" onMouseOut="MM_swapImgRestore();" src="http://www.downtown161.com/img/nav/nav_artists.gif" width="100" height="60" border="0" alt=""></a></td>
		
	<td><a href="http://www.downtown161.com/labels.html" target="_top"><img name="nav_labels" onMouseOver="MM_swapImage(\'nav_labels\',\'\',\'http://www.downtown161.com/img/nav/nav_labels_on.gif\',1)" onMouseOut="MM_swapImgRestore();" src="http://www.downtown161.com/img/nav/nav_labels.gif" width="100" height="60" border="0" alt=""></a></td>
	
		<td><a href="http://www.downtown161.com/index.php" target="_top"><img name="whatsnew" onMouseOver="MM_swapImage(\'whatsnew\',\'\',\'http://www.downtown161.com/img/nav/nav_whatsnew_on.gif\',1)" onMouseOut="MM_swapImgRestore();" src="http://www.downtown161.com/img/nav/nav_whatsnew.gif" width="100" height="60" border="0" alt=""></a></td>


	</tr>
	</table>
	  <table border="0" cellpadding="0" cellspacing="0" width="775">
	<tr>
	<td colspan="7">&nbsp;</td>
	</tr>
	<tr valign="top" bgcolor="##CECBCE">
	   <td width="25" bgcolor="##949EA5"><img src="http://www.downtown161.com/img/spacer.gif" width="25" height="23" alt="" border="0"></td>
	   <td width="505"><img src="http://www.downtown161.com/img/tagline.gif" width="505" height="23" alt="" border="0"></td>
	   <td width="45" bgcolor="##949EA5"><img src="http://www.downtown161.com/img/spacer.gif" width="45" height="23" alt="" border="0"></td>
	   <td width="9"><img src="http://www.downtown161.com/img/shadow.jpg" width="9" height="23" alt="" border="0"></td>
	   <td width="12" class="rsb"><img src="http://www.downtown161.com/img/spacer.gif" width="12" height="12" alt="" border="0"></td>
	   <td width="167" class="rsb"><img src="http://www.downtown161.com/img/spacer.gif" width="167" height="1" alt="" border="0"></td>
	   <td width="12" class="rsb"><img src="http://www.downtown161.com/img/spacer.gif" width="12" height="10" alt="" border="0"></td>
	</tr>
	<tr valign="top" bgcolor="##CECBCE">
	   <td width="25"><img src="http://www.downtown161.com/img/spacer.gif" width="25" height="23" alt="" border="0"></td>
	   <td width="505" class="default">
	   <!-- begin content -->
	  <img src="http://www.downtown161.com/img/spacer.gif" width="500" height="10">

<table width="100%" border="0" cellpadding="3"  bgcolor="##C6C7C6">
	<cfset imagefile="labels/label_WhiteLabel.gif">
	<cfset imagefolder="">
	<cfdirectory directory="#serverPath#\images\items" filter="oI#catalogFind.ID#.jpg" name="imageCheck" action="list">
	<cfif imageCheck.recordCount NEQ 0>
		<cfset imagefile="items/" & imageCheck.name>
	<cfelseif logofile NEQ "">
		<cfdirectory directory="#serverPath#\images\labels" filter="#logofile#" name="logoCheck" action="list">
		<cfif logoCheck.recordCount NEQ 0>
			<cfset imagefile="labels/" & logoCheck.name>
		</cfif>
	</cfif>
	

  <tr>
    <td width="85" rowspan="2" align="center" valign="top"><img src="http://www.downtown304.com/images/#imagefile#" width="75" height="75" /></td>
    <td width="300" align="left" valign="top" class="detailsArtist" ><b>#artist#</b>
		<br />#title#</td>
    <td rowspan="2" align="left" valign="top" class="detailsLabel" nowrap><b>#label#</b><br />
		Cat. No.: #catnum#<br />
		Item No.: #ID##shelfCode#<br />
		Format: <cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#<br />
     	#DollarFormat(cost)#</td>
  </tr>
  <tr>
    <td valign="top" class="detailsTracks">
	<table width="100%" border="0" cellpadding="0" align="left" cellspacing="0">
	<cfquery name="tracks" datasource="#DSN#">
		select *
		from catTracks
		where catID=#catalogFind.ID#
		order by tSort
	</cfquery>
	<cfloop query="tracks">
		<cfdirectory directory="d:\media" filter="oT#tracks.ID#.mp3" name="trackCheck" action="list">
		<tr>
			<td align="left" class="detailsTracks" style="line-height: 80%;" valign="middle" width="16"><cfif trackCheck.recordCount GT 0><a href="http://www.downtown304.com/media/oT#tracks.ID#.mp3"><img 
			src="http://www.downtown304.com/images/speaker.gif" width="16" height="13" border="0" align="middle" alt="listen" hspace="2"></a><cfelse><img src="http://www.downtown304.com/images/spacer.gif" align="middle" height="13" width="1" border="0"></cfif>&nbsp;</td>
			<td align="left" class="detailsTracks" style="line-height: 120%;" valign="middle" >#tName#</td>
      	</tr>
	  </cfloop>
    </table>	</td>
   </tr>
  <tr>
  	<td colspan="3"><hr noshade></td>
  </tr>

</table> 

<!-- end content -->
	   </td>
	   <td width="45"><img src="http://www.downtown161.com/img/spacer.gif" width="45" height="23" alt="" border="0"></td>
	   <td width="9" background="http://www.downtown161.com/img/shadow.jpg"><img src="http://www.downtown161.com/img/shadow.jpg" width="9" height="23" alt="" border="0"></td>
	   <td width="12" class="rsb"><img src="http://www.downtown161.com/img/spacer.gif" width="12" height="17" alt="" border="0"><img src="http://www.downtown161.com/img/spacer.gif" width="12" height="12" alt="" border="0"></td>
	   <td width="167" class="rsb"><img src="http://www.downtown161.com/img/spacer.gif" width="167" height="15" alt="" border="0">
<!-- begin contact info -->
<strong>Phone:</strong> 212-929-3100<br>
		<strong>Fax:</strong> 212-929-4430<br><br>
		
		<strong>Address:</strong> <br>
		Downtown 161<br>
		304 Hudson Street<br>
		5th Floor<br>
		New York, NY 10013<br><br>
		
		<strong>Linda Perrone</strong><br>
		President/Export Sales<br>
		<a href="mailto:linda@downtown161.com">linda@downtown161.com</a><br><br>
		
		<strong>Judy Russell</strong><br>
		Domestic Sales/A&R<br>
		<a href="mailto:judy@downtown161.com">judy@downtown161.com</a><br><br>
		
		<strong>Mark Richards</strong><br>
		Domestic/Export Sales<br>
		<a href="mailto:mark@downtown161.com">mark@downtown161.com</a><br><br>
		
		<strong>Nick Chacona</strong><br>
		Domestic/Export Sales<br>
		<a href="mailto:nick@downtown161.com">nick@downtown161.com</a><br><br>
		
		<strong>Lisa Nell</strong><br>
		Financial Department<br>
		<a href="mailto:lisa@downtown161.com">lisa@downtown161.com</a><br><br>
		
		<strong>Marianne Legard</strong><br>
		Retail<br>
		<a href="mailto:marianne@downtown161.com">marianne@downtown161.com</a><br><br>
		<br><br>
<!-- end contact info -->
</td>
	   <td width="12" class="rsb"><img src="http://www.downtown161.com/img/spacer.gif" width="12" height="10" alt="" border="0"></td>
	</tr>
	</table>

</td>
</tr>
</table>

<!-- begin footer -->
<script language="javascript">
printFooterRemote();
</script>
<!-- end footer -->
</td></tr></table>
</body>
</html>
</cfmail>
<cflocation url="#form.pageBack#?emailsent=#form.ID#">