<cfquery name="fixLabelSort" datasource="#DSN#">
	select *
	from labels
	where sort='' OR sort IS Null
</cfquery>
<cfloop query="fixLabelSort">
<cfset newSort=UCase(Replace(Replace(Replace(Replace(Replace(name," ","","all"),".","","all"),"-","","all"),"(","","all"),")","","all"))>
<cfquery name="doFix"  datasource="#DSN#">
	update labels
	set sort='#newSort#'
	where ID=#ID#
</cfquery>
</cfloop>