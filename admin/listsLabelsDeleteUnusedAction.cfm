<cfparam name="form.deleteLabels" default="">
<cfquery name="deleteLabels" datasource="#DSN#">
	delete
	from labels
	where ID IN (#form.deleteLabels#)
</cfquery>
Done.