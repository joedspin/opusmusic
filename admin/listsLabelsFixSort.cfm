<cfsetting requesttimeout="6000">
<cfquery name="allLabels" datasource="#DSN#">
	select *
	from labels
	where sort<>'' AND sort Is Not Null AND sort LIKE '% %'
</cfquery>
<cfloop query="allLabels">
	<cfquery name="updateLabel" datasource="#DSN#">
		update labels
		set sort='#Replace(Ucase(allLabels.sort)," ","","all")#'
		where ID=#allLabels.ID#
	</cfquery>
</cfloop>
<cfquery name="allLabels" datasource="#DSN#">
	select *
	from labels
	where sort='' or sort Is Null
</cfquery>
<cfloop query="allLabels">
	<cfquery name="updateLabel" datasource="#DSN#">
		update labels
		set sort='#Replace(Ucase(allLabels.name)," ","","all")#'
		where ID=#allLabels.ID#
	</cfquery>
</cfloop>