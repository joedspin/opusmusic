<cfquery name="fixOrdersGEMM" datasource="#DSN#">
	update orders
	set otherSiteID=1 where isGEMM=1
</cfquery>
