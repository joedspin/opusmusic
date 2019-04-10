<cfquery name="fixTrims" datasource="#DSN#">
	update catTracks
    set tname=RTrim(LTrim(tname))
</cfquery>