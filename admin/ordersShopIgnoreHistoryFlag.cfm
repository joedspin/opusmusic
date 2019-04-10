<cfparam name="url.prevItemID" default="0">
<cfparam name="url.ignoreAll" default="">
<cfif url.prevItemID NEQ 0>
	<cfquery name="flagIgnoreHistory" datasource="#DSN#">
		update orderItems
		set ignoreHistory=1
		where ID=<cfqueryparam value="#url.prevItemID#" cfsqltype="cf_sql_integer">
	</cfquery>
</cfif>
<cfif url.ignoreAll NEQ "">
	<cfquery name="flagIgnoreHistory" datasource="#DSN#">
		update orderItems
		set ignoreHistory=1
		where ID IN (#url.ignoreAll#)
	</cfquery>
</cfif>
<html>
<body onload="window.close()">
Done
	</body>
	</html>