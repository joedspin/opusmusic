<cfquery name="shippingupdate" datasource="#DSN#">
	update shippingRates
    set cost1Record=22.90,
    costplusRecord=2.75,
    cost1CD=0,
    costplusCD=0
    where cost1Record=15.00 AND costplusRecord=2.50
</cfquery>
