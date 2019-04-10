<cfset y1=DateFormat(varDateODBC,"yyyy")-1>
<cfset y2=DateFormat(varDateODBC,"yyyy")>
<cfoutput>#y1# #y2#</cfoutput>
<table border=1 style="border-collapse: collapse;" cellpadding="3" cellspacing="0">
<cfloop from="#y1#" to="#y2#" index="y">
	<cfloop from="1" to="12" index="x">
		<cfquery name="sales" datasource="#DSN#">
			select Sum(orderSub) As monthOrderSub
			from orders
			where statusID=6 AND DatePart('m',datePurchased)=#x# AND DatePart('yyyy',datePurchased)=#y# AND custID<>2126
			group by statusID, datePurchased, orderSub
			order by datePurchased
		</cfquery>
		<cfset salesTotal=0>
		<cfset yearTotal1=0>
		<cfset yearTotal2=0>
		<cfoutput query="sales">
			<cfset salesTotal=salesTotal+monthOrderSub>
			<cfif y EQ y1>
				<tr>
					<td>#DateFormat(x,"mmmm")# #DateFormat(y,"yyyy")#</td>
					<td><b>#DollarFormat(salesTotal)#</b></td>
				<cfset yearTotal1=yearTotal1+monthOrderSub>
			</cfif>
			<cfif y EQ y2>
					<td>#DateFormat(x,"mmmm")# #DateFormat(y,"yyyy")#</td>
					<td><b>#DollarFormat(salesTotal)#</b></td>
				</tr>
				<cfset yearTotal2=yearTotal2+monthOrderSub>
			</cfif>
		</cfoutput>
	</cfloop>
</cfloop>
</table>