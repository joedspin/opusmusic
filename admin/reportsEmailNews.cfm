<cfparam name="url.oLd" default="15">
<cfparam name="url.oHd" default="-1">
<cfset groupString="=">
<cfset statHigh="22">
<cfset reissueString="AND reissue=no"><!--- Show NEW/RECENT RELEASE catalog (albumStatus = 21, 22) //--->
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[releaseDate],Now()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[releaseDate],Now())<#url.oLd# AND DateDiff(day,[releaseDate],Now())>#url.oHd# AND 
			((catItemsQuery.ONHAND)>0 OR (catItemsQuery.ONSIDE)>0) AND ((catItemsQuery.albumStatusID)<=22 And 
			(catItemsQuery.albumStatusID)>=21) AND genreID<>7 AND reissue<>yes
	order by ReleaseDate DESC
</cfquery>
&lt;p&gt;&lt;Downtown 304 New Releases&lt;br&gt;
     #DateFormat(varDateODBC,"mmmm d, yyyy")#&lt;br&gt;
	 &lt;a href="http://www.downtown304.com"&gt;www.downtown304.com&lt;/a&gt;&lt;/p&gt;
   <cfoutput query="catalogFind">
     &lt;p&gt;&lt;b&gt;#artist#&lt;br&gt;
       #title#&lt;br&gt;  (<cfif NRECSINSET GT 1>#NRECSINSET#&nbsp;x&nbsp;</cfif>#media#)&lt;br&gt;
  [#label# - #catnum#] #DollarFormat(price)#&lt;/p&gt;     
</cfoutput>