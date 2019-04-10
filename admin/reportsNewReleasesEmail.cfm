<cfquery name="getImages" datasource="#DSN#" maxrows="20">
	select ID
    from catItemsQuery
    where albumStatusID=21 AND fullImg<>'' AND mediaID NOT IN (20,22,23,24) AND labelID NOT IN (1234)
    order by releaseDate DESC, ONHAND DESC
</cfquery>
<cfparam name="url.oLd" default="8">
<cfparam name="url.oHd" default="-7">
<!--- AND (left(ShelfCode,1)<>'D' OR labelID IN (72,2537,6131))//--->
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[releaseDate],getDate()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[releaseDate],getDate())<#url.oLd# AND DateDiff(day,[releaseDate],getDate())>#url.oHd# AND 
			((ONHAND>0 AND albumStatusID<=22) OR ONSIDE>0) AND ONSIDE<>999 
	order by releaseDate DESC, genreID, artist
</cfquery>
<cfset nroutput="">
<cfset lastGenre="">
<cfset lastDate="">
<cfloop query="catalogFind">
<cfif genre EQ "Dance"><cfset thisgenre="House"><cfelse><cfset thisgenre=genre></cfif>
<cfset thisDate=DateFormat(releaseDate,"mmmm d")>
<cfif thisDate NEQ lastDate><cfset nroutput=nroutput&"<h1 style=""font-family: Arial; margin-top:24px; margin-bottom:0px; font-weight: bold; font-size: large;"">"&thisDate&"</h1>"><cfset lastGenre=""></cfif>
<cfif thisgenre NEQ lastGenre>
	<cfset nroutput=nroutput&"<h2 style=""font-family: Arial; font-weight: bold; font-size: medium; margin-top:0px; margin-bottom:0px;"">"&thisgenre&" - New Releases</h2>">
</cfif>
<cfset nroutput=nroutput&"<p style=""font-family: Arial; margin-top:2px; margin-bottom:0px; font-size: small;""><a style=""font-family: Arial; font-size: small;"" href=""http://www.downtown304.com/index.cfm?sID=#ID#""><b>"&artist&"</b> "&title>
<cfset qualifications=" ">
<cfif remastered><cfset qualifications=qualifications&"[Remastered]"></cfif>
<cfif reissue><cfset qualifications=qualifications&"[Reissue]"></cfif>
<cfif warehouseFind><cfset qualifications=qualifications&"[Warehouse Find]"></cfif>
<cfif vinyl180g><cfset qualifications=qualifications&"[180g Vinyl]"></cfif>
<cfif repress><cfset qualifications=qualifications&"[Re-press]"></cfif>
<cfif notched><cfset qualifications=qualifications&"[Notched]"></cfif>
<cfif limitedEdition><cfset qualifications=qualifications&"[Limited Edition]"></cfif>
<cfset nroutput=nroutput&Replace(qualifications,"][",", ","all")&" (">
<cfif NRECSINSET GT 1>
	<cfset nroutput=nroutput&NRECSINSET&" x ">
</cfif>
<cfset nroutput=nroutput&media&"</a>) ["&label&" - "&catnum&"] "&DollarFormat(price)&"</p>">
<cfset lastGenre=thisgenre>
<cfset lastDate=thisDate>
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
	<cfset nroutput=nroutput&"<h1 style=""font-family: Arial; margin-top:24px; margin-bottom:0px; font-weight: bold; font-size: medium;"">"&thisgenre&" - Back In Stock</h1>">
</cfif>
<cfset nroutput=nroutput&"<p style=""font-family: Arial; margin-top:2px; margin-bottom:0px; font-size: small;""><a style=""font-family: Arial; font-size: small;"" href=""http://www.downtown304.com/index.cfm?sID=#ID#""><b>"&artist&"</b> "&title>
<cfset qualifications=" ">
<cfif remastered><cfset qualifications=qualifications&"[Remastered]"></cfif>
<cfif reissue><cfset qualifications=qualifications&"[Reissue]"></cfif>
<cfif warehouseFind><cfset qualifications=qualifications&"[Warehouse Find]"></cfif>
<cfif vinyl180g><cfset qualifications=qualifications&"[180g Vinyl]"></cfif>
<cfif repress><cfset qualifications=qualifications&"[Re-press]"></cfif>
<cfif notched><cfset qualifications=qualifications&"[Notched]"></cfif>
<cfif limitedEdition><cfset qualifications=qualifications&"[Limited Edition]"></cfif>
<cfset nroutput=nroutput&Replace(qualifications,"][",", ","all")&" (">
<cfif NRECSINSET GT 1>
	<cfset nroutput=nroutput&NRECSINSET&" x ">
</cfif>
<cfset nroutput=nroutput&media&")</a> ["&label&" - "&catnum&"] "&DollarFormat(price)&"</p>">
<cfset lastGenre=thisgenre>
</cfloop>
<p><a href="http://www.downtown304.com"><img src="http://www.downtown304.com/images/Downtown304_NewReleases_June2014a.jpg" width="750" usemap="#bannermap" border="0">
    <map name="bannermap">
      <area shape="rect" coords="14,148,172,171" href="https://www.facebook.com/downtown304" alt="facebook">
      <area shape="rect" coords="188,148,335,171" href="https://twitter.com/dt304" alt="@dt304">
      <area shape="rect" coords="353,148,518,171" href="http://www.instagram.com/downtown304" alt="@downtown304">
      <area shape="rect" coords="539,149,742,171" href="https://soundcloud.com/downtown304" alt="downtown304">
      <area shape="rect" coords="10,6,737,143" href="http://www.downtown304.com">
    </map>
</a></p>
<style>
h1 {font-family: Arial, Helvetica, sans-serif; line-height:normal; margin-top: 24px; margin-bottom: 0px; font-weight: bold; font-size: small;}
h2 {font-family: Arial, Helvetica, sans-serif; line-height:normal; margin-top: 0px; margin-bottom: 0px; font-size: x-small;}
body {font-family: Arial, Helvetica, sans-serif; line-height:normal; margin-top: 0px; margin-bottom: 0px; font-size: xx-small;}
p {margin-top: 0px; margin-bottom: 0px; }
</style>
<cfset iCount=0><cfoutput query="getImages"><cfset iCount=iCount+1><cfif iCount EQ 6 OR iCount EQ 11 OR iCount EQ 16><br /></cfif><a href="http://www.downtown304.com/index.cfm?sID=#ID#"><img src="http://www.downtown304.com/images/items/oI#ID#full.jpg" width="150" height="150" border="0" /></a></cfoutput>
<cfoutput>#nroutput#</cfoutput>