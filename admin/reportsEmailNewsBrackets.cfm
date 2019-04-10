<cfparam name="url.oLd" default="15">
<cfparam name="url.oHd" default="-1">
<cfset groupString="=">
<cfset statHigh="22">
<cfset reissueString="AND reissue=no"><!--- Show NEW/RECENT RELEASE catalog (albumStatus = 21, 22) //--->
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[releaseDate],#varDateODBC#) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[releaseDate],#varDateODBC#)<#url.oLd# AND DateDiff(day,[releaseDate],#varDateODBC#)>#url.oHd# AND 
			((catItemsQuery.ONHAND)>0 OR (catItemsQuery.ONSIDE)>0) AND ((catItemsQuery.albumStatusID)<=22 And 
			(catItemsQuery.albumStatusID)>=21) AND genreID<>7 AND reissue<>1
	order by ReleaseDate DESC
</cfquery>
<p>Downtown 304 New Releases<br />
     <cfoutput>#DateFormat(varDateODBC,"mmmm d, yyyy")#</cfoutput><br />
	 [url]http://www.downtown304.com[/url]<br /><br />
   <cfoutput query="catalogFind">
     
     [b]#artist#[/b]<br />
       #title#<br />
	   (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)<br />
  [#label# - #catnum#] #DollarFormat(price)#<br /><br />
</cfoutput></p>