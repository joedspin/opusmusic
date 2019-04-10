<cfset y=DateFormat(varDateODBC,"yyyy")>
<cfset q=1>
<cfset quarterlySalesTotal=0>
<cfset quarterlyTaxTotal=0>
<cfset quarterlyShippingTotal=0>
<cfloop from="1" to="12" index="x">
<cfif x/3 EQ int(x/3)>
	<cfoutput><p>Q#q# total (sales+shipping) = #DollarFormat(quarterlySalesTotal+quarterlyShippingTotal)#<br />
	Q#q# Tax Collected = #DollarFormat(quarterlyTaxTotal)#</p></cfoutput>
	<hr noshade />
	<cfset q=q+1>
	<cfset quarterlySalesTotal=0>
	<cfset quarterlyTaxTotal=0>
	<cfset quarterlyShippingTotal=0>
</cfif>
<cfquery name="sales" datasource="#DSN#">
	select *
	from orders
	where statusID=6 AND DatePart('m',datePurchased)=#x# AND DatePart('yyyy',datePurchased)=#y# AND orderTax>0
	order by datePurchased
</cfquery>
<cfset salesTaxTotal=0>
<cfset salesTotal=0>
<cfset shippingTotal=0>
<cfloop query="sales">
	<cfset salesTotal=salesTotal+orderSub>
	<cfset salesTaxTotal=salesTaxTotal+orderTax>
	<cfset shippingTotal=shippingTotal+orderShipping>
</cfloop>
<cfoutput>
<p>#x#/2007<br />
<b>Taxable sales #DollarFormat(salesTotal+shippingTotal)#</b><br />
<b>Sales Tax Collected: #DollarFormat(salesTaxTotal)#</b></p>
<cfset quarterlySalesTotal=quarterlySalesTotal+salesTotal>
<cfset quarterlyTaxTotal=quarterlyTaxTotal+salesTaxTotal>
<cfset quarterlyShippingTotal=quarterlyShippingTotal+shippingTotal>
</cfoutput>
</cfloop>