<cfparam name="url.ID" default="0">
<cfif url.ID NEQ 0>
	<cfquery name="deleteAddres" datasource="#DSN#">
		delete *
		from custAddresses
		where ID=#url.ID#
	</cfquery>
</cfif>
<cflocation url="profileAddresses.cfm">