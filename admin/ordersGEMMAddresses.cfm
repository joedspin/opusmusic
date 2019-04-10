<cfquery name="ordersWaiting" datasource="#DSN#">
	select *
	from GEMMBatchProcessing
	where Processed=0
	order by CustomerGMU
</cfquery>
<p>
<cfset lastCust=0>
<cfoutput query="ordersWaiting">
	<cfif CustomerGMU NEQ lastCust>
		<p>#ShiptoAttn#<br />
		#ShiptoStreet#<br />
		<cfif ShiptoStreet2 NEQ "">#ShiptoStreet2#<br /></cfif>
		<cfif ShiptoStreet3 NEQ "">#ShiptoStreet3#<br /></cfif>
		#ShiptoCity#, #ShiptoState# #ShiptoZip#<br />
		#ShiptoCountry#<br />
		#CustomerEMail#</p>
		<cfset lastCust=CustomerGMU>
	</cfif>
</cfoutput>