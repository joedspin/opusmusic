<cfquery name="checkFeaturelabels" datasource="#DSN#">
	select *
	from labels
	where featured=1
</cfquery>
<cfoutput query="checkFeaturelabels">#name#<br /></cfoutput>