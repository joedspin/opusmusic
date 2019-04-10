<cfquery name="deleteSurface" datasource="#DSN#">
	delete *
	from shippingRates
	where name='Surface Mail'
</cfquery>