<cfquery name="fixGEMM" datasource="#DSN#">
	update orders
	set adminPayID=1 where ID=272 OR ID=289 OR ID=290
</cfquery>