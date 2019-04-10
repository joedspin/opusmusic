<cfset pageName="CUSTOMERS">
<cfset emailSubject="Downtown 304 .:. New Releases">
<cfparam name="url.test" default="no">
<cfinclude template="pageHead.cfm">
		<p>DOWNTOWN 304 online admin tool</p>
		
<cfsetting requesttimeout="6000">
<!---<cfquery name="EmailList" datasource="#DSN#">
	select DISTINCT email, name
	from DowntownWebsiteResponders
</cfquery>
<cfquery name="EmailList" datasource="#DSN#">
	select DISTINCT CustomerEmail as email, ShipToAttn as name
	from GEMMBatchProcessing
</cfquery>
<cfquery name="EmailList" datasource="#DSN#">
	select DISTINCT [Customer E-mail] as email, [ShipTo Attn] as name
	from GEMMBatchProcessingArchive where [Customer E-mail]<>''
</cfquery>
//--->
<cfquery name="EmailList" datasource="#DSN#">
	select DISTINCT email, name, ID
	from GEMMCustomers where email<>'' AND subscribe=1
	order by ID DESC
</cfquery>
<cfparam name="url.oLd" default="8">
<cfparam name="url.oHd" default="-1">
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[releaseDate],getDate()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[releaseDate],getDate())<#url.oLd# AND DateDiff(day,[releaseDate],getDate())>#url.oHd# AND 
			((catItemsQuery.ONHAND)>0 OR (catItemsQuery.ONSIDE)>0) AND ONSIDE<>999 AND ((catItemsQuery.albumStatusID)<=22 AND 
			(catItemsQuery.albumStatusID)>=21)
	order by genreID, artist
</cfquery>
<cfset nroutput="">
<cfset lastGenre="">
<cfloop query="catalogFind">
<cfif genre EQ "Dance"><cfset thisgenre="House"><cfelse><cfset thisgenre=genre></cfif>
<cfif thisgenre NEQ lastGenre>
	<cfset nroutput=nroutput&"<h1>"&thisgenre&" - New Releases</h1>">
</cfif>
<cfset nroutput=nroutput&"<p><a href=""http://www.downtown304.com/index.cfm?sID=#ID#""><b>"&artist&"</b> "&title&" (">
<cfif NRECSINSET GT 1>
	<cfset nroutput=nroutput&NRECSINSET&" x ">
</cfif>
<cfset nroutput=nroutput&media&"</a>) ["&label&" - "&catnum&"] "&DollarFormat(price)&"</p>">
<cfset lastGenre=thisgenre>
</cfloop>
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[DTDateUpdated],getDate()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[DTDateUpdated],getDate())<8  AND 
			((catItemsQuery.ONHAND)>0 OR (catItemsQuery.ONSIDE)>0) AND ONSIDE<>999 AND (catItemsQuery.albumStatusID)=23 AND reissue=0 AND genreID<>7 AND labelID<>2035 AND labelID<>1702 AND ONSIDE<>999
	order by genreID, artist
</cfquery>
<cfset nroutput=nroutput&"<hr noshade=""noshade"" />">
<cfset lastGenre="">
<cfloop query="catalogFind">
<cfif genre EQ "Dance"><cfset thisgenre="House"><cfelse><cfset thisgenre=genre></cfif>
<cfif thisgenre NEQ lastGenre>
	<cfset nroutput=nroutput&"<h1>"&thisgenre&" - Back In Stock</h1>">
</cfif>
<cfset nroutput=nroutput&"<p><a href=""http://www.downtown304.com/index.cfm?sID=#ID#""><b>"&artist&"</b> "&title&" (">
<cfif NRECSINSET GT 1>
	<cfset nroutput=nroutput&NRECSINSET&" x ">
</cfif>
<cfset nroutput=nroutput&media&")</a> ["&label&" - "&catnum&"] "&DollarFormat(price)&"</p>">
<cfset lastGenre=thisgenre>
</cfloop>
<cfif url.test>
<cfmail to="order@downtown304.com" cc="marianne@downtown304.com" from="info@downtown304.com" subject="#emailSubject#" type="html">

<!--

If the message below looks jumbled in Outlook and it is in your Junk Mail folder, click on the "NOT JUNK" button.
When the message is in your regular Inbox, it should look as it is intended.
If you still can't read the message below, just visit www.downtown304.com and click on New Releases.



//-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Downtown 304 New Releases</title>
<style type="text/css">
<!--
body {font-family: Arial, Helvetica, sans-serif; font-size: small;} 
td {font-family: Arial, Helvetica, sans-serif; font-size: small;} 
h1 {font-family: Arial, Helvetica, sans-serif; font-size: medium; color:##FF9933; margin-bottom: 0px;} 
p {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: xx-small; margin-top: 5px; margin-bottom: 5px; color: ##333333} 
blockquote {margin-left: 20px;} 
a:link {color:##000066; text-decoration:none;} 
a:visited {	color: ##000066; text-decoration:none;} 
a:hover {color:##FF9933; text-decoration:underline;} 
a:active {color: ##000066; text-decoration:none;} 
.style8 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: x-small;
	color: ##000000;
}
.style9 {
	font-size: small;
	font-family: Arial, Helvetica, sans-serif;
	color: ##FFFFFF;
}
.style10 {color: ##FFFFFF}
.style11 {
	color: ##999999;
	font-weight: bold;
}
.style13 {color: ##999999; font-weight: bold; font-style: italic; }
-->
</style>
</head>

<body>
<table border="0" align="center" cellpadding="0" cellspacing="0" width="599">
  <tr>
    <td><img src="http://www.downtown304.com/images/Downtown304_NR08A.jpg" width="599" height="164" alt="Downtown 304" /></td>
  </tr>
  <tr>
    <td bgcolor="##669934"><table width="100%" border="0" cellspacing="0" cellpadding="15">
      <tr>
        <td bgcolor="##669934"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td bgcolor="##E7F2DB"><table width="100%" border="0" cellspacing="0" cellpadding="10">
              <tr>
                <td>#nroutput#</td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td bgcolor="##669934">&nbsp;</td>
  </tr>
</table>
</body>
</html>
</cfmail>
<p>TEST EMAIL SENT</p>
<cfelse>
<cfmail query="EmailList" to="#Replace(email," ","","all")#" from="info@downtown304.com" subject="#emailSubject#" type="html">
<!--


If the message below looks jumbled in Outlook and it is in your Junk Mail folder, click on the "NOT JUNK" button.
When the message is in your regular Inbox, it should look as it is intended.
If you still can't read the message below, just visit www.downtown304.com and click on New Releases.



//-->

<cfinclude template="customersEmailNewsHTMLHead.cfm">
<table width="90%" border="0" cellspacing="0" cellpadding="20" align="center">
  <tr>
    <td>
#nroutput#
<hr noshade="noshade" />
</td>
  </tr>
</table>

</cfmail>
<p>DONE: <cfoutput>#EmailList.recordCount#</cfoutput> emails sent</p>
<p><cfoutput query="EmailList">
#name# &nbsp;&nbsp;#email#<br />
</cfoutput></p>
</cfif>