<cfquery name="checkFlag" datasource="#DSN#">
	select *
	from orders
	where oFlag1=true
</cfquery>
<cfoutput>#checkFlag.recordCount#</cfoutput>