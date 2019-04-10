<cfquery name="getImages" datasource="#DSN#" maxrows="16">
	select ID
    from catItemsQuery
    where albumStatusID=21 AND jpgLoaded=1
    order by releaseDate DESC
</cfquery>
<cfparam name="url.oLd" default="8">
<cfparam name="url.oHd" default="-1">
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[releaseDate],getDate()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[releaseDate],getDate())<#url.oLd# AND DateDiff(day,[releaseDate],getDate())>#url.oHd# AND 
			(ONHAND>0 OR ONSIDE>0) AND ONSIDE<>999 AND (albumStatusID<=22 AND albumStatusID>=21)
	order by releaseDate DESC, genreID, artist
</cfquery>
<cfset nroutput="">
<cfset lastGenre="">
<cfset lastDate="">
<cfloop query="catalogFind">
<cfif genre EQ "Dance"><cfset thisgenre="House"><cfelse><cfset thisgenre=genre></cfif>
<cfset thisDate=DateFormat(releaseDate,"mmmm d")>
<cfif thisDate NEQ lastDate><cfset nroutput=nroutput&"<p>"&thisDate&"<br>"><cfset lastGenre=""></cfif>
<cfif thisgenre NEQ lastGenre>
	<cfset nroutput=nroutput&thisgenre&" - New Releases<br>">
</cfif>
<cfset nroutput=nroutput&UCase(artist)&" "&title&" (">
<cfif NRECSINSET GT 1>
	<cfset nroutput=nroutput&NRECSINSET&" x ">
</cfif>
<cfset nroutput=nroutput&media&") "&label&"<br>">
<cfset lastGenre=thisgenre>
<cfset lastDate=thisDate>
</cfloop>
<cfset iCount=0>
<cfoutput>#nroutput#</cfoutput>