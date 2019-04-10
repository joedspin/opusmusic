<cfsetting requesttimeout="6000">
<cfquery name="existingCust" datasource="#DSN#">
	select Max(ID) as maxID from GEMMCustomers
</cfquery>
<p><cfoutput>previous high ID: #existingCust.maxID#</cfoutput></p>
<!---<cfquery name="DT" datasource="#DSN#">
	select *
	from DowntownWebsiteResponders
</cfquery>
<cfloop query="DT">
	<cfquery name="checkML" datasource="#DSN#">
		select *
		from GEMMCustomers
		where email='#email#'
	</cfquery>
	<cfif checkML.recordCount EQ 0>
		<cfquery name="addML" datasource="#DSN#">
			insert into 
			GEMMCustomers (name, email, subscribe)
			values ('#name#','#email#',yes)
		</cfquery>
	</cfif>
</cfloop>//--->
<cfquery name="GEMM" datasource="#DSN#">
	select CustomerEmail, ShipToAttn
	from GEMMBatchProcessing
</cfquery>
<cfloop query="GEMM">
	<cfquery name="checkML" datasource="#DSN#">
		select *
		from GEMMCustomers
		where email='#CustomerEmail#'
	</cfquery>
	<cfif checkML.recordCount EQ 0>
		<cfquery name="addML" datasource="#DSN#">
			insert into GEMMCustomers (name, email, subscribe)
			values ('#ShipToAttn#','#CustomerEmail#',yes)
		</cfquery>
		<cfoutput>#ShipToAttn# [#CustomerEmail#]<br /></cfoutput>
	</cfif>
</cfloop>
<!---<cfquery name="opus" datasource="#DSN#">
	select *
	from custAccounts
</cfquery>
<cfloop query="opus">
	<cfquery name="checkML" datasource="#DSN#">
		select *
		from GEMMCustomers
		where email='#email#'
	</cfquery>
	<cfif checkML.recordCount EQ 0>
		<cfquery name="addML" datasource="#DSN#">
			insert into GEMMCustomers (name, email, subscribe)
			values ('#firstName# #lastName#','#email#',yes)
		</cfquery>
	</cfif>
</cfloop>//--->
