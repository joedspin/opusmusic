<cfsetting requesttimeout="6000">
<cfquery name="allML" datasource="#DSN#">
	select *
	from GEMMCustomers
</cfquery>
<cfloop query="allML">
	<cfquery name="checkML" datasource="#DSN#">
		select *
		from GEMMCustomers
		where email='#email#'
	</cfquery>
	<cfif checkML.recordCount GT 1>
		<cfquery name="killDups" datasource="#DSN#">
			delete *
			from GEMMCustomers
			where email='#email#' AND ID<>#ID#
		</cfquery>
	</cfif>
</cfloop>