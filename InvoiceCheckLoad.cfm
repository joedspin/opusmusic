<cfif CGI.REMOTE_ADDR NEQ "184.75.37.35"><cfabort></cfif>
<cfsetting requesttimeout="6000" enablecfoutputonly="no">
<cfparam name="form.DTCatText" default="">
<cfparam name="form.uu" default="">
<cfparam name="form.pp" default="">
<cfif form.uu NEQ "DT161" OR form.pp NEQ "ggHy77Tjx8H">ERROR - Access Denied</cfif>
<cfif form.InvoiceCheck EQ "">
	ERROR
</cfif>
<cfquery name="setInvoiceFlag" datasource="#DSN#">
	update orderItems set dt161invoiceConfirm=1 where ID IN (#InvoiceCheck#)
</cfquery>
Done.