<cfquery name="checkcostsave" datasource="#DSN#">
	select *
    from catItems
    where costSave<>0
</cfquery>
<cfoutput>#checkcostsave.recordCount#</cfoutput>
<cfquery name="fixcostsave" datasource="#DSN#">
	update catItems
    set costSave=0
</cfquery>