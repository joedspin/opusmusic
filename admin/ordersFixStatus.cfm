<cfparam name="url.ID" default="0">
<cfparam name="url.statusID" default="0">
<cfquery name="fixStatus" datasource="#DSN#">
	update orders
	set statusID=#url.statusID#
	where ID=#url.ID#
</cfquery>
<cfoutput>Updated status to #url.statusID# on Order ###url.ID#</cfoutput>