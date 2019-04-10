<cfparam name="url.email" default="noemailprovided">
<cfquery name="unsub" datasource="#DSN#">
	update GEMMBatchProcessingQuery
	set StatusCode='999'
	where CustomerEMail='#url.email#'
</cfquery>
<cflocation url="customersGEMM.cfm">