<cfquery name="fixsale" datasource="#DSN#">
	update catItems
	set saleSave=0 where saleSave=price
</cfquery>