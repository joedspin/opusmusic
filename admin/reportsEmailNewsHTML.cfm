<cfparam name="url.oLd" default="15">
<cfparam name="url.oHd" default="-1">
<cfset groupString="=">
<cfset statHigh="22">
<cfset reissueString="AND reissue=no"><!--- Show NEW/RECENT RELEASE catalog (albumStatus = 21, 22) //--->
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[releaseDate],getDate()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[releaseDate],getDate())<#url.oLd# AND DateDiff(day,[releaseDate],getDate())>#url.oHd# AND 
			((catItemsQuery.ONHAND)>0 OR (catItemsQuery.ONSIDE)>0) AND ONSIDE<>999 AND ((catItemsQuery.albumStatusID)<=22 And 
			(catItemsQuery.albumStatusID)>=21) AND genreID<>7 AND reissue<>1
	order by genreID, ReleaseDate DESC
</cfquery>
&lt;style type="text/css"&gt;
&lt;!--
body {font-family:Verdana, Arial, Helvetica, sans-serif; font-size: x-small;} 
td {font-family:Verdana, Arial, Helvetica, sans-serif; font-size: small;} 
h1 {font-family:Verdana, Arial, Helvetica, sans-serif; font-size: x-small; color:#FF9933; margin-bottom: 0px;} 
p {font-family:Verdana, Arial, Helvetica, sans-serif; font-size: xx-small; margin-top: 8px; margin-bottom: 8px; color: #333333} 
blockquote {margin-left: 20px;} 
a:link {color:#000066; text-decoration:none;} 
a:visited {	color: #000066; text-decoration:none;} 
a:hover {color:#FF9933; text-decoration:underline;} 
a:active {color: #000066; text-decoration:none;} 
.style4 {color: #666666;
	font-size: xx-small;
	font-weight: normal;
	margin-top: 0px;
	margin-bottom: 0px;}
.style5 {color: #000066}
.style6 {
	color: #FF9933;
	font-size: x-small;
	font-weight: bold;
	margin-bottom: 0px;
}
--&gt;
&lt;/style&gt;
&lt;p&gt;&lt;a href="http://www.downtown304.com"&gt;&lt;img src="http://www.downtown304.com/images/Downtown304NR.jpg" width="550" height="160" border="0" /&gt;&lt;/a&gt;&lt;/p&gt;
&lt;table width=550 border=0 cellpadding=0 cellspacing=0&gt;
&lt;tr&gt;
&lt;td&gt;
&lt;p&gt;Downtown 304 New Releases&lt;br&gt;
    <cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#&lt;br&gt;</cfoutput>
	 &lt;a href="http://www.downtown304.com"&gt;www.downtown304.com&lt;/a&gt;&lt;/p&gt;
<cfset lastGenre="">
<cfoutput query="catalogFind">
<cfif genre EQ "Dance"><cfset thisgenre="House"><cfelse><cfset thisgenre=genre></cfif>
<cfif thisgenre NEQ lastGenre>
	&lt;h1&gt;#thisgenre#&lt;/h1&gt;
</cfif>
&lt;p&gt;&lt;a href="http://www.downtown304.com/index.cfm?sID=#ID#"&gt;&lt;b&gt;#artist#&lt;/b&gt;&lt;br&gt;#title# (<cfif NRECSINSET GT 1>#NRECSINSET# x </cfif>#media#&lt;/a&gt;) [#label# - #catnum#] #DollarFormat(price)#&lt;br&gt;&nbsp;&lt;/p&gt;<cfset lastGenre=thisgenre>
</cfoutput>
&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;