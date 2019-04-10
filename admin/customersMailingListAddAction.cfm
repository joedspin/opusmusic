<cfparam name="form.name" default="">
<cfparam name="form.email" default="">
<cfif form.name EQ "" OR form.email EQ "">
	ERROR<cfabort>
<cfelse>
<cfquery name="checkML" datasource="#DSN#">
	select *
	from GEMMCustomers
	where email='#form.email#'
</cfquery>
<cfif checkML.recordCount EQ 0>
<cfquery name="addML" datasource="#DSN#">
	insert into GEMMCustomers (name, email, subscribe)
	values ('#form.name#','#form.email#',1)
</cfquery>
<cfquery name="newID" datasource="#DSN#">
	select Max(ID) as maxID
	from GEMMCustomers
	where email='#form.email#'
</cfquery>
<cfparam name="url.oLd" default="8">
<cfparam name="url.oHd" default="-1">
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[releaseDate],Now()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[releaseDate],Day())<#url.oLd# AND DateDiff(day,[releaseDate],Day())>#url.oHd# AND 
			((catItemsQuery.ONHAND)>0 OR (catItemsQuery.ONSIDE)>0) AND ((catItemsQuery.albumStatusID)<=22 AND 
			(catItemsQuery.albumStatusID)>=21)
	order by genreID, ReleaseDate DESC
</cfquery>
<cfset nroutput="Downtown 304 New Releases
#DateFormat(varDateODBC,"mmmm d, yyyy")#
http://www.downtown304.com

">
<cfset lastGenre="">
<cfloop query="catalogFind">
<cfif genre EQ "Dance"><cfset thisgenre="House"><cfelse><cfset thisgenre=genre></cfif>
<cfif thisgenre NEQ lastGenre>
	<cfset nroutput=nroutput&"
---------------------------
"&thisgenre&" - New Releases
---------------------------
">
</cfif>
<cfset nroutput=nroutput&UCase(artist)&"
"&title&" (">
<cfif NRECSINSET GT 1>
	<cfset nroutput=nroutput&NRECSINSET&" x ">
</cfif>
<cfset nroutput=nroutput&media&") ["&label&" - "&catnum&"] "&DollarFormat(price)&"

">
<cfset lastGenre=thisgenre>
</cfloop>
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[DTDateUpdated],Now()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[DTDateUpdated],Now())<#url.oLd# AND DateDiff(day,[DTDateUpdated],Now())>#url.oHd# AND 
			((catItemsQuery.ONHAND)>0 OR (catItemsQuery.ONSIDE)>0) AND (catItemsQuery.albumStatusID)=23
	order by genreID, DTDateUpdated DESC
</cfquery>
<cfset nroutput=nroutput&"

">
<cfset lastGenre="">
<cfloop query="catalogFind">
<cfif genre EQ "Dance"><cfset thisgenre="House"><cfelse><cfset thisgenre=genre></cfif>
<cfif thisgenre NEQ lastGenre>
	<cfset nroutput=nroutput&"
---------------------------
"&thisgenre&" - Back In Stock
---------------------------
">
</cfif>
<cfset nroutput=nroutput&UCase(artist)&"
"&title&" (">
<cfif NRECSINSET GT 1>
	<cfset nroutput=nroutput&NRECSINSET&" x ">
</cfif>
<cfset nroutput=nroutput&media&") ["&label&" - "&catnum&"] "&DollarFormat(price)&"

">
<cfset lastGenre=thisgenre>
</cfloop>
<cfmail to="#form.email#" bcc="order@downtown304.com" from="order@downtown304.com" subject="Downtown 304 New Releases #DateFormat(varDateODBC,"mmmm d, yyyy")#">#nroutput#

__________________________________________________________________________________________
To unsubscribe from this list, click here: mailingListRemove.cfm?ID=#newID.maxID#&email=#email#
</cfmail>
</cfif>
<cflocation url="customersMailingList.cfm">
</cfif>