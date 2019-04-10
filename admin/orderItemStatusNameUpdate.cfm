<cfquery name="updateStatusID" datasource="#DSN#">
	update orderItemStatus
	set name='Available ONSIDE'
	where ID=5
</cfquery>