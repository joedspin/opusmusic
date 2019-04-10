<cfquery name="countOrdersShipped" datasource="#DSN#">
	select Count(ID) As countshippedorders from orders where statusID=6 group by statusID
</cfquery>
<cfoutput query="countOrdersShipped">
#countshippedorders#<br>
</cfoutput>
<cfquery name="oldestOrderNumber" datasource="#DSN#" maxrows="1">
	select ID from orders order by ID
</cfquery>
<cfoutput query="oldestOrderNumber">
	#ID#
</cfoutput>