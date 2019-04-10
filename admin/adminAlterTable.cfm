<cfquery name="adjustTable" datasource="#DSN#">
	alter table orders
	add dateUpdated DateTime
</cfquery>