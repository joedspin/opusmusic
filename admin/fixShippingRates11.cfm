
<cfquery name="fixShipping" datasource="#DSN#">
	update shippingRates
    set cost1Record=cost1Record+.50
</cfquery>	