<cfset backmax="-1">
<cfset referer = cgi.http_referer>
<cfoutput><!--- R :: #referer# :: R //---></cfoutput>
<cfparam name="Session.hitThis" default="false">
<cfparam name="Session.framesetloaded" default="false">
<!---<cfif FindNoCase('soulfuric.com',referer) NEQ 0>
	<cfset logPageName='soulfuric'>
    <cfif NOT Session.hitThis>
        <cfquery name="updateHits" datasource="#DSN#">
            UPDATE hit_counter SET hit_count = hit_count + 1 where pagename=<cfqueryparam value="#logPageName#" cfsqltype="cf_sql_char">
        </cfquery>
	</cfif>
    <cfset Session.hitThis=true>
    <cflocation url="opussitelayoutmain.cfm?group=soulfuric">
</cfif>//--->


<cfset hideTracks=0>
<cfset displayedID=0>
<cfset numItemsPerPage=300>
<!--<cfset Cookie.sortOrder="DESC">
<cfset Cookie.orderBy="releaseDate">//--->
<cfset blueDate="">
<cfparam name="url.ppoint" default="0">
<cfparam name="url.startbrowse" default="no">
<cfparam name="Session.userID" default="0">
<cfparam name="url.tshirts" default="stop">
<cfparam name="url.cID" default="0">
<cfparam name="url.emf" default="stop">
<cfparam name="url.clearit" default="">
<cfparam name="url.prerelease" default="donotallow">
<cfparam name="url.rsPage" default="1">
<cfparam name="url.sale" default="">
<cfparam name="url.sale2" default="">
<cfparam name="url.cartReset" default="false">
<cfparam name="url.sID" default="0">
<cfparam name="url.oLd" default="0">
<cfparam name="url.oHd" default="0">
<cfparam name="url.search" default="">
<cfparam name="url.searchString" default="">
<cfparam name="url.searchField" default="all">
<cfparam name="url.labelgroup" default="">
<cfif url.search NEQ ""><cfset form.search=url.search></cfif>
<cfif url.searchString NEQ ""><cfset form.searchString=url.searchString></cfif>
<cfif url.searchField NEQ "all"><cfset form.searchField=url.searchField></cfif>
<cfparam name="form.search" default="">
<cfparam name="form.searchString" default="">
<cfparam name="form.searchField" default="all">
<cfparam name="form.group" default="">
<!---<cfparam name="form.radiobutton" default="">
<cfparam name="form.submitted" default="">//--->
<cfparam name="url.group" default="">
<cfparam name="url.so" default="DESC">
<cfparam name="url.ob" default="releaseDate">
	
<cfparam name="Cookie.sortOrder" default="#url.so#">
<cfparam name="Cookie.orderBy" default="#url.ob#">
<cfparam name="url.lf" default="">
<cfparam name="url.af" default="">
<cfparam name="url.gf" default="">
<cfparam name="url.showAll" default="false">
<cfparam name="url.newused" default="false">
<cfparam name="url.salesort" default="price">
<cfparam name="url.salefilter" default="">
<cfif url.sID NEQ 0 AND Session.framesetloaded EQ "false" AND FindNoCase('downtown304.com',referer) EQ 0 AND FindNoCase('downtown161.com',referer) EQ 0><cflocation url="index.cfm?sId=#url.sID#"></cfif>
<cfif url.cID NEQ 0 AND Session.framesetloaded EQ "false" AND FindNoCase('downtown304.com',referer) EQ 0 AND FindNoCase('downtown161.com',referer) EQ 0><cflocation url="index.cfm?cID=#url.cID#"></cfif>
<cfif url.lf NEQ 0 AND Session.framesetloaded EQ "false" AND FindNoCase('downtown304.com',referer) EQ 0 AND FindNoCase('downtown161.com',referer) EQ 0><cflocation url="index.cfm?lf=#url.lf#"></cfif>
<cfif url.af NEQ 0 AND Session.framesetloaded EQ "false" AND FindNoCase('downtown304.com',referer) EQ 0 AND FindNoCase('downtown161.com',referer) EQ 0><cflocation url="index.cfm?af=#url.af#"></cfif>
<!---<cfif url.group NEQ "" AND url.af EQ "" AND url.lf EQ "" and url.sID EQ 0><cfcache timespan="#createTimeSpan(0,1,0,0)#"></cfif>//--->
<cfif url.clearit EQ "flush"><cfcache action="flush"></cfif>
<cfset thisFullImg="">
<cfif url.group NEQ ""><cfset form.group=url.group></cfif>
<!---<cfif form.searchstring NEQ "" OR form.search NEQ "" OR form.submitted EQ "submitted"><cfset Cookie.searchstring=form.searchstring></cfif>
<cfif form.radiobutton NEQ "" OR form.search NEQ "" OR form.submitted EQ "submitted"><cfset Cookie.radiobutton=form.radiobutton></cfif>
<cfif url.group NEQ ""><cfset Cookie.group=url.group></cfif>//--->
<cfif url.so EQ "ASC" OR url.so EQ "DESC"><cfset Cookie.sortOrder=url.so></cfif>
<cfif form.group NEQ "new">
	<cfif url.ob EQ "releaseDate">
		<cfif siteChoice EQ "304"><cfset Cookie.orderBy="releaseDate"><cfelse><cfset Cookie.orderBy="dtDateUpdated"></cfif>
		<cfset Cookie.sortOrder="DESC">
	<cfelse>
		<cfif url.ob NEQ ""><cfset Cookie.orderBy=HTMLEditFormat(url.ob)></cfif>
	</cfif>	
<cfelseif form.group EQ "back">
	<cfif url.ob EQ "releaseDate">
		<cfset Cookie.orderBy="dtDateUpdated">
		<cfset Cookie.sortOrder="DESC">
	<cfelse>
		<cfif url.ob NEQ ""><cfset Cookie.orderBy=HTMLEditFormat(url.ob)></cfif>
	</cfif>
<cfelse>
	<cfif url.ob NEQ ""><cfset Cookie.orderBy=HTMLEditFormat(url.ob)></cfif>
	<cfif Cookie.orderBy EQ "dtDateUpdated"><cfset Cookie.orderBy="releaseDate"></cfif>
</cfif>
<!---<cfif url.userReset>
	<cflock scope="session" timeout="20" type="exclusive">
		<cfset Session.userID=0>
		<cfset Session.username="">
	</cflock>
</cfif>//--->
<!---<cfoutput>orderID #Session.orderID# | userID #Session.userID#</cfoutput>//--->
<!---<cfif Cookie.cart NEQ "">
	<cflock scope="session" timeout="20" type="exclusive">
		<cfset Session.cart=Cookie.cart>
	</cflock>		
</cfif>//--->
<cfset groupString="=">
<cfset reissueString=" ">
<cfset statLow="18">
<cfset statHigh="24">
<cfset dateCompStr=">-1">
<cfset thisOB=url.ob>
<cfset ONSIDEswitch=" OR ONSIDE>0">
<cfset ONSIDE999="">
<cfset ONHANDswitch="">
<cfset labelExclusions="">
<cfset notNewSwitch="">
<cfset dateoption="nada">
<cfif form.group EQ "back" OR url.group EQ "back">
	<cfset backmax="600">
	<cfset groupString="=">
	<cfset statLow="22">
	<cfset statHigh="24">
	<cfset Cookie.orderBy="dtDateUpdated">
	<cfset thisOrderBy="dtDateUpdated">
	<cfset Cookie.sortOrder="DESC">
	<cfset thisSortOrder="DESC">
    <cfset dateOption="back">
	<cfif siteChoice EQ "304">
		<cfset ONSIDEswitch=" OR (ONSIDE>0 AND ONSIDE<>999)">
		<cfset reissueString="AND labelID<>754 AND labelID<>1702"> <!--- labelID<>2035...don't show House Party or Ear2DaStreet//--->
    </cfif>
<cfelseif form.group EQ "reissues">
	<cfset groupString="=">
	<cfset reissueString="AND (reissue=1 OR genreID=7)">
	<cfset Cookie.orderBy="dtDateUpdated"><cfset thisOrderBy="dtDateUpdated">
	<cfset Cookie.sortOrder="DESC"><cfset thisSortOrder="DESC">
<cfelseif form.group EQ "7inch">
	<cfset groupString="=">
	<cfset reissueString="AND (mediaID=11)">
    <cfset statLow="18">
	<cfset statHigh="24">
	<cfset ONSIDEswitch=" OR (ONSIDE>0 AND ONSIDE<>999)">
<cfelseif form.group EQ "gtsale">
	<cfset statLow="18">
	<cfset statHigh="24">
	<cfset ONSIDEswitch=" OR (ONSIDE>0 AND ONSIDE<>999)">
	<cfset groupString="=">
	<cfset reissueString="AND (vendorID=5439) AND NRECSINSET=1 AND mediaID=1 AND artistID NOT IN (3062,3113)">
    <cfif url.ob EQ ""><cfset Cookie.orderBy="dtDateUpdated"><cfset thisOrderBy="dtDateUpdated"></cfif>
	<cfif url.so EQ ""><cfset Cookie.sortOrder="DESC"><cfset thisSortOrder="DESC"></cfif>
<cfelseif form.group EQ "lps">
	<cfset statLow="18">
	<cfset statHigh="24">
	<cfset ONSIDEswitch=" OR (ONSIDE>0 AND ONSIDE<>999)">
	<cfset groupString="=">
	<cfset reissueString="AND mediaID=5">
    <cfif url.ob EQ ""><cfset Cookie.orderBy="dtDateUpdated"><cfset thisOrderBy="dtDateUpdated"></cfif>
	<cfif url.so EQ ""><cfset Cookie.sortOrder="DESC"><cfset thisSortOrder="DESC"></cfif>

</cfif>
<cfif Cookie.sortorder EQ "ASC"><cfset thisSortOrder="ASC"><cfelse><cfset thisSortOrder="DESC"></cfif>
<cfif Cookie.orderby EQ 'releaseDate' OR Cookie.orderby EQ 'dtDateUpdated' OR Cookie.orderby EQ 'artist' OR Cookie.orderby EQ 'title' OR Cookie.orderby EQ 'label'><cfset thisOrderBy=Cookie.orderby><cfelse><cfset thisOrderBy="releaseDate"></cfif>

<cfif form.group EQ "new" OR url.group EQ "new">
	<cfif siteChoice EQ "304">
		<cfset ONSIDEswitch=" OR (ONSIDE>0 AND ONSIDE<>999)">
        <cfset ONSIDE999="AND ONSIDE<>999">
        <cfset labelExclusions="AND labelID<>1702">
        <!---<cfset notNewSwitch="AND notNew304=0">//--->
        <cfset ONHANDswitch=", ONHAND DESC">
    </cfif>
    <cfset dateoption="new">
    <cfquery name="catFind" dbtype="query" maxrows="#backmax#">
                select *
                from Application.dt#siteChoice#Items
                where ((ONHAND>0  AND (albumStatusID<=22 OR albumStatusID=148)) OR ONSIDE>0 OR albumStatusID=30)
                    #labelExclusions# #notNewSwitch# #ONSIDE999#
                    AND releaseDate>'#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#'
                order by #thisOrderBy# #thisSortOrder##ONHANDswitch#
            </cfquery>
<cfelseif url.group EQ "whseven">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where mediaID=11 AND saleSave<>0
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "whtwo">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where price=2 AND saleSave<>0
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "whfive">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where price=5 AND saleSave<>0
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "whlp">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where mediaID=5 AND saleSave<>0
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "whcd">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where mediaID=2 AND saleSave<>0
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "whtwelve">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where price<>5 AND price<>2 AND saleSave<>0 AND mediaID=1
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.prerelease EQ "allow">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where albumStatusID=148
		order by ID DESC
	</cfquery>
<cfelseif form.searchField EQ "keywords">
    <cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where keywords<>'' AND keywords IS NOT NULL AND (LOWER(keywords) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="CF_SQL_CHAR">)
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "blue99">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where blue99=1
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.tshirts EQ "go">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where title LIKE '%T-Shirt%' AND albumStatusID<25 AND ONHAND>0 
		order by ID DESC
	</cfquery>
<cfelseif url.group EQ "classique" OR url.group EQ "classiques">
    <cfquery name="catFind" dbtype="query">
            select *
            from Application.dt#siteChoice#Items
            where shelfID IN (1064,2080)
            order by releaseDate DESC, price DESC
        </cfquery>
<cfelseif url.group EQ "specialItems">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where specialItem=1
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.ppoint NEQ 0>
	<cfif ppoint GT 3>
		<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where price=<cfqueryparam value="#url.ppoint-.01#" cfsqltype="CF_SQL_MONEY"> and blue99=1
			order by #thisOrderBy# #thisSortOrder#
			</cfquery><cfoutput>#url.ppoint-.01#</cfoutput>
	<cfelse>
		<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where price<<cfqueryparam value="#url.ppoint#" cfsqltype="CF_SQL_MONEY"> 
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
	</cfif>
<cfelseif url.group EQ "allsale">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where blue99=1
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "metro">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where vendorID=5650 AND shelfID=11
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "yearendmulti">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where mediaID IN (1,12,5) AND NRECSINSET>1 AND priceSave>0
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "yoshitoshi">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=814
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "longer">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where (mediaID=5 AND countryID>1) OR (NRECSINSET>1)
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "yellorange">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=163
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "fallout">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=72
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
 <cfelseif url.group EQ "amenti">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=1563
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
 <cfelseif url.group EQ "mawrecords">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=531
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
 <cfelseif url.group EQ "westend">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=793
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
 <cfelseif url.group EQ "wavemusic">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID IN (2303,1695)
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "chez">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=1849
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "ovum">
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=599 AND price<6
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif form.group EQ "ashford">
	<cfquery name="trackFind" dbtype="query">
        select DISTINCT itemID from #trackChoice#
            where LOWER(tName) LIKE '%ashford%'
        </cfquery><br />
		<cfset trackFindList="">
         <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<!---<cfif tfStart>//---><cfset trackFindList=trackFindList&","&itemID><!---<cfelse><cfset trackFindList=itemID></cfif>//--->
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where (LOWER(artist) LIKE '%ashford%' OR LOWER(title) LIKE '%ashford%' OR ID IN (39293,38517,41223,51111,53295#trackFindList#)) 
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "diving30" OR url.group EQ "diving50">
	<cfquery name="catFind" dbtype="query">
    	select *
		from Application.dt#siteChoice#Items
		where dtOLDID=#right(url.group,2)#
        order by #thisOrderBy# #thisSortOrder#
    </cfquery>
<cfelseif form.group EQ "donna">
	<cfquery name="trackFind" dbtype="query">
        select DISTINCT itemID from #trackChoice#
            where LOWER(tName) LIKE '%donna summer%'
        </cfquery><br />
		<cfset trackFindList="">
         <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<!---<cfif tfStart>//---><cfset trackFindList=trackFindList&","&itemID><!---<cfelse><cfset trackFindList=itemID></cfif>//--->
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where (LOWER(artist) LIKE '%donna summer%' OR LOWER(title) LIKE '%donna summer%' OR ID IN (46815,65432,64555,54784,53212,50671,44787#trackFindList#)) 
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif form.group EQ "larry">
	<cfquery name="trackFind" dbtype="query">
        select DISTINCT itemID from #trackChoice#
            where LOWER(tName) LIKE '%larry levan%' OR LOWER(tName) LIKE '%paradise garage%'
        </cfquery><br />
		<cfset trackFindList="">
         <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<!---<cfif tfStart>//---><cfset trackFindList=trackFindList&","&itemID><!---<cfelse><cfset trackFindList=itemID></cfif>//--->
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
	<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where labelID=5529 OR pgFlag=1 OR (LOWER(artist) LIKE '%larry levan%' OR LOWER(title) LIKE '%larry levan%' OR LOWER(artist) LIKE '%paradise garage%' OR LOWER(title) LIKE '%paradise garage%' OR ID IN (43305#trackFindList#)) 
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
<cfelseif url.group EQ "muted">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where ID IN (44624,44625,38928,41545,69420)
        order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "series"><!--- includes series and white labels (796)//--->
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where labelID IN (2038,706,2035,2239,2054,6807,2045,2042,6320,1858,796) AND (shelfID=11 OR price=4.99)
        order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "ones"><!--- includes series and white labels (796)//--->
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where ONHAND=1 AND albumStatusID<>21
        order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "discofunksoul">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where labelID IN (2038,706,2054)
        order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.group EQ "cds">
   <cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
        where ONSIDE<>999 AND ((albumStatusID<25 AND ONHAND>0) OR ONSIDE>0 OR albumStatusID=30) AND (mediaID=2 OR mediaID=3)
        order by releaseDate DESC
    </cfquery>
<cfelseif url.group EQ "sevens">
   <cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
        where ONSIDE<>999 AND ((albumStatusID<25 AND ONHAND>0) OR ONSIDE>0 OR albumStatusID=30) AND (mediaID=11)
        order by releaseDate DESC
    </cfquery>
<cfelseif url.sID NEQ 0 AND IsValid("integer",url.sID)><!--.find4.//-->
	<!---<cfif url.group EQ "preview">
    	<cfquery name="Application.dt#siteChoice#Items" datasource="#DSN#" maxrows="100" cachedwithin="#CreateTimeSpan(0,0,15,0)#">
		select *
		from catItemsQuery
		where ONHAND=0 AND ONSIDE=0 AND ((albumStatusID>27  AND left(shelfCode,1)<>'D' AND ID IN (select catItemID from purchaseOrderDetails where completed=0 AND qtyRequested>qtyReceived)) OR (albumStatusID=148 AND mp3Loaded=1)) AND
			dtDateUpdated>'#DateFormat(DateAdd('d',-90,varDateODBC),"yyyy-mm-dd")#' 
		order by dtDateUpdated DESC 
	</cfquery>
    </cfif>//--->
	<cfquery name="catFind" datasource="#DSN#">
		select *
		from catItemsQuery
		where ID=<cfqueryparam value="#url.sID#" cfsqltype="cf_sql_integer">
	</cfquery>
    <cfset pageName="item">
<!---<cfelseif url.oLd NEQ 0 AND url.oHd NEQ 0><!--.find5.//--><cfabort>
	<cfquery name="catFind" datasource="#DSN#">
		SELECT DateDiff(day,[releaseDate],Now()) AS thisDateDiff, *
		from Application.dt#siteChoice#Items 
		WHERE DateDiff(day,[releaseDate],Now())<#url.oLd# AND DateDiff(day,[releaseDate],Now())>#url.oHd# AND 
				((ONHAND)>0 OR (ONSIDE)>0) AND ((albumStatusID)<=22 And 
				(albumStatusID)>=21) AND genreID<>7 AND reissue<>yes
		order by #Cookie.orderBy# #Cookie.sortOrder#
	</cfquery>//--->
<cfelseif url.group EQ "preview">
	<!--- JTD 2015-12-19 removed ONHAND=0 AND  from the query below --->
	<cfquery name="catFind" datasource="#DSN#" maxrows="200" cachedwithin="#CreateTimeSpan(0,0,15,0)#">
		select *
		from catItemsQuery
		where albumStatusID=148 AND isVendor=1 AND ID IN (select catItemID from purchaseOrderDetails where completed=0 AND qtyRequested>qtyReceived) AND
			dtDateUpdated>'#DateFormat(DateAdd('d',-180,varDateODBC),"yyyy-mm-dd")#' 
		order by dtDateUpdated DESC 
	</cfquery>
<cfelseif url.group EQ "kerri">
		<cfquery name="trackFind" dbtype="query">
        select DISTINCT itemID from #trackChoice#
            where (LOWER(artist) LIKE '%kerri chandler%' OR
            LOWER(title) LIKE '%kerri chandler%' OR
            LOWER(tName) LIKE '%kerri chandler%')
            AND ONHAND>0 AND albumStatusID<25
        </cfquery>
        <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<cfif tfStart><cfset trackFindList=trackFindList&","&itemID><cfelse><cfset trackFindList=itemID></cfif>
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
		<cfquery name="catFind" dbtype="query">
            select * from Application.dt#siteChoice#Items where ID IN (#trackFindList#) OR ((LOWER(artist) LIKE '%kerri chandler%' OR
                    LOWER(title) LIKE '%kerri chandler%')
                    AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0) AND ONSIDE<>999)
                order by releaseDate DESC
        </cfquery>
<cfelseif url.group EQ "rare">
   <cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
        where (albumStatusID=44 AND ONSIDE>0 AND ONSIDE<>999) OR (albumStatusID=26 AND ONHAND>0)
        order by dtDateUpdated DESC
    </cfquery>
<cfelseif url.group EQ "under4">
   <cfquery name="catFind" dbtype="query">
	select *
        from Application.dt#siteChoice#Items
        where ((albumStatusID<25 AND ONHAND>0 AND ONSIDE<>999) OR ONSIDE>0) AND price<4
        order by #thisOrderBy# #thisSortOrder#
    </cfquery>
<cfelseif url.group EQ "under7">
   <cfquery name="catFind" dbtype="query">
	select *
        from Application.dt#siteChoice#Items
        where ((albumStatusID<25 AND ONHAND>0 AND ONSIDE<>999) OR ONSIDE>0) AND price<7
        order by #thisOrderBy# #thisSortOrder#
    </cfquery>
<cfelseif url.group EQ "france">
	<cfquery name="catFind" dbtype="query">
    	select *
        from Application.dt#siteChoice#Items
        where countryID=5
        order by label, artist
    </cfquery>
<cfelseif url.group EQ "sale">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where shelfCode='BS' OR (price<cost+1 AND labelID<>4158 AND price>0)
		ORDER BY #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.labelgroup EQ "rong">
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where labelID IN (5599,5197,1564,1677)
		order by catnum DESC
	</cfquery>
<cfelseif url.group EQ "underground">
    <cfquery name="catFind" dbtype="query">
        select *
        from Application.dt#siteChoice#Items
        where mediaID=1 AND NRECSINSET=1 AND shelfID IN (7,11,13) AND vendorID IN (5439)
        order by #thisOrderBy# #thisSortOrder#
    </cfquery>
<cfelseif form.group EQ "specialorder">
	<cfquery name="catFind" datasource="#DSN#">
    	select * from catItemsQuery
        where albumStatusID=30
        order by #thisOrderBy# #thisSortOrder#
    </cfquery>
<cfelseif url.lf EQ 6631>
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where labelID IN (6631,6666,1665,2828,1555,1679,4134)
		order by catnum DESC
	</cfquery>
<cfelseif url.lf NEQ "" and isNumeric(url.lf)><!--.find1.//-->
	<cfif url.lf EQ 1564><!--- rong label group //--->
    	<cfquery name="catFind" dbtype="query">
            select *
            from Application.dt#siteChoice#Items
            where labelID IN (5599,5197,1564,1677)
            order by catnum DESC
        </cfquery>
	<cfelseif url.lf EQ 2303><!--- wave  label group //--->
    	<cfquery name="catFind" dbtype="query">
            select *
            from Application.dt#siteChoice#Items
            where labelID IN (1695,1849,1969,2303,2506,3257,5931)
            order by catnum DESC
        </cfquery>
     <cfelseif url.lf EQ 1666><!--- Mr. K label, also include Danny Krivit and Mr. K as artist //--->
	 <cfquery name="trackFind" dbtype="query">
        	select DISTINCT itemID from #trackChoice#
            where (LOWER(artist) LIKE '%danny krivit%' OR
            	LOWER(artist) LIKE '%mr. k%' OR
                LOWER(title) LIKE '%danny krivit%' OR
                LOWER(title) LIKE '%mr. k%' OR
                LOWER(label) LIKE '%mr. k edit%' OR
                LOWER(tName) LIKE '%danny krivit%' OR
                LOWER(tName) LIKE '%mr. k%') AND ID<>48758
        </cfquery>
        <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<cfif tfStart><cfset trackFindList=trackFindList&","&itemID><cfelse><cfset trackFindList=itemID></cfif>
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
        <cfquery name="catFind" dbtype="query">
            select * from Application.dt#siteChoice#Items where (ID IN (#trackFindList#) OR
               ID IN (20392,39233,39280,39870,40093,40240,40325,40367,40681,40952,41183,41219,41271,42172,41418,41429,46868,48905) OR
            (LOWER(artist) LIKE '%danny krivit%' OR
            	LOWER(artist) LIKE '%mr. k%' OR
                LOWER(title) LIKE '%danny krivit%' OR
                LOWER(title) LIKE '%mr. k%' OR
                LOWER(label) LIKE '%mr. k edit%'))
                    AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0 OR albumStatusID=30) AND ONSIDE<>999 AND ID<>48758
                order by releaseDate DESC
        </cfquery>
    <cfelseif url.lf EQ 793>
    	<cfquery name="catFind" dbtype="query">
            select *
            from Application.dt#siteChoice#Items
            where labelID IN (793,1602,1861,3733,4239)
            order by catnum DESC
        </cfquery>
    <cfelse>
        <cfquery name="catFind" dbtype="query">
            select *
            from Application.dt#siteChoice#Items
            where labelID=<cfqueryparam value="#url.lf#" cfsqltype="cf_sql_integer">
            order by catnum DESC
        </cfquery>
    </cfif>
<cfelseif url.cID NEQ "" and isNumeric(url.cID) AND url.CID NEQ 0><!--.find1.//-->
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where countryID=<cfqueryparam value="#url.cID#" cfsqltype="cf_sql_integer">
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.gf NEQ "" and isNumeric(url.gf)><!--.find1.//-->
	<cfquery name="catFind" dbtype="query">
		select *
		from Application.dt#siteChoice#Items
		where genreID=<cfqueryparam value="#url.gf#" cfsqltype="cf_sql_integer">
		order by #thisOrderBy# #thisSortOrder#
	</cfquery>
<cfelseif url.af NEQ "" AND IsNumeric(url.af)><!--.find3.//-->
    <cfquery name="afArtist" dbtype="query">
		select *
		from Application.artists
		where ID=<cfqueryparam value="#url.af#" cfsqltype="cf_sql_integer">
	</cfquery>
	<cfif afArtist.name EQ ""><cfset searchArtist="NONE FOUND NO SEARCH"><cfelse><cfset searchArtist=afArtist.name></cfif>
     <cfquery name="trackFind" dbtype="query">
        select DISTINCT itemID from #trackChoice#
            where (LOWER(artist) LIKE <cfqueryparam value="%#LCase(searchArtist)#%" cfsqltype="cf_sql_char"> OR
            LOWER(title) LIKE '%#LCase(searchArtist)#%' OR
            LOWER(label) LIKE '%#LCase(searchArtist)#%' OR
            LOWER(tName) LIKE '%#LCase(searchArtist)#%')
            AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0 OR albumStatusID=30) AND ONSIDE<>999
        </cfquery>
        <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<cfif tfStart><cfset trackFindList=trackFindList&","&itemID><cfelse><cfset trackFindList=itemID></cfif>
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
        <!---<cfquery name="catFind" dbtype="query">
            select DISTINCT itemID, * from #trackChoice#
            where (LOWER(artist) LIKE <cfqueryparam value="%#LCase(searchArtist)#%" cfsqltype="cf_sql_char"> OR
            LOWER(title) LIKE '%#LCase(searchArtist)#%' OR
            LOWER(label) LIKE '%#LCase(searchArtist)#%' OR
            LOWER(tName) LIKE '%#LCase(searchArtist)#%')
            AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0 OR albumStatusID=30) AND ONSIDE<>999
                order by releaseDate DESC
        </cfquery>//--->
        <cfquery name="catFind" dbtype="query">
            select * from Application.dt#siteChoice#Items where ID IN (#trackFindList#) OR 
            	(LOWER(artist) LIKE <cfqueryparam value='%#LCase(searchArtist)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(title) LIKE <cfqueryparam value='%#LCase(searchArtist)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(label) LIKE <cfqueryparam value='%#LCase(searchArtist)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(catnum) LIKE <cfqueryparam value='%#LCase(searchArtist)#%' cfsqltype="cf_sql_char">)
                order by releaseDate DESC
        </cfquery>
        <!---<cfoutput>#trackFindList# | #form.searchString#</cfoutput><cfabort>//--->
<cfelse>
	<cfif form.searchField EQ "all">
	<cfif form.searchString NEQ ""><!--.find6.//-->
        <cfquery name="trackFind" dbtype="query">
        	select DISTINCT itemID from #trackChoice#
            where (LOWER(artist) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(title) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(label) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(tName) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(catnum) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char"> OR
                LOWER(keywords) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="CF_SQL_CHAR">)
                AND ((ONHAND>0 AND albumStatusID<25) OR ONSIDE>0 OR albumStatusID=30) AND ONSIDE<>999
        </cfquery>
        <cfif trackFind.recordCount GT 0>
        	<cfset tfStart=false>
            <cfloop query="trackFind">
            	<cfif tfStart><cfset trackFindList=trackFindList&","&itemID><cfelse><cfset trackFindList=itemID></cfif>
				<cfset tfStart=true>
            </cfloop>
        <cfelse>
        	<cfset trackFindList="0">
        </cfif>
        <cfquery name="catFind" dbtype="query">
            select * from Application.dt#siteChoice#Items where ID IN (#trackFindList#) OR 
            	((LOWER(artist) LIKE <cfqueryparam value='%#LCase(form.searchString)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(title) LIKE <cfqueryparam value='%#LCase(form.searchString)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(label) LIKE <cfqueryparam value='%#LCase(form.searchString)#%' cfsqltype="cf_sql_char"> OR
                    LOWER(catnum) LIKE <cfqueryparam value='%#LCase(form.searchString)#%' cfsqltype="cf_sql_char"> OR
                	LOWER(keywords) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="CF_SQL_CHAR">)
                    AND (((ONHAND>0 AND albumStatusID<25) OR ONSIDE> 0 OR albumStatusID=30) AND ONSIDE<>999))
                order by releaseDate DESC
        </cfquery>
	<cfelse><!--.find7.<cfoutput>#thisOrderBy# #thisSortOrder#</cfoutput>//-->
    	<cfif dateCompStr EQ "<75">
			<cfset dateTarget="AND Str(releaseDate)<'" & DateFormat(DateAdd('d',-75,varDateODBC),"yyyy-mm-dd")&"'">
        <cfelse>
        	<cfset dateTarget="">
        </cfif>
        <cfif dateoption EQ "new">
            <cfquery name="catFind" dbtype="query" maxrows="#backmax#">
                select *
                from Application.dt#siteChoice#Items
                where ((ONHAND>0  AND (albumStatusID<=<cfqueryparam value="#statHigh#" cfsqltype="cf_sql_integer"> AND 
                    albumStatusID>=<cfqueryparam value="#statLow#" cfsqltype="cf_sql_integer">)) #ONSIDEswitch# OR albumStatusID=30)
                    #reissueString# AND releaseDate>'#DateFormat(DateAdd('d',-75,varDateODBC),"yyyy-mm-dd")#' AND ONSIDE<>999
                order by #thisOrderBy# #thisSortOrder#
            </cfquery>
        <cfelseif dateoption EQ "nada">
            <cfquery name="catFind" dbtype="query" maxrows="#backmax#">
                select *
                from Application.dt#siteChoice#Items
                where ((ONHAND>0  AND (albumStatusID<=<cfqueryparam value="#statHigh#" cfsqltype="cf_sql_integer"> AND 
                    albumStatusID>=<cfqueryparam value="#statLow#" cfsqltype="cf_sql_integer">)) #ONSIDEswitch# OR albumStatusID=30)
                    #reissueString# AND ONSIDE<>999
                order by #thisOrderBy# #thisSortOrder#
            </cfquery>
        <cfelseif dateoption EQ "back">
        	<cfquery name="catFind" dbtype="query" maxrows="#backmax#">
                select *
                from Application.dt#siteChoice#Items
                where ((ONHAND>0  AND ((albumStatusID<=<cfqueryparam value="#statHigh#" cfsqltype="cf_sql_integer"> AND 
                    albumStatusID>=<cfqueryparam value="#statLow#" cfsqltype="cf_sql_integer">) OR albumStatusID=19 OR (albumStatusID=21 AND notNew304=1))) #ONSIDEswitch# OR albumStatusID=30)
                    #reissueString#  AND dtDateUpdated>'#DateFormat(DateAdd('d',-60,varDateODBC),"yyyy-mm-dd")#' AND ONSIDE<>999
                order by #thisOrderBy# #thisSortOrder#
            </cfquery>
        </cfif>
	</cfif>
	<cfelse><!--.find8.<cfoutput>#form.searchField# LIKE #form.searchString# </cfoutput>//-->
    	<cfif form.searchField EQ "label">
        	<cfset thisSearchField="label">
        <cfelseif form.searchField EQ "tname">
        	<cfset thisSearchField="tname">
         <cfelseif form.searchField EQ "artist">
        	<cfset thisSearchField="artist">
         <cfelseif form.searchField EQ "catnum">
        	<cfset thisSearchField="catnum">
         <cfelseif form.searchField EQ "title">
        	<cfset thisSearchField="title">
         </cfif>
		<cfquery name="catFind" dbtype="query">
			select *
			from Application.dt#siteChoice#Items
			where LOWER(#thisSearchField#) LIKE <cfqueryparam value="%#LCase(form.searchString)#%" cfsqltype="cf_sql_char">
			#reissueString#
			AND ((ONHAND>0  AND (albumStatusID<25)) OR ONSIDE>0 OR albumStatusID=30) AND ONSIDE<>999
			order by #thisOrderBy# #thisSortOrder#
		</cfquery>
	</cfif>
</cfif>