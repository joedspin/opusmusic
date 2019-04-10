<cfset pageName="CUSTOMERS">
<cfparam name="url.test" default="no">
<cfinclude template="pageHead.cfm">
		<p>Downtown 304 online admin tool</p>
		
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
</cfquery>
<cfparam name="url.oLd" default="8">
<cfparam name="url.oHd" default="-1">
<cfquery name="catalogFind" datasource="#DSN#">
	SELECT DateDiff(day,[releaseDate],Now()) AS thisDateDiff, *
	FROM catItemsQuery
	WHERE DateDiff(day,[releaseDate],Now())<#url.oLd# AND DateDiff(day,[releaseDate],Now())>#url.oHd# AND 
			((catItemsQuery.ONHAND)>0 OR (catItemsQuery.ONSIDE)>0) AND ((catItemsQuery.albumStatusID)<=22 AND 
			(catItemsQuery.albumStatusID)>=21)
	order by genreID, ReleaseDate DESC
</cfquery>
<cfset nroutput="Downtown 304 New Releases
#DateFormat(varDateODBC,"mmmm d, yyyy")#
http://www.downtown304.com

We have a new play list from <b>BRYAN JONES</b>.

Plus don't miss Timmy Regisford's (of Club Shelter, NYC) ""Timmy White Label"" release, ""Get Deep.""

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
<cfif url.test>
<cfmail to="order@downtown304.com" cc="marianne@downtown304.com" from="info@downtown304.com" subject="Downtown 304 New Releases #DateFormat(varDateODBC,"mmmm d, yyyy")# [TEST]">#nroutput#

__________________________________________________________________________________________
To unsubscribe from this list, reply and type REMOVE in the subject line
Do not reply to this address, it is not monitored.
</cfmail>
<p>TEST EMAIL SENT</p>
<cfelse>
<cfmail query="EmailList" to="#Replace(email," ","","all")#" from="info@downtown304.com" subject="Downtown 304 New Releases #DateFormat(varDateODBC,"mmmm d, yyyy")#">#nroutput#

__________________________________________________________________________________________
To unsubscribe from this list, click here: mailingListRemove.cfm?ID=#ID#&email=#email#

Do not reply to this address, it is not monitored. If you have questions or comments, please send them to order@downtown304.com.
</cfmail>
<p>DONE: <cfoutput>#EmailList.recordCount#</cfoutput> emails sent</p>
<p>
<cfoutput query="EmailList">
#name# &nbsp;&nbsp;#email#<br />
</cfoutput>
</p>
</cfif>