<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfquery name="removeML" datasource="#DSN#">
	update GEMMCustomers
	set subscribe=1
	where ID=#url.ID#
</cfquery>
<cflocation url="customersMailingList.cfm?letter=#url.letter#">