// JavaScript Document
<!--
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
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])?args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) { img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr) for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function loadPlayer(trackID) {
		document.write('<object name="oPlayer" id="oPlayer" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="150" height="20" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab">');
	document.write('<param name="FlashVars" value="oClipTrack=media/oT'+trackID+'.mp3">'); 
	document.write('<param name="movie" value="singlemp3player.swf?showDownload=false" />');
	document.write('<param name="wmode" value="transparent" />');document.write('<embed wmode="transparent" width="150" height="20" src="singlemp3player.swf?showDownload=false" FlashVars="oClipTrack=media/oT'+trackID+'.mp3" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
	document.write('</object>');
}

function hidediv(divID) { 
if (document.getElementById) { // DOM3 = IE5, NS6 
document.getElementById('hideshow'+divID).style.visibility = 'hidden'; 
} 
else { 
if (document.layers) { // Netscape 4 
document.hideshow.visibility = 'hidden'; 
} 
else { // IE 4 
document.all.hideshow.style.visibility = 'hidden'; 
} 
} 
} 

function showdiv(divID) { 
	if (document.getElementById) { // DOM3 = IE5, NS6 
	document.getElementById('hideshow'+divID).style.visibility = 'visible'; 
	} 
	else { 
		if (document.layers) { // Netscape 4 
		document.hideshow.visibility = 'visible'; 
	} 
	else { // IE 4 
		document.all.hideshow.style.visibility = 'visible'; 
		} 
	} 
} 



//-->