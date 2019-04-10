<cfquery name="getImages" datasource="#DSN#" maxrows="16">
	select ID
    from catItemsQuery
    where (albumStatusID=21 OR ONSIDE>0) AND jpgLoaded=1 AND ONSIDE<>999 AND mediaID NOT IN (20,22,23,24)
    order by releaseDate DESC, ONHAND DESC
</cfquery>
<cfparam name="url.oLd" default="8">
<cfparam name="url.oHd" default="-14">
<!--- AND (left(ShelfCode,1)<>'D' OR labelID IN (72,2537,6131))//--->
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT *
	FROM catItemsQuery
	WHERE price IN (0.99,1.99,2.99,3.99,4.99,5.99,6.99,8.99,9.99) AND albumStatusID<25 AND ONHAND>0
	order by label, catnum
</cfquery>
<cfset nroutput="">
<cfset lastGenre="">
<cfset lastDate="">
<cfloop query="catalogFind">
<cfset nroutput=nroutput&"<p>"&UCase(label)&" - <b>"&artist&"</b> "&title&" (">
<cfif NRECSINSET GT 1>
	<cfset nroutput=nroutput&NRECSINSET&" x ">
</cfif>
<cfset nroutput=nroutput&media&") ["&catnum&"] "&DollarFormat(price)&"</p>">
</cfloop>

<p><a href="http://www.downtown304.com"><img src="http://www.downtown304.com/images/Downtown304_NewReleases_0809.jpg" width="650" border="0"/></a></p>
<style>
h1 {font-family: Arial, Helvetica, sans-serif; line-height:normal; margin-top: 24px; margin-bottom: 0px; font-weight: bold; font-size: small;}
h2 {font-family: Arial, Helvetica, sans-serif; line-height:normal; margin-top: 0px; margin-bottom: 0px; font-size: x-small;}
body {font-family: Arial, Helvetica, sans-serif; line-height:normal; margin-top: 0px; margin-bottom: 0px; font-size: xx-small;}
p {margin-top: 0px; margin-bottom: 0px; }
</style>
<cfset iCount=0><cfoutput query="getImages"><cfset iCount=iCount+1><cfif iCount EQ 9><br /></cfif><a href="http://www.downtown304.com/index.cfm?sID=#ID#"><img src="http://www.downtown304.com/images/items/oI#ID#.jpg" hspace="3" vspace="8" border="0" /></a></cfoutput>
<cfoutput>#nroutput#</cfoutput>