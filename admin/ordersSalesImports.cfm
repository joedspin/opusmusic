<cfloop from="2006" to="2007" index="y">
<cfloop from="1" to="12" index="x">
<cfquery name="sales" datasource="#DSN#">
	select *
	from orderItemsQuery
	where statusID=6 AND DatePart('m',datePurchased)=#x# AND DatePart('yyyy',datePurchased)=#y# AND shelfCode='SY'
	order by datePurchased
</cfquery>
<cfset salesTotal=0>
<cfoutput query="sales">
<!---#DateFormat(datePurchased,"yyyy-mm-dd")# #DollarFormat(orderSub)#<br />//--->
<cfset salesTotal=salesTotal+price>
</cfoutput>
<cfoutput>
<p>#x#/200#y#<br />
<b>#DollarFormat(salesTotal)#</b></p>
</cfoutput>
</cfloop>
</cfloop>