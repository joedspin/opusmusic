<!---<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,'  ',' ')
</cfquery>
<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,'  ',' ')
</cfquery>
<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,'  ',' ')
</cfquery>//--->
<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,', ]',']')
</cfquery>
<!---<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,'[','___')
</cfquery>
<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,'___ ','___')
</cfquery>
<!---<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,'___,','___')
</cfquery>
<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,'___]','')
</cfquery>
<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=replace(title,'___','[')
</cfquery>
<cfquery name="doReleaseDates" datasource="#DSN#">
	update catItems
    set title=rtrim(ltrim(title))
</cfquery>//--->