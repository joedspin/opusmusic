<cfparam name="url.ID" default="0">
<cfparam name="url.letter" default="a">
<cfquery name="deleteML" datasource="#DSN#">
	delete * from GEMMCustomers
	where ID=#url.ID#
</cfquery>
<cflocation url="customersMailingList.cfm?letter=#url.letter#">