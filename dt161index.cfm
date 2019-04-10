<!--- BEGIN HIT COUNTER //--->
<!---<cfset thisPage = "home">//--->
<!---<cfset Session.cart=""><cfset Cookie.cart=""><cfset Session.orderID=""><cfset Cookie.orderID=0>//--->
<!---<cflock scope="Session" timeout="30" type="Exclusive">//--->
<cfparam name="referer" default="unknown">
<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cfparam name="url.logout" default="false">
<cfparam name="url.sID" default="">
<cfparam name="url.aPg" default="">
<cfparam name="url.private" default="donotallow">
<cfparam name="url.lf" default="">
<cfparam name="url.af" default="">
<cfparam name="url.group" default="">
<cfparam name="url.chartID" default="">
<cfparam name="url.artistID" default="">
<cfparam name="url.checkout" default="">
<cfparam name="url.list" default="none">
<cfset logoAppend="">
<cfset labelAppend="">
<cfset referer = cgi.http_referer>
<cfoutput><!--- R :: #referer# :: R //---></cfoutput>
<cfparam name="Session.hitThis" default="false">
<cfparam name="Session.labelSite" default="">
<cfif Session.labelSite NEQ "">
	<cfset logoAppend='?label='&Session.labelSite>
</cfif>
<cfif FindNoCase('traxsource',referer) NEQ 0>
	<cfset logPageName='traxsource'>
<cfelseif FindNoCase('myspace',referer) NEQ 0>
	<cfset logPageName='myspace'>
    <cfif url.lf EQ 599>
		<cfset logoAppend='?label=Ovum'>
		<cfset Session.labelSite='Ovum'>
	</cfif>
<cfelseif FindNoCase('amenti',referer) NEQ 0>
	<cfset logPageName='amentimusic'>
    <cfset labelAppend='1563'>
<cfelseif FindNoCase('objektivity',referer) NEQ 0>
	<cfset logPageName='objektivity'>
<cfelseif FindNoCase('ovum-rec',referer) NEQ 0>
	<cfset logPageName='ovum'>
    <cfif url.lf EQ 599>
		<cfset logoAppend='?label=Ovum'>
		<cfset Session.labelSite='Ovum'>
	</cfif>
<cfelseif FindNoCase('huddtrax',referer) NEQ 0>
	<cfset logPageName='huddtrax'>
	<cfset labelAppend='1644'>
<cfelseif FindNoCase('rongmusic',referer) NEQ 0>
	<cfset logPageName='rong'>
	<cfset labelAppend='&labelgroup=rong'>
<cfelseif FindNoCase('seasonsrecordings',referer) NEQ 0>
	<cfset logPageName='seasons'>
<cfelseif FindNoCase('westendrecords',referer) NEQ 0>
	<cfset logPageName='westend'>
<cfelseif FindNoCase('rhythmism',referer) NEQ 0>
	<cfset logPageName='rhythmism'>
<cfelse>
	<cfset logPageName='home'>
</cfif>
	<cfif NOT Session.hitThis>
		<cfquery name="updateHits" datasource="#DSN#">
			UPDATE hit_counter SET hit_count = hit_count + 1 where pagename=<cfqueryparam value="#logPageName#" cfsqltype="cf_sql_char">
		</cfquery>
	</cfif>
	<cfset Session.hitThis=true>
<!---</cflock>//--->
<!---<cfparam name="referer" default="unknown">
<cfset referer = cgi.http_referer>
<cfoutput><!-- REFERER: [[#referer#]] --></cfoutput>
<cfquery name="GetHits" datasource="#DSN#">
	SELECT hit_count, sinceDate FROM hit_counter WHERE pagename='#thisPage#'
</cfquery>
<cfif GetHits.recordcount is 0>
	<cfquery name="CreateHit" datasource="#DSN#">
		INSERT into hit_counter(pagename, hit_count, sinceDate)
		VALUES (
			<cfqueryparam value="#thisPage#" cfsqltype="CF_SQL_CHAR">,
			<cfqueryparam value="1" cfsqltype="cf_sql_integer">,
			<cfqueryparam value="#varDateODBC#" cfsqltype="CF_SQL_DATE">
			)
	</cfquery>
	<cfset thisHits=1>
	<cfset thisSince=#varDateODBC#>
<cfelse>
	<cfset thisHits=#GetHits.hit_count#>
	<cfset thisSince=#GetHits.sinceDate#>
</cfif>//--->
<!--- END HIT COUNTER //--->


<cflock scope="session" timeout="20" type="exclusive">
	<cfparam name="Session.userID" default="0">
	<cfparam name="Session.username" default="">
	<cfparam name="Session.orderID" default="0">
	<!---<cfparam name="Session.cart" default="">//--->
	<cfif url.logout>
		<cfset Session.userID="0">
		<cfset Session.username="">
		<cfset Session.orderID="0">
	</cfif>
</cflock>
<cfset loginfailed="">
<cfif form.username NEQ "">
	<cfif form.username EQ "bigkid">
	    <cflocation url="baduser.cfm">
    </cfif>
	<cfquery name="lookupUser" datasource="#DSN#">
		select ID, username
		from custAccounts
		where username=<cfqueryparam value="#form.username#" cfsqltype="cf_sql_char">
			AND password=<cfqueryparam value="#form.password#" cfsqltype="cf_sql_char">
	</cfquery>
	<cfif lookupUser.recordCount NEQ 0>
		<cfset Session.userID=lookupUser.ID>
		<cfset Session.username=lookupUser.username>
		<cfset Cookie.username=Session.username>
		<cfquery name="openOrder" datasource="#DSN#">
			select *
			from orders
			where custID=#lookupUser.ID# AND statusID=1
		</cfquery>
		<cflock scope="session" timeout="20" type="exclusive">
			<cfset Session.userID=lookupUser.ID>
			<cfset Session.username=lookupUser.username>
			<cfif openOrder.RecordCount GT 0>
				<cfset Session.orderID=openOrder.ID>
			<cfelse>
				<cfset Session.orderID=0>
			</cfif>
		</cflock>
     <cfelse>
     	<cfset loginfailed="?loginfailed=yes">
	</cfif>
</cfif>
<cfif url.sID NEQ "">
	<cfset mainPageURL="dt161main.cfm?sID=" & url.sID>
<cfelseif url.list EQ "wish">
	<cfset mainPageURL="profileWishList.cfm">
<cfelseif url.lf NEQ "" OR labelAppend NEQ "">
	<cfset mainPageURL="dt161main.cfm?lf=#url.lf##labelAppend#">
<cfelseif url.af NEQ "">
	<cfset mainPageURL="dt161main.cfm?af=#url.af#">
<cfelseif url.checkout EQ "start">
	<cfset mainPageURL="checkout.cfm">
<cfelse>
	<cfset mainPageURL="dt161landing.cfm">
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Downtown 161, New York - House, Dance, Disco, Club Vinyl 12" Singles for Wholesale Distribution</title>

</head>
<frameset cols="*,950,*" frameborder="no" border="0" framespacing="0" bordercolor="#333333" style="background-color:#333333;">
	<frame src="http://www.downtown304.com/DT161blank.cfm" name="opusviewblankleft" id="opusviewblankleft" title="opusviewblankleft"  />
	<frameset rows="138,36,50,*" frameborder="no" border="0" framespacing="0">
		<frameset cols="468,275,207" frameborder="no" border="0" framespacing="0" bordercolor="#333333" style="background-color:#333333;">
			<cfoutput><frame src="http://www.downtown304.com/dt161logo.cfm" name="opusviewlogo" id="opusviewlogo" title="opusviewlogo" noresize="noresize" scrolling="no" /></cfoutput>
			<frame src="http://www.downtown304.com/dt161player.cfm" name="opusviewplayer" id="opusviewplayer" title="opusviewplayer" noresize="noresize" scrolling="no" />
			<cfoutput><frame src="http://www.downtown304.com/dt161user.cfm#loginfailed#" name="opusviewuser" id="opusviewuser" title="opusviewuser" noresize="noresize" scrolling="no" /></cfoutput>
		</frameset>
		<frame src="http://www.downtown304.com/dt161find.cfm" name="opusviewsearch" id="opusviewsearch" title="opusviewsearch" noresize="noresize" scrolling="no" />
        <frame src="http://www.downtown304.com/dt161topnav.cfm" name="dt161nav" id="dt161nav" title="dt161nav" noresize="noresize" scrolling="no" />
			<cfoutput><frame src="http://www.downtown304.com/#mainPageURL#" name="opusviewmain" id="opusviewmain" title="opusviewmain" scrolling="yes" noresize="noresize" /></cfoutput>
			<!---<frame src="http://www.downtown304.com/dt161bins.cfm?checkout=#url.checkout#" name="opusviewbins" id="opusviewbins" title="opusviewbins" noresize="noresize" /></cfoutput>//--->
	<frame src="blankframe"></frameset>
	<frame src="http://www.downtown304.com/DT161blank.cfm" name="opusviewblankleft" id="opusviewblankleft" title="opusviewblankleft"  />
</frameset>
<noframes><body>
</body>
</noframes></html>
