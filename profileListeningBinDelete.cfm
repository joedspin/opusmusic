<cfparam name="url.ID" default="0">
<cfquery name="deleteBackorder" datasource="#DSN#">
	delete
    from listenBin
    where ID=<cfqueryparam value="#url.ID#" cfsqltype="cf_sql_char">
</cfquery>
<cflocation url="profileListeningBin.cfm">