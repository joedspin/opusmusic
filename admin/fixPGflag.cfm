<cfquery name="fixPGflag" datasource="#DSN#">
	update catItems
    set pgFlag=1 where specialItem=1
</cfquery>